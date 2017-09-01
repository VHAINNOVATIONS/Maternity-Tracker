unit DDCSUtils;
{
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

     Developer: Theodore Fontana
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Forms, ORFn;

const
  U = '^';

type
  TShow508MessageIcon = (smiNone, smiInfo, smiWarning, smiError, smiQuestion, smiConfirm);
  TShow508MessageButton = (smbOK, smbOKCancel, smbAbortRetryCancel, smbYesNoCancel, smbYesNo, smbRetryCancel);
  TShow508MessageResult = (smrOK, srmCancel, smrAbort, smrRetry, smrIgnore, smrYes, smrNo);

  function ValidateDateTime(ADateTime: string; var fDateTime: TFMDateTime): Boolean;

  function ShowMsg(const Msg, Caption: string; Icon: TShow508MessageIcon = smiNone;
                   Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
  function ShowMsg(const Msg: string; Icon: TShow508MessageIcon = smiNone;
                   Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;

  function SubCount(S: string; C: Char): Integer;
  function Piece(const S: string; Delim: Char; PieceNum: Integer): string;
  function Pieces(const S: string; Delim: Char; FirstNum,LastNum: Integer): string;

implementation

function ValidateDateTime(ADateTime: string; var fDateTime: TFMDateTime): Boolean;
begin
  Result := False;
  try
    if ADateTime = '' then
      Exit;

    if IsFMDateTime(ADateTime) then
    begin
      fDateTime := StrToFloat(ADateTime);
      Result := True;
      Exit;
    end;

    fDateTime := DateTimeToFMDateTime(StrToDateTime(ADateTime));
    Result := IsFMDateTime(FloatToStr(fDateTime));
  except
  end;
end;

function ShowMsg(const Msg, Caption: string; Icon: TShow508MessageIcon = smiNone;
  Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
var
  Flags,Answer: Longint;
  Title: string;
begin
  Flags := MB_TOPMOST;
  case Icon of
    smiInfo: Flags := Flags or MB_ICONINFORMATION;
    smiWarning: Flags := Flags or MB_ICONWARNING;
    smiError: Flags := Flags or MB_ICONERROR;
    smiQuestion: Flags := Flags or MB_ICONQUESTION;
    smiConfirm: Flags := Flags or MB_ICONQUESTION;
  end;
  case Buttons of
    smbOK: Flags := Flags or MB_OK;
    smbOKCancel: Flags := Flags or MB_OKCANCEL;
    smbAbortRetryCancel: Flags := Flags or MB_ABORTRETRYIGNORE;
    smbYesNoCancel: Flags := Flags or MB_YESNOCANCEL;
    smbYesNo: Flags := Flags or MB_YESNO;
    smbRetryCancel: Flags := Flags or MB_RETRYCANCEL;
  end;
  Title := Caption;
  if Title = '' then
    Title := ExtractFileName(GetModuleName(HInstance));
  Answer := Application.MessageBox(PChar(Msg), PChar(Title), Flags);
  case Answer of
    IDCANCEL: Result := srmCancel;
    IDABORT: Result := smrAbort;
    IDRETRY: Result := smrRetry;
    IDIGNORE: Result := smrIgnore;
    IDYES: Result := smrYes;
    IDNO: Result := smrNo;
    else
      Result := smrOK; // IDOK
  end;
end;

function ShowMsg(const Msg: string; Icon: TShow508MessageIcon = smiNone;
  Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
var
  Caption: string;
begin
  Caption := '';
  case Icon of
    smiWarning: Caption := ' Warning';
    smiError: Caption := ' Error';
    smiQuestion: Caption := ' Inquiry';
    smiConfirm: Caption := ' Confirm';
  end;
  Caption := ExtractFileName(GetModuleName(HInstance)) + Caption;
  Result := ShowMsg(Msg, Caption, Icon, Buttons);
end;

function SubCount(S: string; C: Char): Integer;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to Length(S) - 1 do
    if S[I] = C then
      Inc(Result);
end;

function Piece(const S: string; Delim: char; PieceNum: Integer): string;
{ returns the Nth piece (PieceNum) of a string delimited by Delim }
var
  I: Integer;
  Strt,Next: PChar;
begin
  I := 1;
  Strt := PChar(S);
  Next := StrScan(Strt, Delim);
  while (I < PieceNum) and (Next <> nil) do
  begin
    Inc(I);
    Strt := Next + 1;
    Next := StrScan(Strt, Delim);
  end;
  if Next = nil then
    Next := StrEnd(Strt);
  if I < PieceNum then
    Result := ''
  else
    SetString(Result, Strt, Next - Strt);
end;

function Pieces(const S: string; Delim: Char; FirstNum,LastNum: Integer): string;
{ returns several contiguous pieces }
var
  iCount,iPieceNum,I: Integer;
begin
  Result := '';

  iCount := FirstNum - 1;
  iPieceNum := SubCount(S, Delim) + 1;
  for I := FirstNum to LastNum do
  begin
    Inc(iCount);
    if iCount > iPieceNum then
      Break;

    Result := Result + Piece(S,Delim,I) + Delim;
  end;

  if Length(Result) > 0 then
    Delete(Result, Length(Result), 1);
end;

end.
