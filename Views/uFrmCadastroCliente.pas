unit uFrmCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uService.OrdemServico;

type
  TForm1 = class(TForm)
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
  private
    { Private declarations }
    ObjetoDeEnvio: TObject;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnSalvarClick(Sender: TObject);
var
    Service: TOrdemServicoService;
    MensagemRetorno: String;
begin
  if trim(edtNome.Text) = '' then
            begin
              ShowMessage('Preencha o campo do Nome!');
              exit;
            end;
          if trim(edtTelefone.Text) = '' then
            begin
              ShowMessage('Preencha o campo do Endereço!');
              exit;
            end;
          if (trim(mktCPF.Text) = '') or (Length(mktCPF.Text) < 14) then
            begin
              ShowMessage('Preencha o campo do CNPJ!');
              exit;
            end;
          ObjetoDeEnvio := TCliente.Create;
          TCliente(ObjetoDeEnvio).Nome  := edtNome.Text;
          TCliente(ObjetoDeEnvio).Telefone := edtTelefone.Text;
          TCliente(ObjetoDeEnvio).Documento := mktCPF.Text;
          TCliente(ObjetoDeEnvio).Email := edtEmail.Text;
          MensagemRetorno := 'Cliente';
        end;


    Service := TOrdemServicoService.Create;
    try
      if  Service.SalvarInfoAdicional(ObjetoDeEnvio, TipoInfoCadastro, dmPrincipal.ConexaoBanco) then
        ShowMessage('Novo cadastro de ' + MensagemRetorno + 'salvo com sucesso!')
      else
        begin
          ShowMessage('Erro ao salvar o novo cadastro de ' + MensagemRetorno);
        end;

    finally
      Service.Free;
      grListaAdd.DataSource.DataSet.Close;
      grListaAdd.DataSource.DataSet.Open;
      edtNome.Text := '';
      edtDescricao.Text := '';
      edtSigla.Text := '';
      edtEndereco.Text := '';
      mktCnpj.Text := '';
end;

end.
