unit uModel.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TCliente = class
  private
    FId: Integer;
    FNome: string;
    FDocumento: string;
    FEmail: string;
    FTelefone: string;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Documento: string read FDocumento write FDocumento;
    property Email: string read FEmail write FEmail;
    property Telefone: string read FTelefone write FTelefone;

    procedure Validar;
  end;

  TItemOrdem = class
  private
    FId: Integer;
    FOrdemId: Integer;
    FDescricao: string;
    FQuantidade: Double;
    FValorUnitario: Currency;
  public
    property Id: Integer read FId write FId;
    property OrdemId: Integer read FOrdemId write FOrdemId;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;

    function ValorTotalItem: Currency;
    procedure Validar;
  end;

  TOrdemServico = class
  private
    FId: Integer;
    FDataAbertura: TDate;
    FDataPrevista: TDate;
    FDataFechamento: TDate;
    FStatus: string;
    FDescricaoProblema: string;
    FValorTotal: Currency;
    FCliente: TCliente;
    FItens: TObjectList<TItemOrdem>;
    FImagem: TMemoryStream;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Validar;
    procedure RecalcularTotal;

    property Id: Integer read FId write FId;
    property DataAbertura: TDate read FDataAbertura write FDataAbertura;
    property DataPrevista: TDate read FDataPrevista write FDataPrevista;
    property DataFechamento: TDate read FDataFechamento write FDataFechamento;
    property Status: string read FStatus write FStatus;
    property DescricaoProblema: string read FDescricaoProblema write FDescricaoProblema;
    property ValorTotal: Currency read FValorTotal write FValorTotal;

    property Cliente: TCliente read FCliente write FCliente;
    property Itens: TObjectList<TItemOrdem> read FItens write FItens;
    property Imagem: TMemoryStream read FImagem write FImagem;
  end;

implementation

{ TCliente }

procedure TCliente.Validar;
begin
  if Trim(FNome) = '' then
    raise Exception.Create('Campo "Nome do Cliente" precisa ser preenchido');
end;

{ TItemOrdem }

function TItemOrdem.ValorTotalItem: Currency;
begin
  Result := FQuantidade * FValorUnitario;
end;

procedure TItemOrdem.Validar;
begin
  if Trim(FDescricao) = '' then
    raise Exception.Create('A descrição do item é obrigatória.');
  if FQuantidade <= 0 then
    raise Exception.Create('A quantidade do item deve ser maior que zero.');
end;

{ TOrdemServico }

constructor TOrdemServico.Create;
begin
  FCliente := TCliente.Create;
  FItens := TObjectList<TItemOrdem>.Create(True);
  FImagem := TMemoryStream.Create;
  FDataAbertura := Now; // Regra padrão de negócio inicial
  FStatus := 'ABERTO';
end;

destructor TOrdemServico.Destroy;
begin
  FImagem.Free;
  FCliente.Free;
  FItens.Free;
  inherited;
end;

procedure TOrdemServico.RecalcularTotal;
var
  Item: TItemOrdem;
begin
  FValorTotal := 0;
  for Item in FItens do
    FValorTotal := FValorTotal + Item.ValorTotalItem;
end;

procedure TOrdemServico.Validar;
begin
  if FCliente.Id = 0 then
    raise Exception.Create('É necessário vincular um Cliente à Ordem de Serviço.');

  if Trim(FDescricaoProblema) = '' then
    raise Exception.Create('A descrição do problema precisa ser preenchida.');

  if FStatus = '' then
    raise Exception.Create('O status da Ordem de Serviço é obrigatório.');
end;

end.
