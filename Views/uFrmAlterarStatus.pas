unit uFrmAlterarStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uModel.Classes, uService.OrdemServico, uDM,
  Vcl.StdCtrls;

type
  TFrmAlterarStatus = class(TForm)
    lbStatusAtual: TLabel;
    cbxStatus: TComboBox;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrdemID: Integer;
    StatusAtual: string;
  end;

var
  FrmAlterarStatus: TFrmAlterarStatus;

implementation

{$R *.dfm}

procedure TFrmAlterarStatus.btnCancelarClick(Sender: TObject);
begin
  Caption := 'Alterar Situação - OS nº ' + IntToStr(OrdemID);
  lbStatusAtual.Caption := 'Situação atual: ' + StatusAtual;
  cbxStatus.ItemIndex := cbxStatus.Items.IndexOf(StatusAtual);
end;

procedure TFrmAlterarStatus.btnConfirmarClick(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  Service := TOrdemServicoService.Create;
  try
    try
      if Service.AlterarStatus(OrdemID, StatusAtual, cbxStatus.Text, dmPrincipal.ConexaoBanco) then
      begin
        ShowMessage('Situação alterada para "' + cbxStatus.Text + '".');
        Close;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Service.Free;
  end;
end;

procedure TFrmAlterarStatus.FormShow(Sender: TObject);
begin
  Close;
end;


end.
