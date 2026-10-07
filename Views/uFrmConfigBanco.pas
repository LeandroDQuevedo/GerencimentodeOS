unit uFrmConfigBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.VirtualImageList, FireDAC.Comp.Client, System.IniFiles,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmConfigBanco = class(TForm)
    FileOpenDialog1: TFileOpenDialog;
    edtCaminho: TButtonedEdit;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    Label1: TLabel;
    btnSalvarConex: TButton;
    btnTstCnx: TButton;
    edtUsername: TEdit;
    edtSenha: TButtonedEdit;
    procedure edtCaminhoRightButtonClick(Sender: TObject);
    procedure btnTstCnxClick(Sender: TObject);
    procedure btnSalvarConexClick(Sender: TObject);
    function TestarConexao:Boolean;
    procedure edtSenhaRightButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfigBanco: TFrmConfigBanco;

implementation

uses
  uDM;

{$R *.dfm}

procedure TFrmConfigBanco.btnSalvarConexClick(Sender: TObject);
var
  ArquivoINI: TIniFile;
  CaminhoDoArquivo: string;
begin

  if TestarConexao() then
  begin
    CaminhoDoArquivo := ExtractFilePath(ParamStr(0)) + 'config.ini';

    ArquivoINI := TIniFile.Create(CaminhoDoArquivo);
    try
    
      ArquivoINI.WriteString('BANCO', 'Caminho', edtCaminho.Text);
      ArquivoINI.WriteString('BANCO', 'Username', edtUsername.Text);
      ArquivoINI.WriteString('BANCO', 'Senha', edtSenha.Text);
    finally
      ArquivoINI.Free;
    end;
    ModalResult := mrOk;
  end;
end;

procedure TFrmConfigBanco.btnTstCnxClick(Sender: TObject);
begin

    if TestarConexao() then
      ShowMessage('Conexão realizada com sucesso!');
    
   
end;

procedure TFrmConfigBanco.edtSenhaRightButtonClick(Sender: TObject);
begin
  if edtSenha.PasswordChar = '*' then
    begin
      edtSenha.PasswordChar := #0;
      edtSenha.RightButton.ImageIndex := 1;
    end
  else
    begin
      edtSenha.PasswordChar := '*';
      edtSenha.RightButton.ImageIndex := 2;
    end;
end;

procedure TFrmConfigBanco.edtCaminhoRightButtonClick(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    edtCaminho.Text := FileOpenDialog1.FileName;
  end;
end;

function TFrmConfigBanco.TestarConexao:Boolean;
var
  TempConex: TFDConnection; 
begin
  if Trim(edtCaminho.Text) = '' then
    begin
      Result := False;
      ShowMessage('Por favor, selecione o caminho do banco de dados primeiro!');
      exit;
    end;
  if Trim(edtUsername.Text) = '' then
  begin
      Result := False;
    ShowMessage('Por favor, insira o login do banco de dados primeiro!');
    exit;
  end;
  if Trim(edtSenha.Text) = '' then
  begin
      Result := False;
    ShowMessage('Por favor, insira a senha do banco de dados primeiro!');
    exit;
  end;


  TempConex := TFDConnection.Create(nil);
  TempConex.Params.Assign(dmPrincipal.ConexaoBanco.Params);
  try
    try
    TempConex.Params.Values['Database'] := edtCaminho.Text;
    TempConex.Params.Values['User_Name'] := edtUsername.Text;
    TempConex.Params.Values['Password'] := edtSenha.Text;

    TempConex.Connected := True;

    Result := True;
    except
      on E: Exception do
      begin
        ShowMessage('Não foi possível conectar. Verifique os campos.' + sLineBreak + 'Erro original: ' + E.Message);
        Result := False;
      end;
    end;
  finally
    TempConex.Free;
  end;
  
end;

end.
