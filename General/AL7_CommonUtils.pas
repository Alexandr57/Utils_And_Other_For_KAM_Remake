unit AL7_CommonUtils;
interface
uses System.SysUtils;

function StrSubstring(const aStr: AnsiString; aFrom, aLength: Integer): AnsiString; overload;
function StrSubstring(const aStr: AnsiString; aFrom: Integer): AnsiString; overload;
function StrSubstring(const aStr: AnsiString; aSubStr: AnsiString): AnsiString; overload;
function StrSubstring(const aStr: AnsiString; aSubStr: AnsiString; aToStr: AnsiString): AnsiString; overload;
function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString): AnsiString; overload;
function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString; aLength: Integer): AnsiString; overload;
function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString; aToStr: AnsiString): AnsiString; overload;

implementation


function StrSubstring(const aStr: AnsiString; aFrom, aLength: Integer): AnsiString;
begin
  Result := Copy(aStr, aFrom, aLength);
end;


function StrSubstring(const aStr: AnsiString; aFrom: Integer): AnsiString;
begin
  Result := StrSubstring(aStr, aFrom, Length(aStr));
end;


function StrSubstring(const aStr: AnsiString; aSubStr: AnsiString): AnsiString;
var
  posStr, lenStr: Integer;
begin
  posStr := Pos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr));
  lenStr := Length(aSubStr);
  Result := StrSubstring(aStr, posStr, lenStr);
end;


function StrSubstring(const aStr: AnsiString; aSubStr: AnsiString; aToStr: AnsiString): AnsiString;
var
  posStr1, lenStr1, posStr2, lenStr2: Integer;
begin
  posStr1 := Pos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr));
  lenStr1 := Length(aSubStr);
  posStr2 := Pos(AnsiLowerCase(aToStr), AnsiLowerCase(aStr));
  lenStr2 := Length(aToStr);
  Result := StrSubstring(aStr, posStr1, posStr2 - (posStr1 + lenStr1));
end;


function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString): AnsiString;
var
  posStr, lenStr: Integer;
begin
  posStr := Pos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr));
  lenStr := Length(aSubStr);
  Result := StrSubstring(aStr, posStr + lenStr, Length(aStr));
end;


function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString; aLength: Integer): AnsiString; overload;
var
  posStr, lenStr: Integer;
begin
  posStr := Pos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr));
  lenStr := Length(aSubStr);
  Result := StrSubstring(aStr, posStr + lenStr, aLength);
end;


function StrSubstringFromSubstring(const aStr: AnsiString; aSubStr: AnsiString; aToStr: AnsiString): AnsiString;
var
  posStr1, lenStr1, posStr2, lenStr2: Integer;
begin
  posStr1 := Pos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr));
  lenStr1 := Length(aSubStr);
  posStr2 := Pos(AnsiLowerCase(aToStr), AnsiLowerCase(aStr));
  lenStr2 := Length(aToStr);
  Result := StrSubstring(aStr, posStr1 + lenStr1, posStr2 - (posStr1 + lenStr1));
end;


end.
