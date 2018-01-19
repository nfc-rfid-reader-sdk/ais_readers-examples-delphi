program BaseHD;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  libcoder in 'libcoder.pas',
  functions in 'functions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
