unit uFrmCadastroOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uFuncoes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  uService.Imagem, Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.ComCtrls, uFrmCadastroCliente, uModel.Classes, uService.OrdemServico, uDM;

type
  TFrmCadastroOS = class(TForm)
    btnAdicionarFoto: TButton;
    Image1: TImage;
    edtDescricao: TEdit; // Descrição do problema/OS
    lbDescricao: TLabel;
    edtDataEnt: TMaskEdit;
    edtDataPrev: TMaskEdit;
    lbDataEnt: TLabel;
    lbDataPrev: TLabel;
    cbxCliente: TDBLookupComboBox;
    btnAddCliente: TButton;
    lbCliente: TLabel;

    // Campos dos Itens da OS
    edtDescricaoItem: TEdit;
    edtQntd: TEdit;
    edtValor: TEdit;
    btnAdicionarItem: TButton;

    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    LsvMovimentacoes: TListView;
    Panel2: TPanel;
    btnRemoveItem: TButton;
    btnAlterarItem: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTotal: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarFotoClick(Sender: TObject);
    procedure btnAddClienteClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure btnAlterarItemClick(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
  private
    IndiceItemEdicao : Integer;
    FOrdem: TOrdemServico;
    procedure AtualizarListaVisual;
    procedure CarregarDadosEdicao;
  public
    { Public declarations }
    OrdemIDEdicao: Integer;
  end;

var
  FrmCadastroOS: TFrmCadastroOS;

implementation

{$R *.dfm}

procedure TFrmCadastroOS.FormCreate(Sender: TObject);
begin
  cbxCliente.ListSource.DataSet.Open;
  FOrdem := TOrdemServico.Create;

  LsvMovimentacoes.ViewStyle := vsReport;
  LsvMovimentacoes.Columns.Clear;
  LsvMovimentacoes.Columns.Add.Caption := 'Descrição do Item';
  LsvMovimentacoes.Columns[0].Width := 250;
  LsvMovimentacoes.Columns.Add.Caption := 'Quantidade';
  LsvMovimentacoes.Columns[1].Width := 80;
  LsvMovimentacoes.Columns.Add.Caption := 'Val. Unitário';
  LsvMovimentacoes.Columns[2].Width := 100;
  LsvMovimentacoes.Columns.Add.Caption := 'Total';
  LsvMovimentacoes.Columns[3].Width := 100;

  IndiceItemEdicao := -1;
end;

procedure TFrmCadastroOS.FormDestroy(Sender: TObject);
begin
  FOrdem.Free;
end;

procedure TFrmCadastroOS.btnAddClienteClick(Sender: TObject);
var
  frmCadastroCliente: TFrmCadastroCliente;
begin
  frmCadastroCliente := TFrmCadastroCliente.Create(nil);
  try
    frmCadastroCliente.ShowModal;
  finally
    frmCadastroCliente.Free;
  end;
end;

procedure TFrmCadastroOS.btnAdicionarFotoClick(Sender: TObject);
var
  ServiceImagem: TImagemService;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    FOrdem.Imagem.Clear;
    Image1.Picture.Graphic.SaveToStream(FOrdem.Imagem);

    ServiceImagem := TImagemService.Create;
    try
      ServiceImagem.GerarMiniatura(Image1.Picture.Graphic, FOrdem.Miniatura, 160);
    finally
      ServiceImagem.Free;
    end;
  end;
end;

procedure TFrmCadastroOS.btnAdicionarItemClick(Sender: TObject);
var
  FItem: TItemOrdem;
begin
  // Validações
  if Trim(edtDescricaoItem.Text) = '' then
  begin
    ShowMessage('Por favor, informe a descrição do item.');
    edtDescricaoItem.SetFocus;
    Exit;
  end;

  if (Trim(edtQntd.Text) = '') or (StrToFloatDef(edtQntd.Text, 0) <= 0) then
  begin
    ShowMessage('A quantidade informada deve ser maior que 0.');
    edtQntd.SetFocus;
    Exit;
  end;

  if (Trim(edtValor.Text) = '') or (StrToCurrDef(edtValor.Text, 0) <= 0) then
  begin
    ShowMessage('Informe um valor unitário válido.');
    edtValor.SetFocus;
    Exit;
  end;


  // Adição e recálculo
  if IndiceItemEdicao = -1 then
  begin
    FItem := TItemOrdem.Create;
    FOrdem.Itens.Add(FItem);
  end
  else
  begin
    FItem := FOrdem.Itens[IndiceItemEdicao];
    IndiceItemEdicao := -1;
    btnAdicionarItem.Caption := 'Adicionar';
  end;

  FItem.Descricao := Trim(edtDescricaoItem.Text);
  FItem.Quantidade := StrToFloat(edtQntd.Text);
  FItem.ValorUnitario := StrToCurr(edtValor.Text);
  FOrdem.RecalcularTotal;
  AtualizarListaVisual;

  // Limpeza para o próximo
  edtDescricaoItem.Text := '';
  edtQntd.Text := '';
  edtValor.Text := '';
  edtDescricaoItem.SetFocus;
end;

procedure TFrmCadastroOS.btnAlterarItemClick(Sender: TObject);
var
  FItem : TItemOrdem;
begin
  if LsvMovimentacoes.Selected = nil then
  begin
    ShowMessage('Selecione um Item.');
    Exit;
  end;

  btnAdicionarItem.Caption := '*Confirmar*';
  FItem := FOrdem.Itens[LsvMovimentacoes.ItemIndex];
  IndiceItemEdicao := LsvMovimentacoes.ItemIndex;
  edtDescricaoItem.Text := FItem.Descricao;
  edtValor.Text := CurrToStr(FItem.ValorUnitario);
  edtQntd.Text := FloatToStr(FItem.Quantidade);
end;

procedure TFrmCadastroOS.btnRemoveItemClick(Sender: TObject);
begin
  if LsvMovimentacoes.Selected = nil then
  begin
    ShowMessage('Selecione um Item.');
    Exit;
  end;
  if ConfirmarAcao('Deseja remover o item da lista?') then
  begin
    FOrdem.Itens.Delete(LsvMovimentacoes.ItemIndex);
    edtDescricaoItem.Text := '';
    edtQntd.Text := '';
    edtValor.Text := '';
    edtDescricaoItem.SetFocus;
    IndiceItemEdicao := -1;
    btnAdicionarItem.Caption := 'Adicionar';
    FOrdem.RecalcularTotal;
    AtualizarListaVisual;
  end;

end;


procedure TFrmCadastroOS.AtualizarListaVisual;
var
  Item: TItemOrdem;
  Linha: TListItem;
begin
  LsvMovimentacoes.Items.Clear;

  for Item in FOrdem.Itens do
  begin
    Linha := LsvMovimentacoes.Items.Add;
    Linha.Caption := Item.Descricao;
    Linha.SubItems.Add(FloatToStr(Item.Quantidade));
    Linha.SubItems.Add(FormatFloat('#,##0.00', Item.ValorUnitario));
    Linha.SubItems.Add(FormatFloat('#,##0.00', Item.ValorTotalItem));
  end;
end;

procedure TFrmCadastroOS.btnSalvarClick(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  FOrdem.DescricaoProblema := edtDescricao.Text;
  FOrdem.DataAbertura := StrToDateDef(edtDataEnt.Text, Date);
  FOrdem.DataPrevista := StrToDateDef(edtDataPrev.Text, 0);
  if OrdemIDEdicao = 0 then FOrdem.Status := STATUS_ABERTA;

  if VarIsNull(cbxCliente.KeyValue) then
  begin
    ShowMessage('Selecione um cliente para a Ordem de Serviço.');
    Exit;
  end;

  FOrdem.Cliente.Id := cbxCliente.KeyValue;

  try
    FOrdem.Validar;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Exit;
    end;
  end;

  if FOrdem.Itens.Count = 0 then
  begin
    ShowMessage('É necessário adicionar pelo menos um item à Ordem de Serviço.');
    Exit;
  end;

  Service := TOrdemServicoService.Create;

  if OrdemIDEdicao > 0 then
    begin
      try
        if Service.Atualizar(FOrdem, dmPrincipal.ConexaoBanco) then
        begin
          ShowMessage('Ordem de Serviço alterada com sucesso!');
          Close;
        end
        else
          ShowMessage('Falha ao alterar a Ordem de Serviço na base de dados.');
      finally
        Service.Free;
      end;

    end
    else
    begin
      try
        if Service.Salvar(FOrdem, dmPrincipal.ConexaoBanco) then
        begin
          ShowMessage('Ordem de Serviço salva com sucesso!');
          Close;
        end
        else
          ShowMessage('Falha ao gravar a Ordem de Serviço na base de dados.');
      finally
        Service.Free;
      end;
    end;

end;

procedure TFrmCadastroOS.btnCancelarClick(Sender: TObject);
begin
  Close;
end;


procedure TFrmCadastroOS.FormShow(Sender: TObject);
  begin
    if OrdemIDEdicao > 0 then
    begin
      CarregarDadosEdicao;
    end;
  end;


procedure TFrmCadastroOS.CarregarDadosEdicao;
var
  Service: TOrdemServicoService;
  OSCarregada: TOrdemServico;
begin
  Service := TOrdemServicoService.Create;
  try
    OSCarregada := Service.RetornarOrdem(OrdemIDEdicao, dmPrincipal.ConexaoBanco);

    // Substitui a instância vazia criada no FormCreate pela OS carregada do banco
    FOrdem.Free;
    FOrdem := OSCarregada;

    edtDescricao.Text := FOrdem.DescricaoProblema;
    edtDataEnt.Text := DateToStr(FOrdem.DataAbertura);
    if FOrdem.DataPrevista > 0 then
      edtDataPrev.Text := DateToStr(FOrdem.DataPrevista);

    cbxCliente.KeyValue := FOrdem.Cliente.Id;

    if FOrdem.Imagem.Size > 0 then
    begin
      FOrdem.Imagem.Position := 0;
      Image1.Picture.LoadFromStream(FOrdem.Imagem);
    end;

    AtualizarListaVisual;
  finally
    Service.Free;
  end;
end;

procedure TFrmCadastroOS.edtValorChange(Sender: TObject);
var
  total : Currency;
begin
  if (edtValor.Text <> '') and (edtQntd.Text <> '') then
  begin
    total := (StrToCurrDef(edtValor.Text,0) * StrToCurrDef(edtQntd.Text,0));
    edtTotal.Text := 'R$' + FormatFloat('#,##0.00', total);
  end
  else
    edtTotal.Text := '';

end;

end.
