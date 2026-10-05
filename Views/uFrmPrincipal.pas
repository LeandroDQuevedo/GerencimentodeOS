unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uModel.Classes,
  Data.DB, Vcl.DBCGrids, Vcl.DBCtrls, uFrmCadastroOS, uDM, uService.OrdemServico, uFrmAlterarStatus;

type
  TFrmPrincipal = class(TForm)
    pnFiltros: TPanel;
    btnInserir: TButton;
    btnLocalizar: TButton;
    edtPesquisa: TEdit;
    cbxFiltros: TComboBox;

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

    procedure FormCreate(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAbrirCardClick(Sender: TObject);
    procedure btnDeletarCardClick(Sender: TObject);
    procedure ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure btnAlterarStatusClick(Sender: TObject);
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
  dmPrincipal.qrListaOS.Open;
  btnLocalizarClick(nil);
end;


procedure TFrmPrincipal.btnLocalizarClick(Sender: TObject);
begin
  dmPrincipal.qrListaOS.Close;
  dmPrincipal.qrListaOS.SQL.Clear;
  dmPrincipal.qrListaOS.SQL.Add(FSQLOriginal);

  if (Trim(edtPesquisa.Text) <> '') and (cbxFiltros.ItemIndex >= 0) then
  begin
    dmPrincipal.qrListaOS.SQL.Add('WHERE');
    case cbxFiltros.ItemIndex of
      0:
      begin
        dmPrincipal.qrListaOS.SQL.Add(' OS.ID = :pFiltro');
        dmPrincipal.qrListaOS.ParamByName('pFiltro').AsInteger := StrToIntDef(edtPesquisa.Text, 0);
      end;
      1:
      begin
        dmPrincipal.qrListaOS.SQL.Add(' UPPER(C.NOME) LIKE :pFiltro');
        dmPrincipal.qrListaOS.ParamByName('pFiltro').AsString := '%' + UpperCase(Trim(edtPesquisa.Text)) + '%';
      end;
    end;
  end;

  dmPrincipal.qrListaOS.Open;
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

      if MessageDlg('Deseja realmente excluir a Ordem de Serviço nº ' + IntToStr(IDOrdem) + '?' + #13#10 +
        'Esta ação não pode ser desfeita.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
