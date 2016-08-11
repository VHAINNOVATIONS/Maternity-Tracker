unit udlgROS;

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
  Vcl.ExtCtrls, Vcl.Buttons, ORCtrls, ORDtTm, uDialog, uCommon, uExtndComBroker;

type
  TdlgROS = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnNeg: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lbOther: TLabel;
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
    ORDateBox1: TORDateBox;
    ORDateBox2: TORDateBox;
    ORDateBox3: TORDateBox;
    ORDateBox4: TORDateBox;
    ORDateBox5: TORDateBox;
    ORDateBox6: TORDateBox;
    ORDateBox7: TORDateBox;
    ORDateBox8: TORDateBox;
    ORDateBox9: TORDateBox;
    ORDateBox10: TORDateBox;
    ORDateBox11: TORDateBox;
    ORDateBox12: TORDateBox;
    ORDateBox13: TORDateBox;
    dtOther: TORDateBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    edOther: TEdit;
    edOtherComments: TEdit;
    lbTreatment: TLabel;
    lbComment: TLabel;
    pnlLabels: TPanel;
    Label10: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure btnNegClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgROS: TdlgROS;

implementation

{$R *.dfm}

procedure TdlgROS.FormCreate(Sender: TObject);
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
end;

procedure TdlgROS.CheckBoxClick(Sender: TObject);
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

procedure TdlgROS.btnNegClick(Sender: TObject);
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

procedure TdlgROS.btnOKClick(Sender: TObject);
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
            TmpStrList.Add('    Treatment Date: ' + tmp);
          tmp := GetNarrative(ck.Tag);
          if tmp <> '' then
            TmpStrList.Add('    Comments: ' + tmp);
        end;
      end;
    end;

  if Trim(edOther.Text) <> '' then
  begin
    TmpStrList.Add('  ' + edOther.Text);

    if dtOther.Text <> '' then
      TmpStrList.Add('    Treatment Date: ' + dtOther.Text);
    if edOtherComments.Text <> '' then
      TmpStrList.Add('    Comments: ' + edOtherComments.Text);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Review of Systems since Last Menstrual Period: ');
end;

end.
