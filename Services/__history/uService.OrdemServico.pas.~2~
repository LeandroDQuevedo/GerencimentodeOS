unit uService.OrdemServico;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uModel.Classes;

type
  TOrdemServicoService = class
  public
    function Salvar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
    function Atualizar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
    function Deletar(IDOrdem: Integer; Conexao: TFDConnection): Boolean;
    function RetornarOrdem(IDOrdem: Integer; Conexao: TFDConnection): TOrdemServico;
  end;

implementation

function TOrdemServicoService.Salvar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
var
  qrSalvar: TFDQuery;
  Item: TItemOrdem;
begin
  qrSalvar := TFDQuery.Create(nil);
  try
    qrSalvar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      // Inserção da Ordem de Serviço com captura do ID gerado
      qrSalvar.SQL.Text :=
        'INSERT INTO ORDEM_SERVICO (CLIENTE_ID, DATA_ABERTURA, DATA_PREVISTA, ' +
        'STATUS, DESCRICAO_PROBLEMA, VALOR_TOTAL) ' +
        'VALUES (:pClienteId, :pDataAber, :pDataPrev, :pStatus, :pDescricao, :pValorTotal) ' +
        'RETURNING ID';

      qrSalvar.ParamByName('pClienteId').AsInteger := Ordem.Cliente.Id;
      qrSalvar.ParamByName('pDataAber').AsDate := Ordem.DataAbertura;
      qrSalvar.ParamByName('pDataPrev').AsDate := Ordem.DataPrevista;
      qrSalvar.ParamByName('pStatus').AsString := Ordem.Status;
      qrSalvar.ParamByName('pDescricao').AsString := Ordem.DescricaoProblema;
      qrSalvar.ParamByName('pValorTotal').AsCurrency := Ordem.ValorTotal;

      qrSalvar.Open; // Open usado devido à cláusula RETURNING
      Ordem.Id := qrSalvar.FieldByName('ID').AsInteger;
      qrSalvar.Close;

      // Inserção dos Itens da Ordem
      qrSalvar.SQL.Text :=
        'INSERT INTO ITEM_ORDEM (ORDEM_ID, DESCRICAO, QUANTIDADE, VALOR_UNITARIO) ' +
        'VALUES (:pOrdemId, :pDescricaoItem, :pQuantidade, :pValorUnitario)';

      for Item in Ordem.Itens do
      begin
        qrSalvar.ParamByName('pOrdemId').AsInteger := Ordem.Id;
        qrSalvar.ParamByName('pDescricaoItem').AsString := Item.Descricao;
        qrSalvar.ParamByName('pQuantidade').AsFloat := Item.Quantidade;
        qrSalvar.ParamByName('pValorUnitario').AsCurrency := Item.ValorUnitario;
        qrSalvar.ExecSQL;
      end;

      Conexao.Commit;
      Result := True;
    except
      Conexao.Rollback;
      Result := False;
    end;
  finally
    qrSalvar.Free;
  end;
end;

function TOrdemServicoService.Atualizar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
var
  qrAtualizar: TFDQuery;
  Item: TItemOrdem;
begin
  qrAtualizar := TFDQuery.Create(nil);
  try
    qrAtualizar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      // Atualização dos dados da Ordem Mestra
      qrAtualizar.SQL.Text :=
        'UPDATE ORDEM_SERVICO SET ' +
        'CLIENTE_ID = :pClienteId, DATA_ABERTURA = :pDataAber, DATA_PREVISTA = :pDataPrev, ' +
        'DATA_FECHAMENTO = :pDataFech, STATUS = :pStatus, DESCRICAO_PROBLEMA = :pDescricao, ' +
        'VALOR_TOTAL = :pValorTotal WHERE ID = :pID';

      qrAtualizar.ParamByName('pID').AsInteger := Ordem.Id;
      qrAtualizar.ParamByName('pClienteId').AsInteger := Ordem.Cliente.Id;
      qrAtualizar.ParamByName('pDataAber').AsDate := Ordem.DataAbertura;
      qrAtualizar.ParamByName('pDataPrev').AsDate := Ordem.DataPrevista;
      // Tratamento para data de fechamento nula
      if Ordem.DataFechamento = 0 then
        qrAtualizar.ParamByName('pDataFech').Clear
      else
        qrAtualizar.ParamByName('pDataFech').AsDate := Ordem.DataFechamento;
      qrAtualizar.ParamByName('pStatus').AsString := Ordem.Status;
      qrAtualizar.ParamByName('pDescricao').AsString := Ordem.DescricaoProblema;
      qrAtualizar.ParamByName('pValorTotal').AsCurrency := Ordem.ValorTotal;
      qrAtualizar.ExecSQL;

      // Padrão de exclusão e reinserção para os itens (Evita complexidade de sincronização diferencial)
      qrAtualizar.SQL.Text := 'DELETE FROM ITEM_ORDEM WHERE ORDEM_ID = :pID';
      qrAtualizar.ParamByName('pID').AsInteger := Ordem.Id;
      qrAtualizar.ExecSQL;

      qrAtualizar.SQL.Text :=
        'INSERT INTO ITEM_ORDEM (ORDEM_ID, DESCRICAO, QUANTIDADE, VALOR_UNITARIO) ' +
        'VALUES (:pOrdemId, :pDescricaoItem, :pQuantidade, :pValorUnitario)';

      for Item in Ordem.Itens do
      begin
        qrAtualizar.ParamByName('pOrdemId').AsInteger := Ordem.Id;
        qrAtualizar.ParamByName('pDescricaoItem').AsString := Item.Descricao;
        qrAtualizar.ParamByName('pQuantidade').AsFloat := Item.Quantidade;
        qrAtualizar.ParamByName('pValorUnitario').AsCurrency := Item.ValorUnitario;
        qrAtualizar.ExecSQL;
      end;

      Conexao.Commit;
      Result := True;
    except
      Conexao.Rollback;
      Result := False;
    end;
  finally
    qrAtualizar.Free;
  end;
end;

function TOrdemServicoService.RetornarOrdem(IDOrdem: Integer; Conexao: TFDConnection): TOrdemServico;
var
  qrRetorno: TFDQuery;
  FOrdem: TOrdemServico;
  FItem: TItemOrdem;
begin
  qrRetorno := TFDQuery.Create(nil);
  try
    qrRetorno.Connection := Conexao;

    // 1. Carregar os dados mestres da Ordem
    qrRetorno.SQL.Text :=
      'SELECT OS.*, C.NOME AS NOME_CLIENTE FROM ORDEM_SERVICO OS ' +
      'INNER JOIN CLIENTE C ON (C.ID = OS.CLIENTE_ID) WHERE OS.ID = :pID';
    qrRetorno.ParamByName('pID').AsInteger := IDOrdem;
    qrRetorno.Open;

    FOrdem := TOrdemServico.Create;
    if not qrRetorno.IsEmpty then
    begin
      FOrdem.Id := qrRetorno.FieldByName('ID').AsInteger;
      FOrdem.Cliente.Id := qrRetorno.FieldByName('CLIENTE_ID').AsInteger;
      FOrdem.Cliente.Nome := qrRetorno.FieldByName('NOME_CLIENTE').AsString;
      FOrdem.DataAbertura := qrRetorno.FieldByName('DATA_ABERTURA').AsDateTime;
      if not qrRetorno.FieldByName('DATA_PREVISTA').IsNull then
        FOrdem.DataPrevista := qrRetorno.FieldByName('DATA_PREVISTA').AsDateTime;
      if not qrRetorno.FieldByName('DATA_FECHAMENTO').IsNull then
        FOrdem.DataFechamento := qrRetorno.FieldByName('DATA_FECHAMENTO').AsDateTime;
      FOrdem.Status := qrRetorno.FieldByName('STATUS').AsString;
      FOrdem.DescricaoProblema := qrRetorno.FieldByName('DESCRICAO_PROBLEMA').AsString;
      FOrdem.ValorTotal := qrRetorno.FieldByName('VALOR_TOTAL').AsCurrency;
    end;
    qrRetorno.Close;

    // 2. Carregar os Itens da Ordem
    qrRetorno.SQL.Text := 'SELECT * FROM ITEM_ORDEM WHERE ORDEM_ID = :pID';
    qrRetorno.ParamByName('pID').AsInteger := IDOrdem;
    qrRetorno.Open;

    while not qrRetorno.Eof do
    begin
      FItem := TItemOrdem.Create;
      FItem.Id := qrRetorno.FieldByName('ID').AsInteger;
      FItem.OrdemId := FOrdem.Id;
      FItem.Descricao := qrRetorno.FieldByName('DESCRICAO').AsString;
      FItem.Quantidade := qrRetorno.FieldByName('QUANTIDADE').AsFloat;
      FItem.ValorUnitario := qrRetorno.FieldByName('VALOR_UNITARIO').AsCurrency;

      FOrdem.Itens.Add(FItem);
      qrRetorno.Next;
    end;

    Result := FOrdem;
  finally
    qrRetorno.Free;
  end;
end;

function TOrdemServicoService.Deletar(IDOrdem: Integer; Conexao: TFDConnection): Boolean;
var
  qrDeletar: TFDQuery;
begin
  qrDeletar := TFDQuery.Create(nil);
  try
    qrDeletar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      qrDeletar.SQL.Text := 'UPDATE ORDEM_SERVICO SET STATUS = :pStatus WHERE ID = :pID';
      qrDeletar.ParamByName('pStatus').AsString := 'CANCELADA';
      qrDeletar.ParamByName('pID').AsInteger := IDOrdem;

      qrDeletar.ExecSQL;

      Conexao.Commit;
      Result := True;
    except
      Conexao.Rollback;
      Result := False;
    end;
  finally
    qrDeletar.Free;
  end;
end;

end.
