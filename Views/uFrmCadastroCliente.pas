unit uFrmCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, uFuncoes,
  Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uService.OrdemServico, uDM, uService.Cliente;

type
  TFrmCadastroCliente = class(TForm)
    pnTipoinfo: TPanel;
    pnBtnFinal: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    btnDeletar: TButton;
    pnCampos: TPanel;
    lbCPF: TLabel;
    lbEmail: TLabel;
    lbTelefone: TLabel;
    lbNome: TLabel;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    edtNome: TEdit;
    mktCPF: TMaskEdit;
    grListaAdd: TDBGrid;
    btnAlterar: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure grListaAddKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure grListaAddCellClick(Column: TColumn);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCliente: TCliente; // Trocado ObjetoDeEnvio genérico por TCliente tipado
    IDEdicao: Integer;
  public
    { Public declarations }
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

procedure TFrmCadastroCliente.btnAlterarClick(Sender: TObject);
var
  FCliente : TCliente;
begin

  if dmPrincipal.qrCliente.IsEmpty then
  begin
    ShowMessage('Selecione um Cliente.');
    Exit;
  end;


  try
    FCliente := TCliente.Create;
    FCliente.Id := dmPrincipal.qrCliente.FieldByName('ID').AsInteger;
    FCliente.Nome := dmPrincipal.qrCliente.FieldByName('NOME').AsString;
    FCliente.Email := dmPrincipal.qrCliente.FieldByName('EMAIL').AsString;
    FCliente.Telefone := dmPrincipal.qrCliente.FieldByName('TELEFONE').AsString;
    FCliente.Documento := dmPrincipal.qrCliente.FieldByName('DOCUMENTO').AsString;

    edtNome.Text := FCliente.Nome;
    edtEmail.Text := FCliente.Email;
    edtTelefone.Text := FCliente.Telefone;
    mktCPF.Text := FCliente.Documento;

    IDEdicao := FCliente.Id;
    btnSalvar.Caption := 'Atualizar';
  finally
    FCliente.Free;
  end;
end;

procedure TFrmCadastroCliente.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastroCliente.btnDeletarClick(Sender: TObject);
var
  IDCliente: Integer;
  Service: TClienteService;
begin

  if dmPrincipal.qrCliente.IsEmpty then
  begin
    ShowMessage('Selecione um Cliente.');
    Exit;
  end;
  IDCliente := dmPrincipal.qrCliente.FieldByName('ID').AsInteger;
  Service := TClienteService.Create;

  try
    if ConfirmarAcao('Deseja excluir o cliente?') then
    begin
      try
        Service.DeletarCliente(IDCliente, dmPrincipal.ConexaoBanco);
        ShowMessage('Cliente excluído com sucesso.');
        grListaAdd.DataSource.DataSet.Close;
        grListaAdd.DataSource.DataSet.Open;
      except
      on E: Exception do
        ShowMessage(E.Message);
    end;
    end;
  finally
    Service.Free;
  end;
end;

procedure TFrmCadastroCliente.btnSalvarClick(Sender: TObject);
var
  Service: TClienteService;
begin
  if trim(edtNome.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Nome!');
    exit;
  end;
  if trim(edtTelefone.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Telefone!');
    exit;
  end;
  if trim(edtEmail.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Email!');
    exit;
  end;
   if Pos(' ', mktCPF.Text) > 0 then
  begin
    ShowMessage('Preencha o campo do CPF!');
    exit;
  end;

  FCliente := TCliente.Create;
  try
    FCliente.Id := IDEdicao;
    FCliente.Nome      := edtNome.Text;
    FCliente.Telefone  := edtTelefone.Text;
    FCliente.Documento := mktCPF.Text;
    FCliente.Email     := edtEmail.Text;

    Service := TClienteService.Create;
    try
      if IDEdicao = 0 then
      begin
        if Service.SalvarCliente(FCliente, dmPrincipal.ConexaoBanco) then
          ShowMessage('Novo cadastro de Cliente salvo com sucesso!')
        else
          ShowMessage('Erro ao salvar o novo cadastro de Cliente.');
      end
      else
      begin
        if Service.AtualizarCliente(FCliente, dmPrincipal.ConexaoBanco) then
          begin
          ShowMessage('Alterado o Cadastro com sucesso!');
          btnSalvar.Caption := 'Salvar';
          IDEdicao := 0;
          end
        else
          ShowMessage('Erro ao salvar o cadastro de Cliente.');
      end;


    finally
      Service.Free;

      if grListaAdd.DataSource <> nil then
      begin
        grListaAdd.DataSource.DataSet.Close;
        grListaAdd.DataSource.DataSet.Open;
      end;

      edtNome.Text := '';
      edtEmail.Text := '';
      edtTelefone.Text := '';
      mktCPF.Text := '';
    end;
  finally
    FCliente.Free;
  end;
end;

procedure TFrmCadastroCliente.FormShow(Sender: TObject);
begin
  grListaAdd.DataSource.DataSet.Open;
end;

procedure TFrmCadastroCliente.grListaAddCellClick(Column: TColumn);
var
  Service: TOrdemServicoService;
  IDCliente: Integer;
begin
  Service := TOrdemServicoService.Create;
  try
    if grListaAdd.DataSource.DataSet.IsEmpty then
      Exit;

    IDCliente := grListaAdd.DataSource.DataSet.FieldByName('ID').AsInteger;

    if Service.RetornaNumeroOSPorCliente(IDCliente, dmPrincipal.ConexaoBanco) > 0 then
      btnDeletar.Enabled := False
    else
      btnDeletar.Enabled := True;
  finally
    Service.Free;
  end;
end;

procedure TFrmCadastroCliente.grListaAddKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  grListaAddCellClick(nil);
end;

end.
