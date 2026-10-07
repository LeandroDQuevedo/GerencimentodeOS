unit uFrmRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uDM, uService.OrdemServico,
  Vcl.CheckLst, Vcl.Mask;

type
  TFrmRelatorio = class(TForm)
    edtDataIni: TMaskEdit;
    edtDataFim: TMaskEdit;
    lbDataIn: TLabel;
    lbDataFin: TLabel;
    edtCliente: TEdit;
    lbCliente: TLabel;
    clbStatus: TCheckListBox;
    lbVlrMin: TLabel;
    edtValorMin: TEdit;
    lbVlrMax: TLabel;
    edtValorMax: TEdit;
    pbBotoes: TPanel;
    btnGerar: TButton;
    btnPDF: TButton;
    btnCSV: TButton;
    lbExportar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    FSQLOriginal: string;
  public
    { Public declarations }
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

procedure TFrmRelatorio.btnGerarClick(Sender: TObject);
var
  Filtro: TFiltroOS;
  Service: TOrdemServicoService;
  i: Integer;
begin
  if (edtDataIni.Text <> '  /  /    ') and (Pos(' ', edtDataIni.Text) > 0) then
  begin
    ShowMessage('Preencha o campo de data inicial corretamente!');
    Exit;
  end;
  if (edtDataFim.Text <> '  /  /    ') and (Pos(' ', edtDataFim.Text) > 0) then
  begin
    ShowMessage('Preencha o campo de data final corretamente!');
    Exit;
  end;

  Filtro := Default(TFiltroOS);
  Filtro.DataIni := StrToDateDef(edtDataIni.Text, 0);
  Filtro.DataFim := StrToDateDef(edtDataFim.Text, 0);
  Filtro.NomeCliente := edtCliente.Text;
  Filtro.ValorMin := StrToCurrDef(edtValorMin.Text, 0);
  Filtro.ValorMax := StrToCurrDef(edtValorMax.Text, 0);

  for i := 0 to clbStatus.Items.Count - 1 do
    if clbStatus.Checked[i] then
    begin
      SetLength(Filtro.ListaStatus, Length(Filtro.ListaStatus) + 1);
      Filtro.ListaStatus[High(Filtro.ListaStatus)] := clbStatus.Items[i];
    end;

  if Length(Filtro.ListaStatus) = 0 then
  begin
    ShowMessage('Selecione pelo menos uma situação.');
    Exit;
  end;

  if (Filtro.DataIni > 0) and (Filtro.DataFim > 0) and (Filtro.DataIni > Filtro.DataFim) then
  begin
    ShowMessage('A data inicial não pode ser maior que a data final.');
    Exit;
  end;

  Service := TOrdemServicoService.Create;
  try
    Service.AplicarFiltro(dmPrincipal.qrRelatorioOS, FSQLOriginal, Filtro,
      'ORDER BY OS.STATUS, OS.DATA_ABERTURA');
    dmPrincipal.qrRelatorioOS.Open;
  finally
    Service.Free;
  end;

  if dmPrincipal.qrRelatorioOS.IsEmpty then
  begin
    ShowMessage('Nenhuma Ordem de Serviço encontrada com esses filtros.');
    Exit;
  end;

  dmPrincipal.RelatorioOS.ShowReport;

end;

procedure TFrmRelatorio.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FSQLOriginal := dmPrincipal.qrRelatorioOS.SQL.Text;

  clbStatus.Items.Clear;
  clbStatus.Items.Add(STATUS_ABERTA);
  clbStatus.Items.Add(STATUS_EM_ANDAMENTO);
  clbStatus.Items.Add(STATUS_CONCLUIDA);
  clbStatus.Items.Add(STATUS_CANCELADA);
  for i := 0 to clbStatus.Items.Count - 1 do
    clbStatus.Checked[i] := True;
end;

procedure TFrmRelatorio.FormDestroy(Sender: TObject);
begin
  // A query fica no DM e sobrevive à tela: devolve o SQL original
  dmPrincipal.qrRelatorioOS.Close;
  dmPrincipal.qrRelatorioOS.SQL.Text := FSQLOriginal;
end;
end.
