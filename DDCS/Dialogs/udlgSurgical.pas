unit udlgSurgical;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ORDtTm, ORCtrls,
  uDialog, DDCSComBroker;

type
  TdlgSurgical = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Edit19: TEdit;
    btnNeg: TBitBtn;
    meComments: TCaptionMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    ORDateBox1: TORDateBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    Edit1: TEdit;
    ORDateBox2: TORDateBox;
    Edit2: TEdit;
    ORDateBox3: TORDateBox;
    Edit3: TEdit;
    ORDateBox4: TORDateBox;
    Edit4: TEdit;
    ORDateBox5: TORDateBox;
    Edit5: TEdit;
    ORDateBox6: TORDateBox;
    Edit6: TEdit;
    ORDateBox7: TORDateBox;
    Edit7: TEdit;
    ORDateBox8: TORDateBox;
    Edit8: TEdit;
    ORDateBox9: TORDateBox;
    lbComments: TLabel;
    lbTreatment: TLabel;
    lbComment: TLabel;
    pnlLabels: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    lbOther1: TLabel;
    dtOther1: TORDateBox;
    edOtherComments1: TEdit;
    edOther1: TEdit;
    lbOther2: TLabel;
    dtOther2: TORDateBox;
    edOtherComments2: TEdit;
    edOther2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure btnNegClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgSurgical: TdlgSurgical;

implementation

{$R *.dfm}

procedure TdlgSurgical.FormCreate(Sender: TObject);
var
  I: Integer;

  procedure SetSay(wControl: TWinControl);
  var
    I: Integer;
  begin
    for I := 0 to pnlLabels.ControlCount - 1 do
      if pnlLabels.Controls[I].Tag = wControl.Tag then
      begin
        SayOnFocus(wControl, TLabel(pnlLabels.Controls[I]).Caption);
        Break;
      end;
  end;

begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TCheckbox) or (Components[I] is TEdit) then
      SetSay(TWinControl(Components[I]));
  end;

  SayOnFocus(edOtherComments1, 'Other Surgery Comment');
  SayOnFocus(edOtherComments2, 'Other Surgery Comment');
end;

procedure TdlgSurgical.CheckBoxClick(Sender: TObject);
var
  I: Integer;
  ick,ck: TCheckBox;
  ce: TEdit;
  cd: TORDateBox;
begin
  ick := TCheckBox(Sender);

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TCheckbox then
    begin
      ck := TCheckBox(Components[I]);
      if ((ck <> ick) and (ck.Tag = ick.Tag)) then
      begin
        ck.OnClick := nil;
        ck.Checked := False;
        ck.OnClick := CheckBoxClick;
      end;
    end;
    if Components[I] is TEdit then
      if Components[I].Tag = ick.Tag then
      begin
        ce := TEdit(Components[I]);
        if ick.Caption = 'No' then
        begin
          ce.Clear;
          ce.Enabled := False;
        end else
          ce.Enabled := True;
      end;
    if Components[I] is TORDateBox then
      if Components[I].Tag = ick.Tag then
      begin
        cd := TORDateBox(Components[I]);
        if ick.Caption = 'No' then
        begin
          cd.Clear;
          cd.Enabled := False;
        end else
          cd.Enabled := True;
      end;
  end;
end;

procedure TdlgSurgical.btnNegClick(Sender: TObject);
var
  I: Integer;
  ck: TCheckBox;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TCheckbox then
    begin
      ck := TCheckBox(Components[I]);
      if ck.Caption = 'No' then
        ck.Checked := True;
    end;
  end;
end;

procedure TdlgSurgical.bbtnOKClick(Sender: TObject);
var
  I: Integer;
  ck: TCheckBox;
  tmp: string;

  function GetQuestion(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to pnlLabels.ControlCount - 1 do
      if pnlLabels.Controls[I].Tag = iTag then
      begin
        Result := TLabel(pnlLabels.Controls[I]).Caption + ': ';
        Break;
      end;
  end;

  function GetDate(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to ComponentCount - 1 do
      if Components[I].Tag = iTag then
        if Components[I] is TORDateBox then
          if TORDateBox(Components[I]).IsValid then
          begin
            Result := TORDateBox(Components[I]).Text;
            Break;
          end;
  end;

  function GetNarrative(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to ComponentCount - 1 do
      if Components[I].Tag = iTag then
        if ((Components[I] is TEdit) and
            not (Components[I] is TORDateBox)) then
        begin
          Result := TEdit(Components[I]).Text;
          Break;
        end;
  end;

begin
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TCheckbox then
    begin
      ck := TCheckBox(Components[I]);

      if ck.Checked then
      begin
        TmpStrList.Add('  ' + GetQuestion(ck.Tag) + ' ' + ck.Caption);
        if ck.Caption <> 'No' then
        begin
          tmp := GetDate(ck.Tag);
          if tmp <> '' then
            TmpStrList.Add('    Surgery Date: ' + tmp);
          tmp := GetNarrative(ck.Tag);
          if tmp <> '' then
            TmpStrList.Add('    Comments: ' + tmp);
        end;
      end;
    end;

  if Trim(edOther1.Text) <> '' then
  begin
    TmpStrList.Add('  ' + edOther1.Text);

    if dtOther1.Text <> '' then
      TmpStrList.Add('    Surgery Date: ' + dtOther1.Text);
    if edOtherComments1.Text <> '' then
      TmpStrList.Add('    Comments: ' + edOtherComments1.Text);
  end;

  if Trim(edOther2.Text) <> '' then
  begin
    TmpStrList.Add('  ' + edOther2.Text);

    if dtOther2.Text <> '' then
      TmpStrList.Add('    Surgery Date: ' + dtOther2.Text);
    if edOtherComments2.Text <> '' then
      TmpStrList.Add('    Comments: ' + edOtherComments2.Text);
  end;

  if meComments.Lines.Count > 0 then
  begin
    TmpStrList.Add('  Comments:');
    for I := 0 to meComments.Lines.Count - 1 do
      TmpStrList.Add('   ' + meComments.Lines[I]);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Surgical History: ');
end;

end.
