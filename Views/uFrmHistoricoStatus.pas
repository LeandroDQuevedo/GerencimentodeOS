unit uFrmHistoricoStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmHistoricoStatus = class(TForm)
    grHistorico: TDBGrid;
    lbSemHistorico: TLabel;
    Panel1: TPanel;
    btnFechar: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    OrdemID: Integer;
  end;

var
  FrmHistoricoStatus: TFrmHistoricoStatus;

implementation

{$R *.dfm}

procedure TFrmHistoricoStatus.FormShow(Sender: TObject);
begin
  Caption := 'Histórico de situações - OS nº ' + IntToStr(OrdemID);

  dmPrincipal.qrHistoricoStatus.Close;
  dmPrincipal.qrHistoricoStatus.ParamByName('pOrdemID').AsInteger := OrdemID;
  dmPrincipal.qrHistoricoStatus.Open;

  lbSemHistorico.Visible := dmPrincipal.qrHistoricoStatus.IsEmpty;
end;

procedure TFrmHistoricoStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmPrincipal.qrHistoricoStatus.Close;
end;

end.
