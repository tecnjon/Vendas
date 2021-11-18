program Teste;

uses
  Vcl.Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {Form1},
  untVendas in 'untVendas.pas',
  untConexao in 'untConexao.pas';

{$R *.res}

begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
