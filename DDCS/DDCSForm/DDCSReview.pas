unit DDCSReview;

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
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfReview = class(TForm)
    pnlControl: TPanel;
    btnAccept: TBitBtn;
    btnReturn: TBitBtn;
    meNote: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  fReview: TfReview;

implementation

{$R *.dfm}

uses
  DDCSCommon, DDCSForm, DDCSUtils, DDCSComBroker;

procedure TfReview.FormCreate(Sender: TObject);
var
  sReturn: string;
begin
  if (RPCBrokerV = nil) or (DDCSObjects = nil) then
    Exit;
  try
    UpdateContext(MENU_CONTEXT);
    sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'PREVIEW TITLE']);
    if sReturn <> '' then
      Caption := sReturn;

    sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'PREVIEW READONLY']);
    if sReturn <> '' then
      meNote.ReadOnly := StrToBool(sReturn);
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

procedure TfReview.FormShow(Sender: TObject);
const
  LEFT_MARGIN = 4;
var
  MaxNoteWidth: Integer;
  sReturn: string;

  function TextWidthByFont(AFontHandle: THandle; const x: string): Integer;
  var
    DC: HDC;
    SaveFont: HFont;
    TextSize: TSize;
  begin
    DC := GetDC(0);
    try
      SaveFont := SelectObject(DC, AFontHandle);
      try
        GetTextExtentPoint32(DC, PChar(x), Length(x), TextSize);
        Result := TextSize.cx;
      finally
        SelectObject(DC, SaveFont);
      end;
    finally
      ReleaseDC(0, DC);
    end;
  end;

begin
  MaxNoteWidth := TextWidthByFont(meNote.Font.Handle, StringOfChar('X', 80))
                  + (LEFT_MARGIN * 2) + GetSystemMetrics(SM_CYVSCROLL);
  if meNote.Width < MaxNoteWidth then
    meNote.Constraints.MaxWidth := MaxNoteWidth;

  try
    if btnAccept.Enabled then
    begin
      meNote.Font.Color := clBlack;
      btnAccept.SetFocus;

      UpdateContext(MENU_CONTEXT);
      sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'FINISH READONLY']);
      if sReturn <> '' then
        meNote.ReadOnly := StrToBool(sReturn)
      else
        meNote.ReadOnly := False;
    end
    else
    begin
      meNote.Font.Color := clGray;
      btnReturn.SetFocus;

      UpdateContext(MENU_CONTEXT);
      sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'PREVIEW READONLY']);
      if sReturn <> '' then
        meNote.ReadOnly := StrToBool(sReturn)
      else
        meNote.ReadOnly := True;
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

end.
