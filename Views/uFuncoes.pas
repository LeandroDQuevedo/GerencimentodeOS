unit uFuncoes;

interface
  function ConfirmarAcao(mensagem : string) : boolean;
implementation

uses
  Winapi.Windows, Vcl.Forms;

function ConfirmarAcao(mensagem: string): Boolean;
  begin
    Result := Application.MessageBox(PChar(mensagem), 'Confirmação',
      MB_YESNO + MB_ICONQUESTION) = IDYES;
  end;

end.
