program LibxEditor;

uses
  Vcl.Forms,
  LibxEditorUnit in 'LibxEditorUnit.pas' {frmLibxEditor},
  C_TEXTS in 'C_TEXTS.pas',
  TEXTS in 'TEXTS.pas',
  LoadFilesUnit in 'LoadFilesUnit.pas' {frmLoadFiles};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLibxEditor, frmLibxEditor);
  Application.CreateForm(TfrmLoadFiles, frmLoadFiles);
  Application.Run;
end.
