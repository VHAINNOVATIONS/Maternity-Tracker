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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v2.0.0.0  (full rewrite)
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, ORCtrls, uDialog, uCommon, uExtndComBroker, ORDtTm;

type
  TdlgROS = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnNeg: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label1: TStaticText;
    Label2: TStaticText;
    Label3: TStaticText;
    Label4: TStaticText;
    Label5: TStaticText;
    Label6: TStaticText;
    Label7: TStaticText;
    Label8: TStaticText;
    Label9: TStaticText;
    Label10: TStaticText;
    Label11: TStaticText;
    Label12: TStaticText;
    Label13: TStaticText;
    lbOther: TStaticText;
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
    Edit1: TCaptionEdit;
    Edit2: TCaptionEdit;
    Edit3: TCaptionEdit;
    Edit4: TCaptionEdit;
    Edit5: TCaptionEdit;
    Edit6: TCaptionEdit;
    Edit7: TCaptionEdit;
    Edit8: TCaptionEdit;
    Edit9: TCaptionEdit;
    Edit10: TCaptionEdit;
    Edit11: TCaptionEdit;
    Edit12: TCaptionEdit;
    Edit13: TCaptionEdit;
    edOther: TCaptionEdit;
    edOtherComments: TCaptionEdit;
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

procedure TdlgROS.CheckBoxClick(Sender: TObject);
var
  I: Integer;
  ick,ck: TCheckBox;
  ce: TCaptionEdit;
  cd: TORDateBox;
begin
  ick := TCheckBox(Sender);

  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TCheckbox then
    begin
      ck := TCheckBox(Controls[I]);
      if ((ck <> ick) and (ck.Tag = ick.Tag)) then
      begin
        ck.OnClick := nil;
        ck.Checked := False;
        ck.OnClick := CheckBoxClick;
      end;
    end;
    if Controls[I] is TCaptionEdit then
      if TCaptionEdit(Controls[I]).Tag = ick.Tag then
      begin
        ce := TCaptionEdit(Controls[I]);
        if ick.Caption = 'No' then
        begin
          ce.Clear;
          ce.Enabled := False;
        end else
          ce.Enabled := True;
      end;
    if Controls[I] is TORDateBox then
      if TORDateBox(Controls[I]).Tag = ick.Tag then
      begin
        cd := TORDateBox(Controls[I]);
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
  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TCheckbox then
    begin
      ck := TCheckBox(Controls[I]);
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
    for I := 0 to ControlCount - 1 do
      if Controls[I] is TStaticText then
        if TStaticText(Controls[I]).Tag = iTag then
        begin
          Result := TStaticText(Controls[I]).Caption + ': ';
          Break;
        end;
  end;

  function GetDate(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to ControlCount - 1 do
      if Controls[I] is TORDateBox then
        if TORDateBox(Controls[I]).Tag = iTag then
          if TORDateBox(Controls[I]).IsValid then
          begin
            Result := TORDateBox(Controls[I]).Text;
            Break;
          end;
  end;

  function GetNarrative(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to ControlCount - 1 do
      if Controls[I] is TCaptionEdit then
        if TCaptionEdit(Controls[I]).Tag = iTag then
        begin
          Result := TCaptionEdit(Controls[I]).Text;
          Break;
        end;
  end;

begin
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TCheckbox then
    begin
      ck := TCheckBox(Controls[I]);

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
            TmpStrList.Add('    Narrative: ' + tmp);
        end;
      end;
    end;

  if Trim(edOther.Text) <> '' then
  begin
    TmpStrList.Add('  ' + edOther.Text);

    if dtOther.Text <> '' then
      TmpStrList.Add('    Treatment Date: ' + dtOther.Text);
    if edOtherComments.Text <> '' then
      TmpStrList.Add('    Narrative: ' + edOtherComments.Text);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Review of Symptoms since Last Menstrual Period: ');
end;

end.
