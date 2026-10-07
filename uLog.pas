unit uLog;

interface

procedure GravarLog(Tipo, Mensagem: string);

implementation

uses
  System.SysUtils, System.IOUtils;

procedure GravarLog(Tipo, Mensagem: string);
var
  Arquivo: string;
  Linha: string;
begin
  Arquivo := ExtractFilePath(ParamStr(0)) + 'ProjetoOS.log';
  Linha := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' [' + Tipo + '] ' + Mensagem + sLineBreak;

  try
    TFile.AppendAllText(Arquivo, Linha, TEncoding.UTF8);
  except
    // Falha ao gravar o log não pode derrubar o sistema
  end;
end;

end.
