unit uFrmCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uService.OrdemServico, uDM; // Adicionado uDM e ajustado uModel.OrdemServico

type
  TFrmCadastroCliente = class(TForm)
    pnTipoinfo: TPanel;
    pnBtnFinal: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
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
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure grListaAddKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grListaAddCellClick(Column: TColumn);
  private
    { Private declarations }
    FCliente: TCliente; // Trocado ObjetoDeEnvio genérico por TCliente tipado
  public
    { Public declarations }
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

procedure TFrmCadastroCliente.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastroCliente.BtnSalvarClick(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  if trim(edtNome.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Nome!');
    exit;
  end;
  if trim(edtTelefone.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Telefone!'); // Corrigido a mensagem
    exit;
  end;
  if trim(edtEmail.Text) = '' then
  begin
    ShowMessage('Preencha o campo do Email!');
    exit;
  end;
  if (trim(mktCPF.Text) = '') or (Length(mktCPF.Text) < 14) then
  begin
    ShowMessage('Preencha o campo do CPF!'); // Corrigido a mensagem
    exit;
  end;

  FCliente := TCliente.Create;
  try
    FCliente.Nome      := edtNome.Text;
    FCliente.Telefone  := edtTelefone.Text;
    FCliente.Documento := mktCPF.Text;
    FCliente.Email     := edtEmail.Text;

    Service := TOrdemServicoService.Create;
    try
      if Service.SalvarCliente(FCliente, dmPrincipal.ConexaoBanco) then
        ShowMessage('Novo cadastro de Cliente salvo com sucesso!')
      else
        ShowMessage('Erro ao salvar o novo cadastro de Cliente.');

    finally
      Service.Free;

      if grListaAdd.DataSource <> nil then
      begin
        grListaAdd.DataSource.DataSet.Close;
        grListaAdd.DataSource.DataSet.Open;
      end;

      // Limpeza apenas dos campos que realmente existem nesta tela
      edtNome.Text := '';
      edtEmail.Text := '';
      edtTelefone.Text := '';
      mktCPF.Text := '';
    end;
  finally
    FCliente.Free;
  end;
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
