unit uFrmRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst, Vcl.Mask;

type
  TFrmRelatorio = class(TForm)
    edtDataIni: TMaskEdit;
    edtDataFim: TMaskEdit;
    lbDataIn: TLabel;
    lbDataFin: TLabel;
    edtCliente: TEdit;
    lbCliente: TLabel;
    CheckListBox1: TCheckListBox;
    lbVlrMin: TLabel;
    edtValorMin: TEdit;
    lbVlrMax: TLabel;
    edtValorMax: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

end.
