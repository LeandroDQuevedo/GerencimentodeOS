unit uFrmOrdensServicoCart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TOrdensServicoCart = class(TForm)
    Panel1: TPanel;
    imOS: TImage;
    lbCliente: TLabel;
    edtCliente: TEdit;
    edtDataEnt: TEdit;
    lbDataEnt: TLabel;
    lbStatus: TLabel;
    procedure lbDataEntClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrdensServicoCart: TOrdensServicoCart;

implementation

{$R *.dfm}
end.
