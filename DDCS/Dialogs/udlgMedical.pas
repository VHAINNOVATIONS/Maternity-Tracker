unit udlgMedical;

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

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, uDialog, uExtndComBroker, ORDtTm;

type
  TdlgMedical = class(TDDCSDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit2: TEdit;
    Label6: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit3: TEdit;
    Label7: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Edit4: TEdit;
    Label8: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Edit5: TEdit;
    Label9: TLabel;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Edit6: TEdit;
    Label10: TLabel;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Edit7: TEdit;
    Label11: TLabel;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Edit8: TEdit;
    Label12: TLabel;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    Edit9: TEdit;
    Label13: TLabel;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Edit10: TEdit;
    Label14: TLabel;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    Edit11: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    Label17: TLabel;
    Label18: TLabel;
    Edit12: TEdit;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    Edit13: TEdit;
    Label20: TLabel;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    Edit14: TEdit;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    Edit15: TEdit;
    Label22: TLabel;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    Edit16: TEdit;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    Edit17: TEdit;
    Label27: TLabel;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    Edit21: TEdit;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    Edit22: TEdit;
    Label29: TLabel;
    LabeledEdit1: TLabeledEdit;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    CheckBox998: TCheckBox;
    CheckBox999: TCheckBox;
    Label24: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Edit26: TEdit;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    Label33: TLabel;
    Edit27: TEdit;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    CheckBox49: TCheckBox;
    CheckBox50: TCheckBox;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    Label34: TLabel;
    Edit28: TEdit;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    CheckBox997: TCheckBox;
    memNarrative: TMemo;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    ORDateBox1: TORDateBox;
    procedure FormCreate(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    VisitedTab2 : Boolean;
    VisitedTab3 : Boolean;
    Procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public
  end;

var
  dlgMedical: TdlgMedical;

implementation

{$R *.dfm}

Procedure TdlgMedical.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
    cb2.Checked := False;
end;

procedure TdlgMedical.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  VisitedTab2 := FALSE;
  VisitedTab3 := FALSE;
end;

procedure TdlgMedical.bbtnOKClick(Sender: TObject);
var
  I: Integer;
  TmpStr: string;

  function Check4True(InTS: TTabSheet): boolean;
  {Check for at least 1 checkbox = True }
  var
    J: Integer;
  begin
    for J := 0 to InTS.ControlCount - 1 do
      begin
        if (InTS.Controls[J] is TCheckBox) and ((InTS.Controls[J] as TCheckBox).Checked = True) then
          begin
            Result := True;
            Exit;
          end;
      end;
    Result := False;
  end;

  function TabNotVisited(InMsg: string; InTab: integer): boolean;
  begin
    if MessageDlg( InMsg, mtConfirmation,[mbYes,mbNo],0 ) = mrNo then
    begin
      ModalResult := mrNONE;
      PageControl1.ActivePageIndex := InTab;
      PageControl1Change(nil);
      Result := True;
    end else
      Result := False;
  end;

begin
  if VisitedTab2 = False then
  begin
    if TabNotVisited('You have not looked at the 2nd tab. Exit anyway?', 1) = True then
    Exit;
  end;

  TmpStrList.Add('Medical History:');
  for I := 0 to TabSheet1.ControlCount - 1 do
    if (TabSheet1.Controls[I] is TCheckBox) and ((TabSheet1.Controls[I] as TCheckBox).Checked = True) then
      begin
        TmpStr := '';
        case (TabSheet1.Controls[I] as TCheckBox).Tag of
          1 : begin
                TmpStr := 'Diabetes: POS';
                if CheckBox998.Checked then
                TmpStr := 'Diabetes Type I: POS';
                if CheckBox999.Checked then
                TmpStr := 'Diabetes Type II: POS';
                if CheckBox997.Checked then
                TmpStr := '  Gestational ' + TmpStr
                else TmpStr := '  ' + TmpStr;
                if Edit1.Text  <> '' then
                TmpStr := TmpStr + ' - Comments: ' + Edit1.Text;
              end;
          2 : begin
                TmpStr := '  Diabetes: NEG'; if Edit1.Text  <> '' then
                TmpStr := TmpStr + ' - Comments: ' + Edit1.Text;
              end;
          3 : begin TmpStr := '  Hypertension: POS'; if Edit2.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
          4 : begin TmpStr := '  Hypertension: NEG'; if Edit2.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit2.Text; end;
          5 : begin TmpStr := '  Heart Disease: POS'; if Edit3.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
          6 : begin TmpStr := '  Heart Disease: NEG'; if Edit3.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit3.Text; end;
          7 : begin TmpStr := '  Autoimmune Disorder: POS'; if Edit4.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
          8 : begin TmpStr := '  Autoimmune Disorder: NEG'; if Edit4.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit4.Text; end;
          9 : begin TmpStr := '  Kidney Disease/UTI: POS'; if Edit5.Text  <> '' then
              TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
          10 : begin TmpStr := '  Kidney Disease/UTI: NEG'; if Edit5.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit5.Text; end;
          11 : begin TmpStr := '  Neurologic/Epilepsy: POS'; if Edit6.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
          12 : begin TmpStr := '  Neurologic/Epilepsy: NEG'; if Edit6.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit6.Text; end;
          13 : begin TmpStr := '  Psychiatric (Other): POS'; if Edit7.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
          14 : begin TmpStr := '  Psychiatric (Other): NEG'; if Edit7.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit7.Text; end;
          15 : begin TmpStr := '  Depression/Anxiety: POS'; if Edit8.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
          16 : begin TmpStr := '  Depression/Anxiety: NEG'; if Edit8.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit8.Text; end;
          17 : begin TmpStr := '  Hepatitis/Liver Disease: POS'; if Edit9.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
          18 : begin TmpStr := '  Hepatitis/Liver Disease: NEG'; if Edit9.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit9.Text; end;
          19 : begin TmpStr := '  Varicosities/Phlebitis/Blood Clots: POS'; if Edit10.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
          20 : begin TmpStr := '  Varicosities/Phlebitis/Blood Clots: NEG'; if Edit10.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit10.Text; end;
          21 : begin TmpStr := '  Thyroid Dysfunction: POS'; if Edit11.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
          22 : begin TmpStr := '  Thyroid Dysfunction: NEG'; if Edit11.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit11.Text; end;
          23 : begin TmpStr := '  Rheumatic Fever: POS'; if Edit24.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
          24 : begin TmpStr := '  Rheumatic Fever: NEG'; if Edit24.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit24.Text; end;
          25 : begin TmpStr := '  Seizure Disorder: POS'; if Edit25.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
          26 : begin TmpStr := '  Seizure Disorder: NEG'; if Edit25.Text  <> '' then
               TmpStr := TmpStr + ' - Comments: ' + Edit25.Text; end;
        end; {end case}
        TmpStrList.Add(TmpStr);
      end;

      for I := 0 to TabSheet2.ControlCount -1 do
      begin
        if (TabSheet2.Controls[I] is TCheckBox) and ((TabSheet2.Controls[I] as TCheckBox).Checked = True) then
          begin
            TmpStr := '';
            case (TabSheet2.Controls[I] as TCheckBox).Tag of
              27 : begin TmpStr := '  Dermatologic Disorder: POS'; if Edit12.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
              28 : begin TmpStr := '  Dermatologic Disorder'; if Edit12.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit12.Text; end;
              29 : begin TmpStr := '  History of Blood Transfusion: POS'; if Edit13.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
              30 : begin TmpStr := '  History of Blood Transfusion: NEG'; if Edit13.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit13.Text; end;
              31 : begin TmpStr := '  Bleeding Tendencies: POS'; if Edit26.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
              32 : begin TmpStr := '  Bleeding Tendencies: NEG'; if Edit26.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit26.Text; end;
              33 : begin TmpStr := '  GI: Ulcers/Colitis/Reflux: POS'; if Edit27.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
              34 : begin TmpStr := '  GI: Ulcers/Colitis/Reflux: NEG'; if Edit27.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit27.Text; end;
              35 : begin TmpStr := '  D (Rh) Sensitized: POS'; if Edit14.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit14.Text; end;
              36 : begin TmpStr := '  D (Rh) Sensitized: NEG'; if Edit14.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit14.Text; end;
              37 : begin TmpStr := '  Pulmonary (TB/Asthma): POS'; if Edit15.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
              38 : begin TmpStr := '  Pulmonary (TB/Asthma): NEG'; if Edit15.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit15.Text; end;
              39 : begin TmpStr := '  Seasonal Allergies: POS'; if Edit16.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
              40 : begin TmpStr := '  Seasonal Allergies: NEG'; if Edit16.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit16.Text; end;
              41 : begin TmpStr := '  Breast Disease: POS'; if Edit17.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
              42 : begin TmpStr := '  Breast Disease: NEG'; if Edit17.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit17.Text; end;
//              43 : begin TmpStr := '  History of abnormal PAP: POS';
//                     if Edit21.Text  <> '' then TmpStr := TmpStr + ' - Comments: ' + Edit21.Text;
//                     if LabeledEdit2.Text <> '' then TmpStr := TmpStr + ' Date of Last PAP: ' + LabeledEdit2.Text;
//                   end;
//              44 : begin TmpStr := '  History of abnormal PAP: NEG';
//                     if Edit21.Text  <> '' then TmpStr := TmpStr + ' - Comments: ' + Edit21.Text;
//                     if LabeledEdit2.Text <> '' then TmpStr := TmpStr + ' Date of Last PAP: ' + LabeledEdit2.Text;
//                   end;
              45 : begin TmpStr := '  Uterine Anomaly/DE: POS'; if Edit22.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit22.Text; end;
              46 : begin TmpStr := '  Uterine Anomaly/DES: NEG'; if Edit22.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit22.Text; end;
              47 : begin TmpStr := '  Trauma/Violence: POS'; if Edit19.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
              48 : begin TmpStr := '  Trauma/Violence: NEG'; if Edit19.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit19.Text; end;
              49 : begin TmpStr := '  Broken Bone/Concussion: POS'; if Edit20.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit20.Text; end;
              50 : begin TmpStr := '  Broken Bone/Concussion: NEG'; if Edit20.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit20.Text; end;
              51 : begin TmpStr := '  Infertility Problems/Concerns: POS'; if Edit23.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit23.Text; end;
              52 : begin TmpStr := '  Infertility Problems/Concerns: NEG'; if Edit23.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit23.Text; end;
              53 : begin TmpStr := '  Used Reproductive Technologies?: POS'; if Edit28.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit28.Text; end;
              54 : begin TmpStr := '  Used Reproductive Technologies?: NEG'; if Edit28.Text  <> '' then
                   TmpStr := TmpStr + ' - Comments: ' + Edit28.Text; end;
            end; {end case}
            TmpStrList.Add(TmpStr);
          end;
          if (TabSheet2.Controls[I] is TLabeledEdit) then
          begin
            if TLabeledEdit(TabSheet2.Controls[I]).Text <> '' then
            TmpStrList.Add('  Other: ' + TLabeledEdit(TabSheet2.Controls[I]).Text);
          end;
      end;

      if memNarrative.Lines.Count > 0 then
      begin
        TmpStrList.Add('  Comments:');
        for I := 0 to memNarrative.Lines.Count - 1 do
          TmpStrList.Add('   ' + memNarrative.Lines[I]);
      end;
end;

procedure TdlgMedical.CheckBox1Click(Sender: TObject);
begin
 if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
    1: begin
         ToggleCB(CheckBox1,CheckBox2);
         CheckBox997.Enabled := True;
         CheckBox998.Enabled := True;
         CheckBox999.Enabled := True;
       end;
  998: ToggleCB(CheckBox998,CheckBox999);
  999: ToggleCB(CheckBox999,CheckBox998);
    2: begin
         ToggleCB(CheckBox2,CheckBox1);
         CheckBox997.Enabled := False;
         CheckBox998.Checked := False;
         CheckBox998.Enabled := False;
         CheckBox999.Checked := False;
         CheckBox999.Enabled := False;
       end;
    3: ToggleCB(CheckBox3,CheckBox4);
    4: ToggleCB(CheckBox4,CheckBox3);
    5: ToggleCB(CheckBox5,CheckBox6);
    6: ToggleCB(CheckBox6,CheckBox5);
    7: ToggleCB(CheckBox7,CheckBox8);
    8: ToggleCB(CheckBox8,CheckBox7);
    9: ToggleCB(CheckBox9,CheckBox10);
    10: ToggleCB(CheckBox10,CheckBox9);
    11: ToggleCB(CheckBox11,CheckBox12);
    12: ToggleCB(CheckBox12,CheckBox11);
    13: ToggleCB(CheckBox13,CheckBox14);
    14: ToggleCB(CheckBox14,CheckBox13);
    15: ToggleCB(CheckBox15,CheckBox16);
    16: ToggleCB(CheckBox16,CheckBox15);
    17: ToggleCB(CheckBox17,CheckBox18);
    18: ToggleCB(CheckBox18,CheckBox17);
    19: ToggleCB(CheckBox19,CheckBox20);
    20: ToggleCB(CheckBox20,CheckBox19);
    21: ToggleCB(CheckBox21,CheckBox22);
    22: ToggleCB(CheckBox22,CheckBox21);
    23: ToggleCB(CheckBox23,CheckBox24);
    24: ToggleCB(CheckBox24,CheckBox23);
    25: ToggleCB(CheckBox25,CheckBox26);
    26: ToggleCB(CheckBox26,CheckBox25);
    // Page 2
    27: ToggleCB(CheckBox27,CheckBox28);
    28: ToggleCB(CheckBox28,CheckBox27);
    29: ToggleCB(CheckBox29,CheckBox30);
    30: ToggleCB(CheckBox30,CheckBox29);
    31: ToggleCB(CheckBox31,CheckBox32);
    32: ToggleCB(CheckBox32,CheckBox31);
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
  end;
end;

procedure TdlgMedical.BitBtn2Click(Sender: TObject);
var  {1st tab}
  I : Integer;
begin   {Negative for all}
  if PageControl1.ActivePageIndex = 0 then
  begin
  for I := 0 to TabSheet1.ControlCount -1 do
    if (TabSheet1.Controls[I] is TCheckBox) then
      if TCheckBox(TabSheet1.Controls[I]).Tag < 900 then
        if Odd((TCheckBox(TabSheet1.Controls[I]).Tag)) = FALSE then
         TCheckBox(TabSheet1.Controls[I]).Checked := TRUE;
  end;

  if PageControl1.ActivePageIndex = 1 then
  begin
  for I := 0 to TabSheet2.ControlCount -1 do
    if (TabSheet2.Controls[I] is TCheckBox) then
      if Odd((TCheckBox(TabSheet2.Controls[I]).Tag)) = FALSE then
         TCheckBox(TabSheet2.Controls[I]).Checked := TRUE;
  end;
end;

procedure TdlgMedical.PageControl1Change(Sender: TObject);
begin
 case PageControl1.ActivePageIndex of
    1 : VisitedTab2 := TRUE;
    2 : VisitedTab3 := TRUE;
  end;
end;

end.


