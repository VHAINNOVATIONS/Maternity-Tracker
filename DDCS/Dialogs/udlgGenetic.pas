unit udlgGenetic;

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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, uDialog,
  uExtndComBroker;

type
  TdlgGenetic = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnNeg: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    pnllabels1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Label14: TLabel;
    Edit14: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
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
    CheckBox40: TCheckBox;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    pgBody: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox43: TCheckBox;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    CheckBox55: TCheckBox;
    CheckBox56: TCheckBox;
    CheckBox57: TCheckBox;
    CheckBox58: TCheckBox;
    CheckBox59: TCheckBox;
    CheckBox60: TCheckBox;
    CheckBox61: TCheckBox;
    CheckBox62: TCheckBox;
    CheckBox65: TCheckBox;
    CheckBox76: TCheckBox;
    CheckBox80: TCheckBox;
    CheckBox81: TCheckBox;
    CheckBox82: TCheckBox;
    CheckBox83: TCheckBox;
    CheckBox84: TCheckBox;
    Edit15: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit26: TEdit;
    Edit28: TEdit;
    pnlLabels2: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit23: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNegClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgGenetic: TdlgGenetic;

implementation

{$R *.dfm}

procedure TdlgGenetic.FormCreate(Sender: TObject);
var
  I,J: Integer;

  procedure SetSay(wControl: TWinControl);
  var
    I: Integer;
  begin
    for I := 0 to pnlLabels1.ControlCount - 1 do
      if pnlLabels1.Controls[I].Tag = wControl.Tag then
      begin
        SayOnFocus(wControl, TLabel(pnlLabels1.Controls[I]).Caption);
        Exit;
      end;
    for I := 0 to pnlLabels2.ControlCount - 1 do
      if pnlLabels2.Controls[I].Tag = wControl.Tag then
      begin
        SayOnFocus(wControl, TLabel(pnlLabels2.Controls[I]).Caption);
        Break;
      end;
  end;

begin
  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[J] is TCheckBox then
        SetSay(TWinControl(pgBody.Pages[I].Controls[J]));
end;

procedure TdlgGenetic.btnNegClick(Sender: TObject);
var
  I,J: Integer;
begin
  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[J] is TCheckBox then
        if TCheckBox(pgBody.Pages[I].Controls[J]).Caption = 'No' then
          TCheckBox(pgBody.Pages[I].Controls[J]).Checked := True;
end;

procedure TdlgGenetic.CheckBoxClick(Sender: TObject);
var
  I,J: Integer;
  ick,ck: TCheckBox;
  ce: TEdit;
begin
  ick := TCheckBox(Sender);

  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
    begin
      if pgBody.Pages[I].Controls[J] is TCheckBox then
        if pgBody.Pages[I].Controls[J].Tag = ick.Tag then
        begin
          ck := TCheckBox(pgBody.Pages[I].Controls[J]);
          if ck <> ick then
          begin
            ck.OnClick := nil;
            ck.Checked := False;
            ck.OnClick := CheckBoxClick;
          end;
        end;
      if pgBody.Pages[I].Controls[J] is TEdit then
        if pgBody.Pages[I].Controls[J].Tag = ick.Tag then
        begin
          ce := TEdit(pgBody.Pages[I].Controls[J]);
          if ick.Caption = 'No' then
          begin
            ce.Clear;
            ce.Enabled := False;
          end else
            ce.Enabled := True;
        end;
    end;
end;

procedure TdlgGenetic.btnOKClick(Sender: TObject);
var
  I,J: Integer;
  ck: TCheckBox;
  tmp: string;

  function GetQuestion(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to pnlLabels1.ControlCount - 1 do
      if pnlLabels1.Controls[I].Tag = iTag then
      begin
        Result := TLabel(pnlLabels1.Controls[I]).Caption;
        Exit;
      end;
    for I := 0 to pnlLabels2.ControlCount - 1 do
      if pnlLabels2.Controls[I].Tag = iTag then
      begin
        Result := TLabel(pnlLabels2.Controls[I]).Caption;
        Break;
      end;
  end;

  function GetNarrative(iTag: Integer): string;
  var
    I,J: Integer;
  begin
    Result := '';
    for I := 0 to pgBody.PageCount - 1 do
      for J := 0 to pgBody.Pages[I].ControlCount - 1 do
        if pgBody.Pages[I].Controls[J] is TEdit then
          if pgBody.Pages[I].Controls[J].Tag = iTag then
          begin
            Result := TEdit(pgBody.Pages[I].Controls[J]).Text;
            Break;
          end;
  end;

begin
  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[I] is TCheckbox then
      begin
        ck := TCheckBox(pgBody.Pages[I].Controls[J]);

        if ck.Checked then
        begin
          TmpStrList.Add('  ' + GetQuestion(ck.Tag) + ' ' + ck.Caption);
          if ck.Caption <> 'No' then
          begin
            tmp := GetNarrative(ck.Tag);
            if tmp <> '' then
              TmpStrList.Add('    Narrative: ' + tmp);
          end;
        end;
      end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Genetic Screening: ');
end;

end.
