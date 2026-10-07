unit uService.Cliente;

interface
uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, uModel.Classes, System.Classes, uLog;

type
  TClienteService = class
  public
    function DeletarCliente(IDCliente: Integer; Conexao: TFDConnection): Boolean;
    function AtualizarCliente(Cliente: TCliente; Conexao: TFDConnection): Boolean;
    function SalvarCliente(Cliente: TCliente; Conexao: TFDConnection): Boolean;
  end;

implementation

function TClienteService.SalvarCliente(Cliente: TCliente; Conexao: TFDConnection): Boolean;
var
  qrSalvar: TFDQuery;
begin
  qrSalvar := TFDQuery.Create(nil);
  try
    qrSalvar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      qrSalvar.SQL.Text :=
        'INSERT INTO CLIENTE (NOME, DOCUMENTO, EMAIL, TELEFONE) ' +
        'VALUES (:pNome, :pDocumento, :pEmail, :pTelefone) ' +
        'RETURNING ID';

      qrSalvar.ParamByName('pNome').AsString := Cliente.Nome;
      qrSalvar.ParamByName('pDocumento').AsString := Cliente.Documento;
      qrSalvar.ParamByName('pEmail').AsString := Cliente.Email;
      qrSalvar.ParamByName('pTelefone').AsString := Cliente.Telefone;

      qrSalvar.Open;
      Cliente.Id := qrSalvar.FieldByName('ID').AsInteger;
      qrSalvar.Close;

      Conexao.Commit;
      Result := True;
    except
      on Erro: Exception do
      begin
        Conexao.Rollback;
        GravarLog('ERRO', 'Salvar OS: ' + Erro.Message);
        raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
      end;
    end;
  finally
    qrSalvar.Free;
  end;
end;

function TClienteService.DeletarCliente(IDCliente: Integer; Conexao: TFDConnection): Boolean;
var
  qrDeletar: TFDQuery;
begin
  qrDeletar := TFDQuery.Create(nil);
  try
    qrDeletar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      qrDeletar.SQL.Text := 'DELETE FROM CLIENTE WHERE ID = :pID';
      qrDeletar.ParamByName('pID').AsInteger := IDCliente;
      qrDeletar.ExecSQL;

      Conexao.Commit;
      Result := True;
    except
      on Erro: Exception do
      begin
        Conexao.Rollback;
        GravarLog('ERRO', 'Salvar OS: ' + Erro.Message);
        raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
      end;
    end;
  finally
    qrDeletar.Free;
  end;
end;

function TClienteService.AtualizarCliente(Cliente: TCliente; Conexao: TFDConnection): Boolean;
var
  qrAtualizar: TFDQuery;
begin
  qrAtualizar := TFDQuery.Create(nil);
  try
    qrAtualizar.Connection := Conexao;
    Conexao.StartTransaction;
    try
      qrAtualizar.SQL.Text :=
        'UPDATE CLIENTE SET ' +
        'NOME = :pNome, DOCUMENTO = :pDocumento, EMAIL = :pEmail, ' +
        'TELEFONE = :pTelefone WHERE ID = :pID';

      qrAtualizar.ParamByName('pID').AsInteger := Cliente.Id;
      qrAtualizar.ParamByName('pNome').AsString := Cliente.Nome;
      qrAtualizar.ParamByName('pDocumento').AsString := Cliente.Documento;
      qrAtualizar.ParamByName('pEmail').AsString := Cliente.Email;
      qrAtualizar.ParamByName('pTelefone').AsString := Cliente.Telefone;
      qrAtualizar.ExecSQL;
      Conexao.Commit;
      Result := True;
    except
      on Erro: Exception do
        begin
          Conexao.Rollback;
          GravarLog('ERRO', 'Salvar OS: ' + Erro.Message);
          raise Exception.Create('Erro do Banco de Dados: ' + Erro.Message);
        end;
    end;
  finally
    qrAtualizar.Free;
  end;
end;
end.
