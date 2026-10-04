unit uFrmCadastroOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.ComCtrls, uFrmCadastroCliente, uModel.Classes, uService.OrdemServico, uDM;

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
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    LsvMovimentacoes: TListView;
    Panel2: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarFotoClick(Sender: TObject);
    procedure btnAddClienteClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
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
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    FOrdem.Imagem.Clear;
    Image1.Picture.Graphic.SaveToStream(FOrdem.Imagem);
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

  // Criação do item
  FItem := TItemOrdem.Create;
  FItem.Descricao := Trim(edtDescricaoItem.Text);
  FItem.Quantidade := StrToFloat(edtQntd.Text);
  FItem.ValorUnitario := StrToCurr(edtValor.Text);

  // Adição e recálculo
  FOrdem.Itens.Add(FItem);
  FOrdem.RecalcularTotal;
  AtualizarListaVisual;

  // Limpeza para o próximo
  edtDescricaoItem.Text := '';
  edtQntd.Text := '';
  edtValor.Text := '';
  edtDescricaoItem.SetFocus;
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

procedure TFrmCadastroOS.BtnSalvarClick(Sender: TObject);
var
  Service: TOrdemServicoService;
begin
  FOrdem.DescricaoProblema := edtDescricao.Text;
  FOrdem.DataAbertura := StrToDateDef(edtDataEnt.Text, Date);
  FOrdem.DataPrevista := StrToDateDef(edtDataPrev.Text, 0);
  FOrdem.Status := 'ABERTO';

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

procedure TFrmCadastroOS.BtnCancelarClick(Sender: TObject);
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
    OSCarregada := Service.CarregarPorId(OrdemIDEdicao, dmPrincipal.ConexaoBanco);
    try
      if Assigned(OSCarregada) then
      begin
        // Substitui a instância vazia criada no FormCreate pela OS carregada do banco
        FOrdem.Free;
        FOrdem := OSCarregada;

        // Preenche os componentes de tela com os dados do objeto
        edtDescricao.Text := FOrdem.DescricaoProblema;
        edtDataEnt.Text := DateToStr(FOrdem.DataAbertura);
        if FOrdem.DataPrevista > 0 then
          edtDataPrev.Text := DateToStr(FOrdem.DataPrevista);

        cbxCliente.KeyValue := FOrdem.Cliente.Id;

        // Atualiza a listagem visual dos itens no ListView e o valor total
        AtualizarListaVisual;
      end;
    except
      if Assigned(OSCarregada) and (OSCarregada <> FOrdem) then
        OSCarregada.Free;
      raise;
    end;
  finally
    Service.Free;
  end;
end;

end.
