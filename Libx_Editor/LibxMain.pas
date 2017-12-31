unit LibxMain;
interface

uses Vcl.Forms, LibxEditorUnit;

type
  TLibxEditor = class
  public
    constructor Create;

    procedure InitFilesLibx;

    procedure Start;
  end;

var
  LibxEditor: TLibxEditor;

implementation

{ TLibxEditor }

constructor TLibxEditor.Create;
begin
  inherited;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLibxEditor, frmLibxEditor);
end;

procedure TLibxEditor.InitFilesLibx;
var
  I: Integer;
  B: Boolean;
begin
  frmLibxEditor.ListBoxFiles.Clear;
  frmLibxEditor

end;

procedure TLibxEditor.Start;
begin
  frmLibxEditor.Show;

  frmLibxEditor.fTextManager.Clear;

  B := False;



end;

end.
