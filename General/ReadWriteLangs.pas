unit ReadWriteLangs;
interface

uses IniFiles, SysUtils, CONSTS;

type
  TUtilsLanguages=class
  private
  const
    FN_INI = 'Languages.ini';
  var
    fRunningUtils: TRunningUtils;
    fIniFile: TMemIniFile;
  public
    constructor Create(aRunningUtils: TRunningUtils);
    destructor Destroy; override;

    procedure CreateLineLangs;

    function ReadLineLang(aLang: String; aName: String): String;
  end;

implementation


{ TUtilsLanguages }


constructor TUtilsLanguages.Create(var aFileNameIni: String);
begin
  fIniFile := TMemIniFile.Create(FN_INI);
  CreateLineLangs;
end;


procedure TUtilsLanguages.CreateLineLangs;
begin
  if FileExists(FN_INI) then Exit;

  //Russian

  fIniFile.WriteString(LANG_RUS, 'tabFiles', 'Выбор текста');
  fIniFile.WriteString(LANG_RUS, 'tabEdit', 'Работа с текстом');
  fIniFile.WriteString(LANG_RUS, 'tabSettings', 'Настройки');
  fIniFile.WriteString(LANG_RUS, 'GroupBoxDir', 'Папки поиска');
  fIniFile.WriteString(LANG_RUS, 'GroupBoxLangs', 'Языки для редактирования');

  fIniFile.WriteString(LANG_RUS, TX_ERROR_LOAD_LANGS_KMR, 'Ошибка. Не удалось загрузить языки KAM Remake!');



  fIniFile.WriteString(LANG_RUS, CT_ERROR_LOAD_LANGS_KMR, 'Ошибка загрузки языков KMR!');

  //English

  fIniFile.WriteString(LANG_RUS, 'tabFiles', 'Text selection');
  fIniFile.WriteString(LANG_RUS, 'tabEdit', 'Edit Text');
  fIniFile.WriteString(LANG_RUS, 'tabSettings', 'Settings');
  fIniFile.WriteString(LANG_RUS, 'GroupBoxDir', 'Search Folders');
  fIniFile.WriteString(LANG_RUS, 'GroupBoxLangs', 'Editing Languages');

  fIniFile.WriteString(LANG_RUS, TX_ERROR_LOAD_LANGS_KMR, 'Error. Failed to load KAM Remake languages!');



  fIniFile.WriteString(LANG_RUS, CT_ERROR_LOAD_LANGS_KMR, 'Error loading KMR languages!');

end;


destructor TUtilsLanguages.Destroy;
begin
  FreeAndNil(fIniFile);
  inherited;
end;


function TUtilsLanguages.ReadLineLang(aLang, aName: String): String;
begin
  Result := fIniFile.ReadString(aLang, aName, 'No Name');
end;


end.
