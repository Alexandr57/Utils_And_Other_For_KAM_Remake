program Libx_Editor;

uses
  Vcl.Forms,
  LibxEditorUnit in 'LibxEditorUnit.pas' {frmLibxEditorMain},
  CONSTS in '..\General\CONSTS.pas',
  TextsUnit in 'TextsUnit.pas',
  ReadWriteLangs in '..\General\ReadWriteLangs.pas',
  MyThreads in 'MyThreads.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLibxEditorMain, frmLibxEditorMain);
  Application.Run;
end.
