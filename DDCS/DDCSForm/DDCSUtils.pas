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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.CheckLst, Vcl.Grids,
  ORDtTm, ORCtrls;

const
  U = '^';

type
  TShow508MessageIcon = (smiNone, smiInfo, smiWarning, smiError, smiQuestion);
  TShow508MessageButton = (smbOK, smbOKCancel, smbAbortRetryCancel, smbYesNoCancel, smbYesNo, smbRetryCancel);
  TShow508MessageResult = (smrOK, srmCancel, smrAbort, smrRetry, smrIgnore, smrYes, smrNo);

  function ShowMsg(const Msg, Caption: string; Icon: TShow508MessageIcon = smiNone;
                   Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
  function ShowMsg(const Msg: string; Icon: TShow508MessageIcon = smiNone;
                   Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
  function Piece(const S: string; Delim: char; PieceNum: Integer): string;
  // Using VAUtils will return up to LastNum of delimiter even if the pieces didn't exist in the string
  function Pieces(const S: string; Delim: char; FirstNum, LastNum: Integer): string;
  function SubCount(S: string; C: Char): Integer;

implementation

uses
  VAUtils;

// Replacement of and Redirection to VAUtils -----------------------------------
function ShowMsg(const Msg, Caption: string; Icon: TShow508MessageIcon = smiNone;
                 Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
var
  Flags, Answer: Longint;
  Title: string;
begin
  Flags := MB_TOPMOST;
  case Icon of
    smiInfo:      Flags := Flags OR MB_ICONINFORMATION;
    smiWarning:   Flags := Flags OR MB_ICONWARNING;
    smiError:     Flags := Flags OR MB_ICONERROR;
    smiQuestion:  Flags := Flags OR MB_ICONQUESTION;
  end;
  case Buttons of
    smbOK:                Flags := Flags OR MB_OK;
    smbOKCancel:          Flags := Flags OR MB_OKCANCEL;
    smbAbortRetryCancel:  Flags := Flags OR MB_ABORTRETRYIGNORE;
    smbYesNoCancel:       Flags := Flags OR MB_YESNOCANCEL;
    smbYesNo:             Flags := Flags OR MB_YESNO;
    smbRetryCancel:       Flags := Flags OR MB_RETRYCANCEL;
  end;
  Title := Caption;
  if Title = '' then
    Title := ExtractFileName(GetModuleName(HInstance));
  Answer := Application.MessageBox(PChar(Msg), PChar(Title), Flags);
  case Answer of
    IDCANCEL: Result := srmCancel;
    IDABORT:  Result := smrAbort;
    IDRETRY:  Result := smrRetry;
    IDIGNORE: Result := smrIgnore;
    IDYES:    Result := smrYes;
    IDNO:     Result := smrNo;
    else      Result := smrOK; // IDOK
  end;
end;

function ShowMsg(const Msg: string; Icon: TShow508MessageIcon = smiNone;
                 Buttons: TShow508MessageButton = smbOK): TShow508MessageResult; overload;
var
  Caption: string;
begin
  Caption := '';
  case Icon of
    smiWarning:   Caption := ' Warning';
    smiError:     Caption := ' Error';
    smiQuestion:  Caption := ' Inquiry';
  end;
  Caption := ExtractFileName(GetModuleName(HInstance)) + Caption;
  Result := ShowMsg(Msg, Caption, Icon, Buttons);
end;

function Piece(const S: string; Delim: char; PieceNum: Integer): string;
begin
  Result := VAUtils.Piece(S, Delim, PieceNum);
end;

function Pieces(const S: string; Delim: char; FirstNum, LastNum: Integer): string;
{ returns several contiguous pieces without extra delimiters}
var
  sl: TStringList;
  I: Integer;
begin
  Result := '';

  sl := TStringList.Create;
  try
    sl.Delimiter := Delim;
    sl.StrictDelimiter := True;
    sl.DelimitedText := S;

    if FirstNum > sl.Count then
      Exit;

    for I := FirstNum - 1 to sl.Count - 1 do
    begin
      Result := Result + U + sl[I];

      if I = LastNum - 1 then
        Break;
    end;

    if Length(Result) > 0 then
      Delete(Result, 1, 1);
  finally
    sl.Free;
  end;
end;

function SubCount(S: string; C: Char): Integer;
var
  I: Integer;
begin
  Result := 0;

  for I := 0 to Length(S) - 1 do
    if S[I] = C then
      inc(Result);
end;

end.
