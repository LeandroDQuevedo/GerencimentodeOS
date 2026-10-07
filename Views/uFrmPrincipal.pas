unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uLog,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uFuncoes, uFrmCadastroCliente,
  Data.DB, Vcl.DBCGrids, Vcl.DBCtrls, uFrmCadastroOS, uDM, uService.OrdemServico, uFrmAlterarStatus, uFrmRelatorio,
  Vcl.Mask;

type
  TFrmPrincipal = class(TForm)
    pnFiltros: TPanel;
    btnInserir: TButton;
    btnLocalizar: TButton;
    ctrlGridOS: TDBCtrlGrid;
    txtNomeCliente: TDBText;
    txtStatusOS: TDBText;
    txtValorTotal: TDBText;
    btnAbrirCard: TButton;
    btnDeletarCard: TButton;
    pnBotoes: TPanel;
    Panel1: TPanel;
    txtDataOS: TDBText;
    DBImage1: TDBImage;
    lbNomeCliente: TLabel;
    btnAlterarStatus: TButton;
    btnClientes: TButton;
    edtDataFim: TMaskEdit;
    edtDataIni: TMaskEdit;
    lbDataEnt: TLabel;
    lbDataFin: TLabel;
    lbDataIn: TLabel;
    lbNumOs: TLabel;
    edtNumOS: TEdit;
    lbCliente: TLabel;
    edtCliente: TEdit;
    cbxStatus: TComboBox;
    edtValorMin: TEdit;
    edtValorMax: TEdit;
    lbVlrMin: TLabel;
    lbVlrMax: TLabel;
    lbValores: TLabel;
    lbStatus: TLabel;
    edtLimite: TEdit;
    txtNumeroOS: TDBText;
    Bevel1: TBevel;
    txtDataPrev: TDBText;
    Panel20: TPanel;
    txtTotalAberta: TDBText;
    lbAbertas: TLabel;
    lbEmAndamento: TLabel;
    txtTotalAndamento: TDBText;
    lbConcluidas: TLabel;
    txtTotalConcluidas: TDBText;
    lbEmAtraso: TLabel;
    txtTotalAtraso: TDBText;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnRelatorio: TButton;
    Panel2: TPanel;
    lbCanceladas: TLabel;
    txtTotalCanceladas: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAbrirCardClick(Sender: TObject);
    procedure btnDeletarCardClick(Sender: TObject);
    procedure ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure btnAlterarStatusClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure btnRelatorioClick(Sender: TObject);

  private
    FSQLOriginal: string;
    procedure AtualizarTotalizadores;
    procedure TratarExcecao(Sender: TObject; E: Exception);
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Application.OnException := TratarExcecao;
  FSQLOriginal := dmPrincipal.qrListaOS.SQL.Text;
  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  // Só rola se o mouse estiver em cima do grid e a lista estiver aberta
  if not dmPrincipal.qrListaOS.Active then
    Exit;
  if not PtInRect(ctrlGridOS.ClientRect, ctrlGridOS.ScreenToClient(MousePos)) then
    Exit;

  // Cada "clique" da rodinha anda uma linha de cartões
  if WheelDelta < 0 then
    dmPrincipal.qrListaOS.MoveBy(ctrlGridOS.ColCount)
  else
    dmPrincipal.qrListaOS.MoveBy(-ctrlGridOS.ColCount);

  Handled := True;
end;

procedure TFrmPrincipal.btnLocalizarClick(Sender: TObject);
var
  Filtro: TFiltroOS;
  Service: TOrdemServicoService;
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
  Filtro.NumeroOS := StrToIntDef(edtNumOS.Text, 0);
  if cbxStatus.ItemIndex > 0 then
    Filtro.Status := cbxStatus.Text;
  Filtro.NomeCliente := edtCliente.Text;
  Filtro.ValorMin := StrToCurrDef(edtValorMin.Text, 0);
  Filtro.ValorMax := StrToCurrDef(edtValorMax.Text, 0);
  Filtro.Limite := StrToIntDef(edtLimite.Text, 50);

  if (Filtro.DataIni > 0) and (Filtro.DataFim > 0) and (Filtro.DataIni > Filtro.DataFim) then
  begin
    ShowMessage('A data inicial não pode ser maior que a data final.');
    Exit;
  end;

  Service := TOrdemServicoService.Create;
  try
    Service.AplicarFiltro(dmPrincipal.qrListaOS, FSQLOriginal, Filtro,
      'ORDER BY OS.DATA_ABERTURA DESC, OS.ID DESC');

    dmPrincipal.qrListaOS.Open;
  finally
    Service.Free;
  end;
  AtualizarTotalizadores;
end;

procedure TFrmPrincipal.btnRelatorioClick(Sender: TObject);
var
  frmRelatorio: TFrmRelatorio;
begin
  frmRelatorio := TFrmRelatorio.Create(nil);
  try
    frmRelatorio.ShowModal;
  finally
    frmRelatorio.Free;
  end;
end;

procedure TFrmPrincipal.btnInserirClick(Sender: TObject);
var
  frmCadastroOS: TFrmCadastroOS;
begin
  frmCadastroOS := TFrmCadastroOS.Create(nil);
  try
    frmCadastroOS.OrdemIDEdicao := 0;
    frmCadastroOS.ShowModal;
  finally
    frmCadastroOS.Free;
  end;

  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnAbrirCardClick(Sender: TObject);
var
  frmCadastroOS: TFrmCadastroOS;
begin
  if dmPrincipal.qrListaOS.IsEmpty then
  begin
    ShowMessage('Selecione uma Ordem de Serviço.');
    Exit;
  end;
  frmCadastroOS := TFrmCadastroOS.Create(nil);
  try
    frmCadastroOS.OrdemIDEdicao := dmPrincipal.qrListaOS.FieldByName('ID').AsInteger;
    frmCadastroOS.ShowModal;
  finally
    frmCadastroOS.Free;
  end;

  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnAlterarStatusClick(Sender: TObject);
var
  frmStatus: TFrmAlterarStatus;
begin
  if dmPrincipal.qrListaOS.IsEmpty then
  begin
    ShowMessage('Selecione uma Ordem de Serviço.');
    Exit;
  end;

  frmStatus := TFrmAlterarStatus.Create(nil);
  try
    frmStatus.OrdemID := dmPrincipal.qrListaOS.FieldByName('ID').AsInteger;
    frmStatus.StatusAtual := dmPrincipal.qrListaOS.FieldByName('STATUS').AsString;
    frmStatus.ShowModal;
  finally
    frmStatus.Free;
  end;

  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnClientesClick(Sender: TObject);
var
  frmCadastroCliente: TFrmCadastroCliente;
begin
  frmCadastroCliente := TFrmCadastroCliente.Create(nil);
  try
    frmCadastroCliente.ShowModal;
  finally
    frmCadastroCliente.Free;
  end;
  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnDeletarCardClick(Sender: TObject);
var
  IDOrdem: Integer;
  Service: TOrdemServicoService;
begin
  if dmPrincipal.qrListaOS.IsEmpty then
  begin
    ShowMessage('Selecione uma Ordem de Serviço.');
    Exit;
  end;

  IDOrdem := dmPrincipal.qrListaOS.FieldByName('ID').AsInteger;

  Service := TOrdemServicoService.Create;
  try
    try
      Service.ValidarExclusao(dmPrincipal.qrListaOS.FieldByName('STATUS').AsString);

      if ConfirmarAcao('Deseja realmente excluir a Ordem de Serviço nº ' + IntToStr(IDOrdem) + '?' + #13#10 +
        'Esta ação não pode ser desfeita.') then
      begin
        Service.Deletar(IDOrdem, dmPrincipal.ConexaoBanco);
        ShowMessage('Ordem de Serviço excluída com sucesso.');
        btnLocalizarClick(nil);
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Service.Free;
  end;
end;

procedure TFrmPrincipal.ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
const
  ALTURA_FAIXA = 30;
  ALTURA_SELO = 22;
var
  Status: string;
  CorFaixa: TColor;
  Selo: TRect;
begin
  // Desenha só o cartão atual (mudar DBCtrlGrid.Color repintaria a grade inteira em loop)
  Status := dmPrincipal.qrListaOS.FieldByName('STATUS').AsString;

  if Status = STATUS_ABERTA then
    CorFaixa := $00C07830              // azul
  else if Status = STATUS_EM_ANDAMENTO then
    CorFaixa := $000080FF              // laranja
  else if Status = STATUS_CONCLUIDA then
    CorFaixa := $0050A050              // verde
  else
    CorFaixa := $00909090;             // cinza (cancelada)

  // Fundo branco
  DBCtrlGrid.Canvas.Brush.Color := clWhite;
  DBCtrlGrid.Canvas.FillRect(Rect(0, 0, DBCtrlGrid.PanelWidth, DBCtrlGrid.PanelHeight));

  // Faixa da situação
  DBCtrlGrid.Canvas.Brush.Color := CorFaixa;
  DBCtrlGrid.Canvas.FillRect(Rect(0, 0, DBCtrlGrid.PanelWidth, ALTURA_FAIXA));

  // Borda do cartão
  DBCtrlGrid.Canvas.Pen.Color := $00D0D0D0;
  DBCtrlGrid.Canvas.Brush.Style := bsClear;
  DBCtrlGrid.Canvas.Rectangle(0, 0, DBCtrlGrid.PanelWidth, DBCtrlGrid.PanelHeight);
  DBCtrlGrid.Canvas.Brush.Style := bsSolid;

  // Selo de atraso, só nas atrasadas
  if TOrdemServico.CalcularAtraso(Status, dmPrincipal.qrListaOS.FieldByName('DATA_PREVISTA').AsDateTime) then
  begin
    Selo := Rect(40, DBCtrlGrid.PanelHeight - ALTURA_SELO - 8,
                 DBCtrlGrid.PanelWidth - 40, DBCtrlGrid.PanelHeight - 8);
    DBCtrlGrid.Canvas.Brush.Color := clRed;
    DBCtrlGrid.Canvas.FillRect(Selo);
    DBCtrlGrid.Canvas.Font.Color := clWhite;
    DBCtrlGrid.Canvas.Font.Style := [fsBold];
    DrawText(DBCtrlGrid.Canvas.Handle, PChar('ATRASADA'), -1, Selo,
             DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TFrmPrincipal.AtualizarTotalizadores;
begin
  dmPrincipal.qrTotalizadores.Close;
  dmPrincipal.qrTotalizadores.ParamByName('pAberta').AsString := STATUS_ABERTA;
  dmPrincipal.qrTotalizadores.ParamByName('pEmAndamento').AsString := STATUS_EM_ANDAMENTO;
  dmPrincipal.qrTotalizadores.ParamByName('pConcluida').AsString := STATUS_CONCLUIDA;
  dmPrincipal.qrTotalizadores.ParamByName('pCancelada').AsString := STATUS_CANCELADA;

  dmPrincipal.qrTotalizadores.Open;
end;

procedure TFrmPrincipal.TratarExcecao(Sender: TObject; E: Exception);
begin
  GravarLog('ERRO', E.ClassName + ': ' + E.Message);
  Application.ShowException(E);
end;

end.
