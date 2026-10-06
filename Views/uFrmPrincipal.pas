unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes, uFuncoes, uFrmCadastroCliente,
  Data.DB, Vcl.DBCGrids, Vcl.DBCtrls, uFrmCadastroOS, uDM, uService.OrdemServico, uFrmAlterarStatus,
  Vcl.Mask;

type
  TFrmPrincipal = class(TForm)
    pnFiltros: TPanel;
    btnInserir: TButton;
    btnLocalizar: TButton;

    // Componente de grelha de cartões
    ctrlGridOS: TDBCtrlGrid;

    // Componentes visuais que ficarão DENTRO do painel base do ctrlGridOS (O seu "Cartão")
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
    Label1: TLabel;
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

    procedure FormCreate(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAbrirCardClick(Sender: TObject);
    procedure btnDeletarCardClick(Sender: TObject);
    procedure ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure btnAlterarStatusClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
  private
    FSQLOriginal: string;
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FSQLOriginal := dmPrincipal.qrListaOS.SQL.Text;

  // O ctrlGridOS precisa de estar ligado ao DataSource, da mesma forma que a Grid antiga
  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnLocalizarClick(Sender: TObject);
var
  Filtro: TFiltroOS;
  Service: TOrdemServicoService;
begin
  if (Filtro.DataIni > 0) and (Filtro.DataFim > 0) and (Filtro.DataIni > Filtro.DataFim) then
  begin
    ShowMessage('A data inicial não pode ser maior que a data final.');
    Exit;
  end;

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

  Service := TOrdemServicoService.Create;
  try
    Service.AplicarFiltro(dmPrincipal.qrListaOS, FSQLOriginal, Filtro,
      'ORDER BY OS.DATA_ABERTURA DESC, OS.ID DESC');
    dmPrincipal.qrListaOS.Open;
  finally
    Service.Free;
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
  end

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
begin
  // Pinta só o cartão atual. Mudar DBCtrlGrid.Color repinta a grade inteira em loop.
  if dmPrincipal.qrListaOS.FieldByName('STATUS').AsString = STATUS_CANCELADA then
    DBCtrlGrid.Canvas.Brush.Color := $006979E9
  else
    DBCtrlGrid.Canvas.Brush.Color := clWhite;

  DBCtrlGrid.Canvas.FillRect(Rect(0, 0, DBCtrlGrid.PanelWidth, DBCtrlGrid.PanelHeight));
end;


end.
