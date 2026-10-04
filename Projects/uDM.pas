unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmPrincipal = class(TDataModule)
    ConexaoBanco: TFDConnection;
    BancoImanges: TImageCollection;
    ListaImagens: TVirtualImageList;
    qrListaOS: TFDQuery;
    dsListaOS: TDataSource;
    qrCliente: TFDQuery;
    dsCliente: TDataSource;
    qrListaOSID: TIntegerField;
    qrListaOSDATA_ABERTURA: TDateField;
    qrListaOSSTATUS: TWideStringField;
    qrListaOSVALOR_TOTAL: TFMTBCDField;
    qrListaOSNOME_CLIENTE: TWideStringField;
    qrListaOSFOTO: TBlobField;
    qrClienteID: TIntegerField;
    qrClienteNOME: TWideStringField;
    qrClienteDOCUMENTO: TWideStringField;
    qrClienteEMAIL: TWideStringField;
    qrClienteTELEFONE: TWideStringField;
    qrClienteDATACADASTRO: TSQLTimeStampField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



end.
