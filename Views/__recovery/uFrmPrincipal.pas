unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.DBCGrids, Vcl.DBCtrls, uFrmCadastroOS, uDM, uService.OrdemServico;

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
    txtDataOS: TDBText;
    txtValorTotal: TDBText;
    btnAbrirCard: TButton;
    btnDeletarCard: TButton;
    pnBotoes: TPanel;
    Panel1: TPanel;
    DBImage1: TDBImage;

    procedure FormCreate(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAbrirCardClick(Sender: TObject);
    procedure btnDeletarCardClick(Sender: TObject);
    procedure ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
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

  if Trim(edtPesquisa.Text) <> '' then
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
        dmPrincipal.qrListaOS.SQL.Add(' C.NOME LIKE :pFiltro');
        dmPrincipal.qrListaOS.ParamByName('pFiltro').AsString := '%' + Trim(edtPesquisa.Text) + '%';
      end;
    end;

//    if ckbAberto.Checked and not ckbFechado.Checked then
//      dmPrincipal.qrListaOS.SQL.Add(' AND OS.STATUS = ''ABERTO''')
//    else if ckbFechado.Checked and not ckbAberto.Checked then
//      dmPrincipal.qrListaOS.SQL.Add(' AND OS.STATUS = ''FECHADO''');
//  end
//  else
//  begin
//    if ckbAberto.Checked and not ckbFechado.Checked then
//      dmPrincipal.qrListaOS.SQL.Add('WHERE OS.STATUS = ''ABERTO''')
//    else if ckbFechado.Checked and not ckbAberto.Checked then
//      dmPrincipal.qrListaOS.SQL.Add('WHERE OS.STATUS = ''FECHADO''');
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
    frmCadastroOS.cbxCliente.ListSource.DataSet.Open;
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
  // Como o botão está DENTRO do cartão, clicar nele automaticamente move o
  // cursor do banco de dados (qrListaOS) para o registo correto.
  frmCadastroOS := TFrmCadastroOS.Create(nil);
  try
    frmCadastroOS.OrdemIDEdicao := dmPrincipal.qrListaOS.FieldByName('ID').AsInteger;
    frmCadastroOS.ShowModal;
  finally
    frmCadastroOS.Free;
  end;

  btnLocalizarClick(nil);
end;

procedure TFrmPrincipal.btnDeletarCardClick(Sender: TObject);
var
  IDOrdem: Integer;
  Service: TOrdemServicoService;
begin
  if dmPrincipal.qrListaOS.FieldByName('STATUS').AsString <> 'ABERTO' then
  begin
    ShowMessage('Apenas Ordens de Serviço em ABERTO podem ser canceladas.');
    Exit;
  end;

  if MessageDlg('Deseja realmente cancelar esta Ordem de Serviço?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Service := TOrdemServicoService.Create;
    try
      IDOrdem := dmPrincipal.qrListaOS.FieldByName('ID').AsInteger;

      if Service.Deletar(IDOrdem, dmPrincipal.ConexaoBanco) then
      begin
        ShowMessage('Ordem de Serviço cancelada com sucesso.');
        btnLocalizarClick(nil);
      end
      else
        ShowMessage('Erro ao tentar cancelar a Ordem de Serviço.');
    finally
      Service.Free;
    end;
  end;
end;

procedure TFrmPrincipal.ctrlGridOSPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
begin
  // Evento estético: Pode usar este evento para mudar a cor de fundo do cartão dependendo do status.
  // Exemplo: se estiver cancelado, pinta de cinzento. Se aberto, pinta de branco.
  if dmPrincipal.qrListaOS.FieldByName('STATUS').AsString = 'ABERTO' then
    DBCtrlGrid.Color := clWhite
  else
    DBCtrlGrid.Color := clRed; // Cinzento claro
end;

end.
