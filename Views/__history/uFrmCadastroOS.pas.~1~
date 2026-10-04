unit uFrmCadastroOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TFormCadastroOS = class(TForm)
    btnAdicionarFoto: TButton;
    Image1: TImage;
    edtDescricao: TEdit;
    lbDescricao: TLabel;
    edtDataEnt: TMaskEdit;
    edtDataPrev: TMaskEdit;
    lbDataEnt: TLabel;
    lbDataPrev: TLabel;
    cbxCategoria: TDBLookupComboBox;
    btnAddCliente: TButton;
    LabCliente: TLabel;
    LabQntdeUnidMed: TLabel;
    edtQntd: TEdit;
    cbxItem: TDBLookupComboBox;
    btnAddUnidMed: TButton;
    lbQntd: TLabel;
    procedure btnAdicionarFotoClick(Sender: TObject);
    procedure lbDescricaoClick(Sender: TObject);
    procedure LabClienteClick(Sender: TObject);
    procedure LabQntdeUnidMedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroOS: TFormCadastroOS;

implementation

{$R *.dfm}

procedure TFormCadastroOS.btnAdicionarFotoClick(Sender: TObject);
  begin
    if OpenPictureDialog1.Execute then
    begin
      // Carrega na tela para o usuário ver
      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    end;
  end;

end.
