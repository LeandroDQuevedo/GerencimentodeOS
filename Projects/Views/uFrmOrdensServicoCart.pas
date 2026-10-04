unit uFrmOrdensServicoCart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmOrdensServicoCart = class(TForm)
    Panel1: TPanel;
    imOS: TImage;
    lbCliente: TLabel;
    edtCliente: TEdit;
    edtDataEnt: TEdit;
    lbDataEnt: TLabel;
    lbStatus: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOrdensServicoCart: TFrmOrdensServicoCart;

implementation

{$R *.dfm}
end.
