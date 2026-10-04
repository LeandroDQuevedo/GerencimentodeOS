program Project1;

uses
  Vcl.Forms,
  uModel.Classes in '..\uModel.Classes.pas',
  uService.OrdemServico in '..\services\uService.OrdemServico.pas',
  uFrmOrdensServicoCart in 'uFrmOrdensServicoCart.pas' {FrmOrdensServicoCart},
  uFrmCadastroOS in 'uFrmCadastroOS.pas' {FrmCadastroOS},
  uDM in '..\uDM.pas' {dmPrincipal: TDataModule},
  uFrmCadastroCliente in 'uFrmCadastroCliente.pas' {FrmCadastroCliente},
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmOrdensServicoCart, FrmOrdensServicoCart);
  Application.CreateForm(TFrmCadastroOS, FrmCadastroOS);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
  Application.Run;
end.
