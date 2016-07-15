unit frmReview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TDDCSReview = class(TForm)
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
  DDCSReview: TDDCSReview;

implementation

{$R *.dfm}

uses
  uCommon, uExtndComBroker;

procedure TDDCSReview.FormCreate(Sender: TObject);
var
  tmp: string;
begin
  if RPCBrokerV = nil then
    Exit;

  try
    if UpdateContext(MENU_CONTEXT) then
    begin
      tmp := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW TITLE']);
      if tmp <> '' then
        Caption := tmp;

      tmp := '';
      tmp := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'PREVIEW READONLY']);
      if tmp <> '' then
        meNote.ReadOnly := StrToBool(tmp);
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

procedure TDDCSReview.FormShow(Sender: TObject);
const
  LEFT_MARGIN = 4;
var
  MaxNoteWidth: Integer;

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
  if btnAccept.Enabled then
  begin
    meNote.Font.Color := clBlack;
    meNote.ReadOnly := False;
    btnAccept.SetFocus;
  end else
  begin
    meNote.Font.Color := clGray;
    meNote.ReadOnly := True;
    btnReturn.SetFocus;
  end;

  MaxNoteWidth := TextWidthByFont(meNote.Font.Handle, StringOfChar('X', 80))
                  + (LEFT_MARGIN * 2) + GetSystemMetrics(SM_CYVSCROLL);
  if meNote.Width < MaxNoteWidth then
    meNote.Constraints.MaxWidth := MaxNoteWidth;
end;

end.
