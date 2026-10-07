unit uService.OrdemServico;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uModel.Classes, System.Classes;

type
  TOrdemServicoService = class
  public
    function Salvar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
    function Atualizar(Ordem: TOrdemServico; Conexao: TFDConnection): Boolean;
    function Deletar(IDOrdem: Integer; Conexao: TFDConnection): Boolean;
    function RetornarOrdem(IDOrdem: Integer; Conexao: TFDConnection): TOrdemServico;
    function RetornaNumeroOSPorCliente(IDCliente: Integer; Conexao: TFDConnection): Integer;
    function AlterarStatus(IDOrdem: Integer; StatusAtual, NovoStatus: string; Conexao: TFDConnection): Boolean;
    procedure ValidarTrocaStatus(StatusAtual, NovoStatus: string);
    procedure ValidarExclusao(Status: string);
    procedure AplicarFiltro(Query: TFDQuery; SQLBase: string; Filtro: TFiltroOS; OrdenarPor: string);
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
      qrSalvar.SQL.Text :=
        'INSERT INTO ORDEM_SERVICO (CLIENTE_ID, DATA_ABERTURA, DATA_PREVISTA, ' +
        'STATUS, DESCRICAO_PROBLEMA, VALOR_TOTAL, FOTO, MINIATURA) ' +
        'VALUES (:pClienteId, :pDataAber, :pDataPrev, :pStatus, :pDescricao, :pValorTotal, :pFoto, :pMiniatura) ' +
        'RETURNING ID';

      qrSalvar.ParamByName('pClienteId').AsInteger := Ordem.Cliente.Id;
      qrSalvar.ParamByName('pDataAber').AsDate := Ordem.DataAbertura;
      if Ordem.DataPrevista = 0 then
      begin
        qrSalvar.ParamByName('pDataPrev').DataType := ftDate;
        qrSalvar.ParamByName('pDataPrev').Clear;
      end
      else
        qrSalvar.ParamByName('pDataPrev').AsDate := Ordem.DataPrevista;
      qrSalvar.ParamByName('pStatus').AsString := Ordem.Status;
      qrSalvar.ParamByName('pDescricao').AsString := Ordem.DescricaoProblema;
      qrSalvar.ParamByName('pValorTotal').AsCurrency := Ordem.ValorTotal;

      if Ordem.Imagem.Size > 0 then
      begin
        Ordem.Imagem.Position := 0;
        qrSalvar.ParamByName('pFoto').LoadFromStream(Ordem.Imagem, ftBlob);
      end
      else
      begin
        qrSalvar.ParamByName('pFoto').DataType := ftBlob;
        qrSalvar.ParamByName('pFoto').Clear;
      end;

      if Ordem.Miniatura.Size > 0 then
      begin
        Ordem.Miniatura.Position := 0;
        qrSalvar.ParamByName('pMiniatura').LoadFromStream(Ordem.Miniatura, ftBlob);
      end
      else
      begin
        qrSalvar.ParamByName('pMiniatura').DataType := ftBlob;
        qrSalvar.ParamByName('pMiniatura').Clear;
      end;

      qrSalvar.Open;
      Ordem.Id := qrSalvar.FieldByName('ID').AsInteger;
      qrSalvar.Close;

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
      on Erro: Exception do
      begin
        Conexao.Rollback;
        raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
      end;
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
      qrAtualizar.SQL.Text :=
        'UPDATE ORDEM_SERVICO SET ' +
        'CLIENTE_ID = :pClienteId, DATA_ABERTURA = :pDataAber, DATA_PREVISTA = :pDataPrev, ' +
        'DATA_FECHAMENTO = :pDataFech, STATUS = :pStatus, DESCRICAO_PROBLEMA = :pDescricao, ' +
        'VALOR_TOTAL = :pValorTotal, FOTO = :pFoto, MINIATURA = :pMiniatura WHERE ID = :pID';

      if Ordem.Imagem.Size > 0 then
        begin
          Ordem.Imagem.Position := 0; // Volta o ponteiro para o início da leitura
          qrAtualizar.ParamByName('pFoto').LoadFromStream(Ordem.Imagem, ftBlob);
        end
        else
        begin
          qrAtualizar.ParamByName('pFoto').DataType := ftBlob;
          qrAtualizar.ParamByName('pFoto').Clear;
        end;

      if Ordem.Miniatura.Size > 0 then
      begin
        Ordem.Miniatura.Position := 0;
        qrAtualizar.ParamByName('pMiniatura').LoadFromStream(Ordem.Miniatura, ftBlob);
      end
      else
      begin
        qrAtualizar.ParamByName('pMiniatura').DataType := ftBlob;
        qrAtualizar.ParamByName('pMiniatura').Clear;
      end;

      qrAtualizar.ParamByName('pID').AsInteger := Ordem.Id;
      qrAtualizar.ParamByName('pClienteId').AsInteger := Ordem.Cliente.Id;
      qrAtualizar.ParamByName('pDataAber').AsDate := Ordem.DataAbertura;
      if Ordem.DataPrevista = 0 then
      begin
        qrAtualizar.ParamByName('pDataPrev').DataType := ftDate;
        qrAtualizar.ParamByName('pDataPrev').Clear;
      end
      else
        qrAtualizar.ParamByName('pDataPrev').AsDate := Ordem.DataPrevista;
      // Tratamento para data de fechamento nula
      if Ordem.DataFechamento = 0 then
        begin
        qrAtualizar.ParamByName('pDataFech').DataType := ftDate;
        qrAtualizar.ParamByName('pDataFech').Clear
        end
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
      on Erro: Exception do
        begin
          Conexao.Rollback;
          raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
        end;
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
  StreamBanco: TStream;
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
      if not qrRetorno.FieldByName('FOTO').IsNull then
        begin
          StreamBanco := qrRetorno.CreateBlobStream(qrRetorno.FieldByName('FOTO'), bmRead);
          try
            FOrdem.Imagem.LoadFromStream(StreamBanco);
          finally
            StreamBanco.Free;
          end;
        end;

      if not qrRetorno.FieldByName('MINIATURA').IsNull then
        begin
          StreamBanco := qrRetorno.CreateBlobStream(qrRetorno.FieldByName('MINIATURA'), bmRead);
          try
            FOrdem.Miniatura.LoadFromStream(StreamBanco);
          finally
            StreamBanco.Free;
          end;
        end;
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
      qrDeletar.SQL.Text := 'DELETE FROM ORDEM_SERVICO WHERE ID = :pID';
      qrDeletar.ParamByName('pID').AsInteger := IDOrdem;
      qrDeletar.ExecSQL;

      Conexao.Commit;
      Result := True;
    except
      on Erro: Exception do
      begin
        Conexao.Rollback;
        raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
      end;
    end;
  finally
    qrDeletar.Free;
  end;
end;

function TOrdemServicoService.RetornaNumeroOSPorCliente(IDCliente: Integer; Conexao: TFDConnection): Integer;
var
  qrNumOS: TFDQuery;
begin
  qrNumOS := TFDQuery.Create(Nil);
  try
    qrNumOS.Connection := Conexao;
    qrNumOS.SQL.Text := 'SELECT COUNT(ID) as Contador FROM ORDEM_SERVICO WHERE CLIENTE_ID = :pID';

    Conexao.StartTransaction;
    try
      qrNumOS.ParamByName('pID').AsInteger := IDCliente;
      qrNumOS.Open;
      Conexao.Commit;

      Result := qrNumOS.FieldByName('Contador').AsInteger;
    except
      Conexao.Rollback;
      Result := 0;
    end;
  finally
    qrNumOS.Free;
  end;
end;

procedure TOrdemServicoService.ValidarTrocaStatus(StatusAtual, NovoStatus: string);
begin
  if NovoStatus = StatusAtual then
    raise Exception.Create('A Ordem de Serviço já está com a situação "' + NovoStatus + '".');

  if (StatusAtual = STATUS_CONCLUIDA) or (StatusAtual = STATUS_CANCELADA) then
    raise Exception.Create('Ordens de Serviço concluídas ou canceladas não podem mudar de situação.');

  if (StatusAtual = STATUS_EM_ANDAMENTO) and (NovoStatus = STATUS_ABERTA) then
    raise Exception.Create('Uma Ordem de Serviço em andamento não pode voltar para Aberta.');
end;

function TOrdemServicoService.AlterarStatus(IDOrdem: Integer; StatusAtual, NovoStatus: string; Conexao: TFDConnection): Boolean;
var
  qrStatus: TFDQuery;
begin
  ValidarTrocaStatus(StatusAtual, NovoStatus);

  qrStatus := TFDQuery.Create(nil);
  try
    qrStatus.Connection := Conexao;
    Conexao.StartTransaction;
    try
      qrStatus.SQL.Text :=
        'UPDATE ORDEM_SERVICO SET STATUS = :pStatus, DATA_FECHAMENTO = :pDataFech ' +
        'WHERE ID = :pID';

      qrStatus.ParamByName('pStatus').AsString := NovoStatus;
      qrStatus.ParamByName('pID').AsInteger := IDOrdem;

      // Data de fechamento só existe quando a OS é encerrada
      if (NovoStatus = STATUS_CONCLUIDA) or (NovoStatus = STATUS_CANCELADA) then
        qrStatus.ParamByName('pDataFech').AsDate := Date
      else
      begin
        qrStatus.ParamByName('pDataFech').DataType := ftDate;
        qrStatus.ParamByName('pDataFech').Clear;
      end;

      qrStatus.ExecSQL;
      Conexao.Commit;
      Result := True;
    except
      on Erro: Exception do
      begin
        Conexao.Rollback;
        raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
      end;
    end;
  finally
    qrStatus.Free;
  end;
end;

procedure TOrdemServicoService.ValidarExclusao(Status: string);
begin
  if Status <> STATUS_ABERTA then
    raise Exception.Create('Apenas Ordens de Serviço com situação Aberta podem ser excluídas.' + #13#10 +
      'Para encerrar uma OS em andamento, altere a situação para Cancelada.');
end;

procedure TOrdemServicoService.AplicarFiltro(Query: TFDQuery; SQLBase: string; Filtro: TFiltroOS; OrdenarPor: string);
var
  i : integer;
  ListaParametros: string;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(SQLBase);

  if Filtro.DataIni > 0 then
    Query.SQL.Add('AND OS.DATA_ABERTURA >= :pDataIni');
  if Filtro.DataFim > 0 then
    Query.SQL.Add('AND OS.DATA_ABERTURA <= :pDataFim');
  if Filtro.Status <> '' then
    Query.SQL.Add('AND OS.STATUS = :pStatus');
  if Length(Filtro.ListaStatus) > 0 then
  begin
    ListaParametros := '';
    for i := 0 to High(Filtro.ListaStatus) do
    begin
      if i > 0 then
        ListaParametros := ListaParametros + ', ';
      ListaParametros := ListaParametros + ':pStatus' + IntToStr(i);
    end;
    Query.SQL.Add('AND OS.STATUS IN (' + ListaParametros + ')');
  end;
  if Trim(Filtro.NomeCliente) <> '' then
    Query.SQL.Add('AND UPPER(OS.CLIENTE_NOME) LIKE :pNome');
  if Filtro.ValorMin > 0 then
    Query.SQL.Add('AND OS.VALOR_TOTAL >= :pValorMin');
  if Filtro.ValorMax > 0 then
    Query.SQL.Add('AND OS.VALOR_TOTAL <= :pValorMax');
  if Filtro.NumeroOS > 0 then
    Query.SQL.Add('AND OS.ID = :pNumeroOS');
  if OrdenarPor <> '' then
    Query.SQL.Add(OrdenarPor);

  if Filtro.DataIni > 0 then
    Query.ParamByName('pDataIni').AsDate := Filtro.DataIni;
  if Filtro.DataFim > 0 then
    Query.ParamByName('pDataFim').AsDate := Filtro.DataFim;
  if Filtro.Status <> '' then
    Query.ParamByName('pStatus').AsString := Filtro.Status;
  if Trim(Filtro.NomeCliente) <> '' then
    Query.ParamByName('pNome').AsString := '%' + AnsiUpperCase(Trim(Filtro.NomeCliente)) + '%';
  if Filtro.ValorMin > 0 then
    Query.ParamByName('pValorMin').AsCurrency := Filtro.ValorMin;
  if Filtro.ValorMax > 0 then
    Query.ParamByName('pValorMax').AsCurrency := Filtro.ValorMax;
  if Filtro.NumeroOS > 0 then
    Query.ParamByName('pNumeroOS').AsInteger := Filtro.NumeroOS;
  for i := 0 to High(Filtro.ListaStatus) do
    Query.ParamByName('pStatus' + IntToStr(i)).AsString := Filtro.ListaStatus[i];

  if Query.Params.FindParam('pLimite') <> nil then
    Query.ParamByName('pLimite').AsInteger := Filtro.Limite;
end;

end.
