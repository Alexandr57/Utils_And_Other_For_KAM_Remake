program LibxEditor;

uses
  Vcl.Forms,
  LibxEditorUnit in 'LibxEditorUnit.pas' {frmLibxEditor},
  Versions in '..\General\Versions.pas',
  C_TEXTS in 'C_TEXTS.pas',
  TEXTS in 'TEXTS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLibxEditor, frmLibxEditor);
  Application.Run;
end.
