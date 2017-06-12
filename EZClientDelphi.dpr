program EZClientDelphi;

uses
  Forms,
  EZClient in 'EZClient.pas',
  MainForm in 'MainForm.pas' {Form1},
  Version in 'Version.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
