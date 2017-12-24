unit Versions;
interface
uses Winapi.Windows, System.SysUtils, System.Classes;

function GetMyVersion(aRelease, aBuild: Boolean): string;

implementation

function GetMyVersion(aRelease, aBuild: Boolean): string;
type
  TVerInfo=packed record
    Nevazhno: array[0..47] of Byte; // ненужные нам 48 байт
    Minor,Major,Build,Release: Word; // а тут версия
  end;
var
  s:TResourceStream;
  v:TVerInfo;
  StrVer: String;
begin
  result:='';
  try
    s:=TResourceStream.Create(HInstance,'#1',RT_VERSION); // достаём ресурс
    if s.Size>0 then begin
      s.Read(v,SizeOf(v)); // читаем нужные нам байты
      StrVer := '';
      StrVer := IntToStr(v.Major)+'.'+IntToStr(v.Minor);
      if aRelease = True then
        StrVer := StrVer + '.' + IntToStr(v.Release);
      if aBuild = True then
        StrVer := StrVer + '.' + IntToStr(v.Build);

      result := StrVer;
    end;
  s.Free;
  except; end;
end;

end.
