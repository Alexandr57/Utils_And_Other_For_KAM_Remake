unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    ListFiles:TStringList;

    procedure LoadItemsListBox;
    procedure ReSelectListBox;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses UnitFormSearch;

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  ListFiles := TStringList.Create;
  LoadItemsListBox;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  ListBox1.Items.SaveToFile('ListFolders.lst');
end;


procedure TForm1.LoadItemsListBox;
begin
  ListBox1.Clear;
  if FileExists('ListFolders.lst') then
    ListBox1.Items.LoadFromFile('ListFolders.lst');

  if ListBox1.Count <= 0 then
  begin
    ListBox1.Items.Add(ExtractFilePath(ExtractFileDir(Application.ExeName)));
    ListBox1.Items.Add(ExtractFilePath(ExtractFileDir(ExtractFileDir(Application.ExeName))) + 'kam_remake');
  end;

  ReSelectListBox;
end;


procedure TForm1.ReSelectListBox;
begin
  if ListBox1.ItemIndex < 0 then
    ListBox1.ItemIndex := 0;

  Button3.Enabled := ListBox1.ItemIndex >= 2;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
    Paths: Array of String;
    SL: TStringList;
    I: Integer;
begin
  SetLength(Paths, ListBox1.Items.Count);
  for I := 0 to ListBox1.Items.Count - 1 do
    Paths[I] := ListBox1.Items[I];
  SL := TStringList.Create;
  FormSearch.StartLFtoCRLF(Paths, SL);
  Memo1.Text := SL.Text;
end;


end.
