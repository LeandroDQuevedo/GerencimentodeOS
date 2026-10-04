unit frmOrdensServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
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
  Form1: TForm1;

implementation

{$R *.dfm}
end.
