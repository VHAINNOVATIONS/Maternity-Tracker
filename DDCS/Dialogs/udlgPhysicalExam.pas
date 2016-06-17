unit udlgPhysicalExam;

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
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, uDialog,
  uExtndComBroker, ORDtTm;

type
  TdlgPhysicalExam = class(TDDCSDialog)
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnNorm: TBitBtn;
    pgBody: TPageControl;
    TabSheet1: TTabSheet;
    ORDateBox7: TORDateBox;
    Edit14: TEdit;
    ORDateBox14: TORDateBox;
    CheckBox6: TCheckBox;
    CheckBox3: TCheckBox;
    ORDateBox9: TORDateBox;
    ORDateBox8: TORDateBox;
    ORDateBox6: TORDateBox;
    ORDateBox5: TORDateBox;
    ORDateBox4: TORDateBox;
    ORDateBox3: TORDateBox;
    ORDateBox2: TORDateBox;
    ORDateBox13: TORDateBox;
    ORDateBox12: TORDateBox;
    ORDateBox11: TORDateBox;
    ORDateBox10: TORDateBox;
    ORDateBox1: TORDateBox;
    Edit9: TEdit;
    Edit8: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit13: TEdit;
    Edit12: TEdit;
    Edit11: TEdit;
    Edit10: TEdit;
    Edit1: TEdit;
    lbComment: TLabel;
    lbTreatment: TLabel;
    CheckBox41: TCheckBox;
    CheckBox40: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    pnllabels1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    TabSheet2: TTabSheet;
    CheckBox9: TCheckBox;
    pnllabels2: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    CheckBox12: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox42: TCheckBox;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    CheckBox49: TCheckBox;
    CheckBox50: TCheckBox;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    ORDateBox16: TORDateBox;
    ORDateBox17: TORDateBox;
    ORDateBox18: TORDateBox;
    ORDateBox19: TORDateBox;
    ORDateBox21: TORDateBox;
    ORDateBox22: TORDateBox;
    ORDateBox23: TORDateBox;
    ORDateBox24: TORDateBox;
    ORDateBox25: TORDateBox;
    ORDateBox26: TORDateBox;
    ORDateBox27: TORDateBox;
    ORDateBox29: TORDateBox;
    Label31: TLabel;
    Label32: TLabel;
    Edit19: TEdit;
    ORDateBox15: TORDateBox;
    lbOther: TLabel;
    dtOther: TORDateBox;
    edOtherComments: TEdit;
    edOther: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNormClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure EditReadMe(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgPhysicalExam: TdlgPhysicalExam;

implementation

{$R *.dfm}

procedure TdlgPhysicalExam.FormCreate(Sender: TObject);
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
    begin
      if pgBody.Pages[I].Controls[J] is TCheckBox then
        SetSay(TWinControl(pgBody.Pages[I].Controls[J]));
      if pgBody.Pages[I].Controls[J] is TEdit then
        SetSay(TWinControl(pgBody.Pages[I].Controls[J]));
    end;
end;

procedure TdlgPhysicalExam.btnNormClick(Sender: TObject);
var
  I,J: Integer;
begin
  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[J] is TCheckBox then
        if TCheckBox(pgBody.Pages[I].Controls[J]).Caption = 'Normal' then
          TCheckBox(pgBody.Pages[I].Controls[J]).Checked := True;
end;

procedure TdlgPhysicalExam.CheckBoxClick(Sender: TObject);
var
  I,J: Integer;
  ick,ck: TCheckBox;
  dComment: string;
begin
  ick := TCheckBox(Sender);

  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[J].Tag = ick.Tag then
      begin
        if pgBody.Pages[I].Controls[J] is TCheckBox then
        begin
          ck := TCheckBox(pgBody.Pages[I].Controls[J]);
          if ck <> ick then
          begin
            ck.OnClick := nil;
            ck.Checked := False;
            ck.OnClick := CheckBoxClick;
          end;
        end else if pgBody.Pages[I].Controls[J] is TORDateBox then
        begin
          if not ick.Checked then
          begin
            TORDateBox(pgBody.Pages[I].Controls[J]).Clear;
            TORDateBox(pgBody.Pages[I].Controls[J]).Enabled := False;
          end else
            TORDateBox(pgBody.Pages[I].Controls[J]).Enabled := True;
        end else if pgBody.Pages[I].Controls[J] is TEdit then
        begin
          if not ick.Checked then
          begin
            TEdit(pgBody.Pages[I].Controls[J]).Clear;
            TEdit(pgBody.Pages[I].Controls[J]).Enabled := False;
          end else
          begin
            TEdit(pgBody.Pages[I].Controls[J]).Enabled := True;
            if TEdit(pgBody.Pages[I].Controls[J]).Text = '' then
            begin
              case ick.Tag of
                1 : dComment := 'Well developed, well nourished. No acute distress.';
                2 : dComment := 'Cooperative. Affect broad, congruent to speech content. No evidence of thought disorder. No suicidal ideation.';
                7 : dComment := 'Supple. No adenopathy. Thyroid not palpable. Trachea midline.';
                8 : dComment := 'No external lesions, no masses noted in breast tissue or axillary region. No nipple discharge.';
                9 : dComment := 'Symmetric expansion. Good air entry. No crackles, wheezes, rubs or rhonchi.';
               11 : dComment := 'Normal sinus rhythm. S1,S2 normal. No murmurs, rubs or gallops.';
               12 : dComment := 'Soft, non tender without rebound or guarding. No hepatomegaly.No splenomegaly, No other organomegaly.';
               14 : dComment := 'Clear, warm, dry, turgor Good.';
               15 : dComment := 'Intact and symmetrical. No joint tenderness or swelling no edema.';
               20 : dComment := 'No costovertebral angle tenderness.';
              end;
              TEdit(pgBody.Pages[I].Controls[J]).Text := dComment;
            end;
          end;
        end;
      end;
end;

procedure TdlgPhysicalExam.EditReadMe(Sender: TObject);
begin
  if ((Sender is TEdit) and (TEdit(Sender).Text <> '')) then
    if DDCSForm <> nil then
      if DDCSForm.ScreenReader <> nil then
        DDCSForm.ScreenReader.Say(TEdit(Sender).Text, False);
end;

procedure TdlgPhysicalExam.btnOKClick(Sender: TObject);
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

  function GetDate(iTag: Integer): string;
  var
    I,J: Integer;
  begin
    Result := '';
    for I := 0 to pgBody.PageCount - 1 do
      for J := 0 to pgBody.Pages[I].ControlCount - 1 do
        if pgBody.Pages[I].Controls[J].Tag = iTag then
          if pgBody.Pages[I].Controls[J] is TORDateBox then
            if TORDateBox(pgBody.Pages[I].Controls[J]).IsValid then
            begin
              Result := TORDateBox(pgBody.Pages[I].Controls[J]).Text;
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
        if pgBody.Pages[I].Controls[J].Tag = iTag then
          if ((pgBody.Pages[I].Controls[J] is TEdit) and
              not (pgBody.Pages[I].Controls[J] is TORDateBox)) then
          begin
            Result := TEdit(pgBody.Pages[I].Controls[J]).Text;
            Break;
          end;
  end;

begin
  for I := 0 to pgBody.PageCount - 1 do
    for J := 0 to pgBody.Pages[I].ControlCount - 1 do
      if pgBody.Pages[I].Controls[J] is TCheckbox then
      begin
        ck := TCheckBox(pgBody.Pages[I].Controls[J]);

        if ck.Checked then
        begin
          TmpStrList.Add('  ' + GetQuestion(ck.Tag) + ' ' + ck.Caption);

          tmp := GetDate(ck.Tag);
          if tmp <> '' then
            TmpStrList.Add('    Treatment Date: ' + tmp);
          tmp := GetNarrative(ck.Tag);
          if tmp <> '' then
            TmpStrList.Add('    Narrative: ' + tmp);
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
    TmpStrList.Insert(0, 'Physical Exam: ');
end;

end.
