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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Vcl.ComCtrls, uDialog, uExtndComBroker;

type
  TdlgPhysicalExam = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label13: TLabel;
    CheckBox36: TCheckBox;
    CheckBox35: TCheckBox;
    Edit18: TEdit;
    Label20: TLabel;
    CheckBox34: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox29: TCheckBox;
    Edit17: TEdit;
    Edit16: TEdit;
    Edit15: TEdit;
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
    CheckBox26: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Label19: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label29: TLabel;
    Label1: TLabel;
    Label2: TLabel;
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
    Label14: TLabel;
    Label15: TLabel;
    TabSheet2: TTabSheet;
    LabeledEdit1: TLabeledEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    Edit19: TEdit;
    Edit20: TEdit;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    Label26: TLabel;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    Edit21: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
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
    Label16: TLabel;
    Edit14: TEdit;
    CheckBox55: TCheckBox;
    CheckBox56: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
  public
  end;

var
  dlgPhysicalExam: TdlgPhysicalExam;

implementation

{$R *.dfm}

procedure TdlgPhysicalExam.BitBtn1Click(Sender: TObject);
var
  I: Integer;
begin   {Normal for all}
  if PageControl1.ActivePageIndex = 0 then
  begin
  for I := 0 to TabSheet1.ControlCount -1 do
    if (TabSheet1.Controls[I] is TCheckBox) then
      if Odd(TCheckBox(TabSheet1.Controls[I]).Tag) then
        TCheckBox(TabSheet1.Controls[I]).Checked := True;
  end;

  if PageControl1.ActivePageIndex = 1 then
  begin
  for I := 0 to TabSheet2.ControlCount -1 do
    if (TabSheet2.Controls[I] is TCheckBox) then
      if Odd(TCheckBox(TabSheet2.Controls[I]).Tag) then
        TCheckBox(TabSheet2.Controls[I]).Checked := True;
  end;
end;

procedure TdlgPhysicalExam.CheckBox1Click(Sender: TObject);
begin
  if not (Sender is TCheckBox) then
    Exit;

  case (Sender as TCheckBox).Tag of
      1: begin
          ToggleCB(CheckBox1,CheckBox2);
          Edit1.Text := 'Well developed, well nourished. No acute distress.';
        end;
      2: begin
          ToggleCB(CheckBox2,CheckBox1);
          if Edit1.Text = 'Well developed, well nourished. No acute distress.' then
            Edit1.Text := '';
        end;
     3: begin
          ToggleCB(CheckBox3,CheckBox4);
          Edit2.Text := 'Cooperative. Affect broad, congruent to speech content. No evidence of thought disorder. No suicidal ideation.';
        end;
     4: begin
          ToggleCB(CheckBox4,CheckBox3);
          if Edit2.Text = 'Cooperative. Affect broad, congruent to speech content. No evidence of thought disorder. No suicidal ideation.' then
            Edit2.Text := '';
        end;
     5: ToggleCB(CheckBox5,CheckBox6);
     6: ToggleCB(CheckBox6,CheckBox5);
     7: ToggleCB(CheckBox7,CheckBox8);
     8: ToggleCB(CheckBox8,CheckBox7);
     9: ToggleCB(CheckBox9,CheckBox10);
    10: ToggleCB(CheckBox10,CheckBox9);
    11: ToggleCB(CheckBox11,CheckBox12);
    12: ToggleCB(CheckBox12,CheckBox11);
    13: begin
          ToggleCB(CheckBox13,CheckBox14);
          Edit7.Text := 'Supple. No adenopathy. Thyroid not palpable. Trachea midline.';
        end;
    14: begin
          ToggleCB(CheckBox14,CheckBox13);
          if Edit7.Text = 'Supple. No adenopathy. Thyroid not palpable. Trachea midline.' then
            Edit7.Text := '';
        end;
    15: begin
          ToggleCB(CheckBox15,CheckBox16);
          Edit8.Text := 'No external lesions, no masses noted in breast tissue or axillary region.  No nipple discharge.';
        end;
    16: begin
          ToggleCB(CheckBox16,CheckBox15);
          if Edit8.Text = 'No external lesions, no masses noted in breast tissue or axillary region.  No nipple discharge.' then
            Edit8.Text := '';
        end;
    17: begin
          ToggleCB(CheckBox17,CheckBox18);
          Edit9.Text := 'Symmetric expansion.  Good air entry.  No crackles, wheezes, rubs or rhonchi.';
        end;
    18: begin
          ToggleCB(CheckBox18,CheckBox17);
          if Edit9.Text = 'Symmetric expansion.  Good air entry.  No crackles, wheezes, rubs or rhonchi.' then
            Edit9.Text := '';
        end;
    19: ToggleCB(CheckBox19,CheckBox20);
    20: ToggleCB(CheckBox20,CheckBox19);
    21: begin
          ToggleCB(CheckBox21,CheckBox22);
          Edit11.Text := 'Normal sinus rhythm. S1,S2 normal. No murmurs, rubs or gallops.';
        end;
    22: begin
          ToggleCB(CheckBox22,CheckBox21);
          if Edit11.Text = 'Normal sinus rhythm. S1,S2 normal. No murmurs, rubs or gallops.' then
            Edit11.Text := '';
        end;
    23: begin
          ToggleCB(CheckBox23,CheckBox24);
          Edit12.Text := 'Soft, non tender without rebound or guarding. No hepatomegaly.No splenomegaly, No other organomegaly.';
        end;
    24: begin
          ToggleCB(CheckBox24,CheckBox23);
          if Edit12.Text = 'Soft, non tender without rebound or guarding. No hepatomegaly.No splenomegaly, No other organomegaly.' then
            Edit12.Text := '';
        end;
    25: ToggleCB(CheckBox25,CheckBox26);
    26: ToggleCB(CheckBox26,CheckBox25);
    29: begin
          ToggleCB(CheckBox29,CheckBox30);
          Edit15.Text := 'Intact and symmetrical.  No joint tenderness or swelling no edema.';
        end;
    30: begin
          ToggleCB(CheckBox30,CheckBox29);
          if Edit15.Text = 'Intact and symmetrical.  No joint tenderness or swelling no edema.' then
            Edit15.Text := '';
        end;
    31: begin
          ToggleCB(CheckBox31,CheckBox32);
          Edit16.Text := 'Clear, Warm, Dry, Turgor Good';
        end;
    32: begin
          ToggleCB(CheckBox32,CheckBox31);
          if Edit16.Text = 'Clear, Warm, Dry, Turgor Good' then
            Edit16.Text := '';
        end;
    33: ToggleCB(CheckBox33,CheckBox34);
    34: ToggleCB(CheckBox34,CheckBox33);
    35: ToggleCB(CheckBox35,CheckBox36);
    36: ToggleCB(CheckBox36,CheckBox35);
    37: ToggleCB(CheckBox37,CheckBox38);
    38: ToggleCB(CheckBox38,CheckBox37);
    39: ToggleCB(CheckBox39,CheckBox40);
    40: ToggleCB(CheckBox40,CheckBox39);
    41: ToggleCB(CheckBox41,CheckBox42);
    42: ToggleCB(CheckBox42,CheckBox41);
    43: ToggleCB(CheckBox43,CheckBox44);
    44: ToggleCB(CheckBox44,CheckBox43);
    45: ToggleCB(CheckBox45,CheckBox46);
    46: ToggleCB(CheckBox46,CheckBox45);
    47: ToggleCB(CheckBox47,CheckBox48);
    48: ToggleCB(CheckBox48,CheckBox47);
    49: ToggleCB(CheckBox49,CheckBox50);
    50: ToggleCB(CheckBox50,CheckBox49);
    51: ToggleCB(CheckBox51,CheckBox52);
    52: ToggleCB(CheckBox52,CheckBox51);
    53: ToggleCB(CheckBox53,CheckBox54);
    54: ToggleCB(CheckBox54,CheckBox53);
    55: begin
          ToggleCB(CheckBox55,CheckBox56);
          Edit14.Text := 'No costovertebral angle tenderness.';
        end;
    56: begin
          ToggleCB(CheckBox56,CheckBox55);
          if Edit14.Text = 'No costovertebral angle tenderness.' then
            Edit14.Text := '';
        end;
  end;
end;

procedure TdlgPhysicalExam.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TdlgPhysicalExam.ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
begin
  cb1.OnClick := nil;
  cb2.OnClick := nil;

  if cb1.Checked = True then
    cb2.Checked := False;

  cb1.OnClick := CheckBox1Click;
  cb2.OnClick := CheckBox1Click;
end;

procedure TdlgPhysicalExam.bbtnOKClick(Sender: TObject);
var
  I: integer;
  TmpStr: string;

  function Check4True: Boolean;
  {Check for at least 1 checkbox = True }
  var
    J: Integer;
  begin
    for J := 0 to ComponentCount - 1 do
    begin
      if (Components[J] is TCheckBox) and ((Components[J] as TCheckBox).Checked = True) then
      begin
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  if Check4True then
  begin
    TmpStrList.Add('Physical Exam:');

    for I := 0 to ComponentCount - 1 do
    if (Components[I] is TCheckBox) and ((Components[I] as TCheckBox).Checked = True) then
    begin
      TmpStr := '';
      case (Components[I] as TCheckBox).Tag of
         1: begin TmpStr := '  General: Normal'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         2: begin TmpStr := '  General: Abnormal'; if Edit1.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit1.Text; end;
         3: begin TmpStr := '  Psych: Normal'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         4: begin TmpStr := '  Psych: Abnormal'; if Edit2.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
         5: begin TmpStr := '  Mouth: Normal'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         6: begin TmpStr := '  Mouth: Abnormal'; if Edit3.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
         7: begin TmpStr := '  Fundi: Normal'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         8: begin TmpStr := '  Fundi: Abnormal'; if Edit4.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
         9: begin TmpStr := '  Teeth: Normal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        10: begin TmpStr := '  Teeth: Abnormal'; if Edit5.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
        11: begin TmpStr := '  Endocrine: Normal'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        12: begin TmpStr := '  Endocrine: Abnormal'; if Edit6.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
        13: begin TmpStr := '  Neck: Normal'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        14: begin TmpStr := '  Neck: Abnormal'; if Edit7.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
        15: begin TmpStr := '  Breasts: Normal'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        16: begin TmpStr := '  Breasts: Abnormal'; if Edit8.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
        17: begin TmpStr := '  Thorax/Lungs: Normal'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        18: begin TmpStr := '  Thorax/Lungs: Abnormal'; if Edit9.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
        19: begin TmpStr := '  Heart: Normal'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        20: begin TmpStr := '  Heart: Abnormal'; if Edit10.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
        21: begin TmpStr := '  Cardiovascular: Normal'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        22: begin TmpStr := '  Cardiovascular: Abnormal'; if Edit11.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
        23: begin TmpStr := '  Abdomen: Normal'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        24: begin TmpStr := '  Abdomen: Abnormal'; if Edit12.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
        25: begin TmpStr := '  Musculoskeletal: Normal'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
        26: begin TmpStr := '  Musculoskeletal: Abnormal'; if Edit13.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
       31: begin TmpStr := '  Integumentary: Normal'; if Edit16.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
        32: begin TmpStr := '  Integumentary: Abnormal'; if Edit16.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
        29: begin TmpStr := '  Extremities: Normal'; if Edit15.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
        30: begin TmpStr := '  Extremities: Abnormal'; if Edit15.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
        35: begin TmpStr := '  Ears: Normal'; if Edit18.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit18.Text; end;
        36: begin TmpStr := '  Ears: Abnormal'; if Edit18.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit18.Text; end;
        33: begin TmpStr := '  Lymph Nodes: Normal'; if Edit17.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
        34: begin TmpStr := '  Lymph Nodes: Abnormal'; if Edit17.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
        37: begin TmpStr := '  Eyes: Normal'; if Edit19.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
        38: begin TmpStr := '  Eyes: Abnormal'; if Edit19.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
        39: begin TmpStr := '  Head: Normal'; if Edit20.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit20.Text; end;
        40: begin TmpStr := '  Head: Abnormal'; if Edit20.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit20.Text; end;
        41: begin TmpStr := '  Visible Implanted Medical Devices: Normal'; if Edit21.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit21.Text; end;
        42: begin TmpStr := '  Visible Implanted Medical Devices: Abnormal'; if Edit21.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit21.Text; end;
        43: begin TmpStr := '  Chest Wall: Normal'; if Edit22.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit22.Text; end;
        44: begin TmpStr := '  Chest Wall: Abnormal'; if Edit22.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit22.Text; end;
        45: begin TmpStr := '  Respiratory: Normal'; if Edit23.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit23.Text; end;
        46: begin TmpStr := '  Respiratory: Abnormal'; if Edit23.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit23.Text; end;
        47: begin TmpStr := '  Vessels: Normal'; if Edit24.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
        48: begin TmpStr := '  Vessels: Abnormal'; if Edit24.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
        49: begin TmpStr := '  Neurologic: Normal'; if Edit25.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
        50: begin TmpStr := '  Neurologic: Abnormal'; if Edit25.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
        51: begin TmpStr := '  Genitalia: Normal'; if Edit26.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
        52: begin TmpStr := '  Genitalia: Abnormal'; if Edit26.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
        53: begin TmpStr := '  Rectum: Normal'; if Edit27.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
        54: begin TmpStr := '  Rectum: Abnormal'; if Edit27.Text  <> '' then
             TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
      end;
      TmpStrList.Add(TmpStr);
    end;

    if Trim(LabeledEdit1.Text) <> '' then
    TmpStrList.Add('  Other: ' + LabeledEdit1.Text);
  end;
end;

end.
