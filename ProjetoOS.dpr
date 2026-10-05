program ProjetoOS;

uses
  Vcl.Forms,
  uModel.Classes in 'uModel.Classes.pas',
  uService.OrdemServico in 'services\uService.OrdemServico.pas',
  uFrmCadastroOS in 'Views\uFrmCadastroOS.pas' {FrmCadastroOS},
  uDM in 'uDM.pas' {dmPrincipal: TDataModule},
  uFrmCadastroCliente in 'Views\uFrmCadastroCliente.pas' {FrmCadastroCliente},
  uFrmPrincipal in 'Views\uFrmPrincipal.pas' {FrmPrincipal},
  uService.Imagem in 'Services\uService.Imagem.pas',
  uFrmAlterarStatus in 'Views\uFrmAlterarStatus.pas' {FrmAlterarStatus},
  uService.Cliente in 'Services\uService.Cliente.pas',
  uFuncoes in 'Views\uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
