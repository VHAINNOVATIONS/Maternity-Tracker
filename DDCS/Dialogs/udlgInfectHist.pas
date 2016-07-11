unit udlgInfectHist;

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

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, ORCtrls, uDialog, uCommon, uExtndComBroker;

type
  TdlgInfectHist = class(TDDCSDialog)
    pnlheader: TPanel;
    pnlbody: TPanel;
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StaticText1: TLabel;
    StaticText2: TLabel;
    StaticText3: TLabel;
    StaticText4: TLabel;
    StaticText5: TLabel;
    StaticText6: TLabel;
    StaticText7: TLabel;
    StaticText8: TLabel;
    StaticText9: TLabel;
    StaticText10: TLabel;
    StaticText11: TLabel;
    ckNotInfectionHistory: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    procedure ckNotInfectionHistoryClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgInfectHist: TdlgInfectHist;

implementation

{$R *.dfm}

procedure TdlgInfectHist.FormCreate(Sender: TObject);
var
  I: Integer;

  procedure SetSay(wControl: TWinControl);
  var
    I: Integer;
  begin
    for I := 0 to pnlbody.ControlCount - 1 do
      if ((pnlbody.Controls[I] is TLabel) and (pnlbody.Controls[I].Tag = wControl.Tag)) then
      begin
        SayOnFocus(wControl, TLabel(pnlbody.Controls[I]).Caption);
        Break;
      end;
  end;

begin
  for I := 0 to pnlbody.ControlCount - 1 do
  begin
    if pnlbody.Controls[I] is TCheckbox then
      SetSay(TWinControl(pnlbody.Controls[I]));
  end;
end;

procedure TdlgInfectHist.ckNotInfectionHistoryClick(Sender: TObject);
var
  I: Integer;
  ck: TCheckBox;
begin
  if ckNotInfectionHistory.Checked then
  begin
    pnlbody.Visible := False;
    for I := 0 to pnlbody.ControlCount - 1 do
    begin
      if pnlbody.Controls[I] is TCheckbox then
      begin
        ck := TCheckBox(pnlbody.Controls[I]);
        ck.OnClick := nil;
        ck.Checked := False;
        ck.OnClick := CheckBoxClick;
      end;
      if pnlbody.Controls[I] is TEdit then
        TEdit(pnlbody.Controls[I]).Clear;
    end;
  end else
    pnlbody.Visible := True;
end;

procedure TdlgInfectHist.CheckBoxClick(Sender: TObject);
var
  I: Integer;
  ick,ck: TCheckBox;
  ce: TEdit;
begin
  ick := TCheckBox(Sender);

  for I := 0 to pnlbody.ControlCount - 1 do
  begin
    if pnlbody.Controls[I] is TCheckbox then
    begin
      ck := TCheckBox(pnlbody.Controls[I]);
      if ((ck <> ick) and (ck.Tag = ick.Tag)) then
      begin
        ck.OnClick := nil;
        ck.Checked := False;
        ck.OnClick := CheckBoxClick;
      end;
    end;
    if pnlbody.Controls[I] is TEdit then
      if pnlbody.Controls[I].Tag = ick.Tag then
      begin
        ce := TEdit(pnlbody.Controls[I]);
        if ick.Caption = 'No' then
        begin
          ce.Clear;
          ce.Enabled := False;
        end else
          ce.Enabled := True;
      end;
  end;
end;

procedure TdlgInfectHist.bbtnOKClick(Sender: TObject);
var
  I: Integer;
  ck: TCheckBox;
  tmp: string;

  function GetQuestion(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to pnlbody.ControlCount - 1 do
      if pnlbody.Controls[I].Tag = iTag then
        if pnlbody.Controls[I] is TLabel then
        begin
          Result := TLabel(pnlbody.Controls[I]).Caption;
          if Result[Length(Result)] <> '?' then
            Result := Result + ':';
          Break;
        end;
  end;

  function GetNarrative(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to pnlbody.ControlCount - 1 do
      if pnlbody.Controls[I].Tag = iTag then
        if pnlbody.Controls[I] is TEdit then
        begin
          Result := TEdit(pnlbody.Controls[I]).Text;
          Break;
        end;
  end;

begin
  if ckNotInfectionHistory.Checked then
  begin
    TmpStrList.Add('Infection History: ');
    TmpStrList.Add('  No history of infection.')
  end else
  begin
    for I := 0 to pnlbody.ControlCount - 1 do
      if pnlbody.Controls[I] is TCheckbox then
      begin
        ck := TCheckBox(pnlbody.Controls[I]);

        if ck.Checked then
        begin
          TmpStrList.Add('  ' + GetQuestion(ck.Tag) + ' ' + ck.Caption);
          if ck.Caption <> 'No' then
          begin
            tmp := GetNarrative(ck.Tag);
            if tmp <> '' then
              TmpStrList.Add('    Comments: ' + tmp);
          end;
        end;
      end;

    if TmpStrList.Count > 0 then
      TmpStrList.Insert(0, 'Infection History: ');
  end;
end;

end.
