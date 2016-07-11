unit frmMain;

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
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls, ORCtrls,
  uBase, frmVitals, uReportItems;

type
  TForm1 = class(TForm)
    DDCSForm1: TDDCSForm;
    oPage1: TTabSheet;
    RadioGroup3: TRadioGroup;
    memChief: TCaptionMemo;
    lbSummary: TStaticText;
    oPage2: TTabSheet;
    DDCSVitals: TDDCSVitals;
    oPage3: TTabSheet;
    ListBoxComplaints: TCheckListBox;
    MemoComplaints: TCaptionMemo;
    oPage4: TTabSheet;
    RadioGroupImport: TRadioGroup;
    oPage5: TTabSheet;
    RadioGroupHistory: TRadioGroup;
    ButtonHistoryClear: TButton;
    pnlHistoryCategories: TPanel;
    ListBoxFamilyHist: TCheckListBox;
    ListBoxMedicalHist: TCheckListBox;
    ListBoxSocialHist: TCheckListBox;
    MemoHistory: TCaptionMemo;
    oPage6: TTabSheet;
    ButtonROS: TButton;
    ButtonROSClear: TButton;
    MemoROS: TCaptionMemo;
    oPage7: TTabSheet;
    ButtonPhysicalClear: TButton;
    ButtonPhysical: TButton;
    MemoPhysical: TCaptionMemo;
    oPage8: TTabSheet;
    ButtonOBFlow: TButton;
    ButtonOBExam: TButton;
    ButtonOBClear: TButton;
    MemoOBExam: TCaptionMemo;
    oPage9: TTabSheet;
    lbProblems: TLabel;
    cklstProblems: TCheckListBox;
    btnEducation: TButton;
    ButtonPreNatalNormal: TButton;
    ButtonPlanClear: TButton;
    MemoPreNatal: TCaptionMemo;
    lbChiefComplaint: TLabel;
    lbAdditionalComplaints: TLabel;
    ButtonComplaintClear: TButton;
    lbComplaintsSection: TLabel;
    pnlSectionImports: TPanel;
    ButtonReload: TButton;
    lbImportSection: TLabel;
    lbHistorySection: TLabel;
    lbRosSection: TLabel;
    lbPhysicalSection: TLabel;
    lbPelvicSection: TLabel;
    lbPlanSection: TLabel;
    pnlAllergies: TPanel;
    memoAllergiesNar: TMemo;
    memoAllergies: TMemo;
    lbAllergies: TLabel;
    pnlProblems: TPanel;
    lbActiveProblems: TLabel;
    memoProblemsNar: TMemo;
    memoProblems: TMemo;
    pnlMedications: TPanel;
    lbActiveMedications: TLabel;
    memoMedicationsNar: TMemo;
    memoMedications: TMemo;
    ckAllergyLatex: TCheckBox;
    ckPlannedAnesthesia: TCheckBox;
    ckBloodTransfusion: TCheckBox;
    ckACGeneral: TCheckBox;
    ckACEpidural: TCheckBox;
    ckACSpinal: TCheckBox;
    ckACOther: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ClearTextClick(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure RadioGroupImportClick(Sender: TObject);
    procedure pnlMedicationsResize(Sender: TObject);
    procedure pnlProblemsResize(Sender: TObject);
    procedure pnlAllergiesResize(Sender: TObject);
    procedure ckAllergyLatexClick(Sender: TObject);
    procedure RadioGroupHistoryClick(Sender: TObject);
    procedure pnlHistoryCategoriesEnter(Sender: TObject);
    procedure ckBloodTransfusionClick(Sender: TObject);
    procedure cklstProblemsClickCheck(Sender: TObject);
    procedure ckPlannedAnesthesiaClick(Sender: TObject);
    procedure ShowOnNote(Sender: TObject);
  private
    problemck: Boolean;
    problems: array of Boolean;
    oSummary: string;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uCommon, uExtndComBroker;

procedure TForm1.FormShow(Sender: TObject);
begin
  oSummary := lbSummary.Caption;

  RadioGroup3.OnClick := RadioGroup3Click;
  RadioGroup3Click(Sender);

  RadioGroupHistoryClick(RadioGroupHistory);
  RadioGroupImportClick(RadioGroupImport);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SetLength(problems, 0);
end;

//-------------------------------------------------------------------- shared

procedure TForm1.ClearTextClick(Sender: TObject);
var
  I: Integer;
begin
  if not (Sender is TButton) then
    Exit;

  if ShowMsg('Are you sure you want to clear all the text?', smiWarning, smbYesNo) = smrYes  then
  begin
    problemck := False;
    SetLength(problems, 0);

    case TButton(Sender).Tag of
      1: begin
           MemoComplaints.Clear;
           for I := 0 to ListBoxComplaints.Count - 1 do
             ListBoxComplaints.Checked[I] := False;
         end;
      2: begin
           MemoHistory.Clear;
           for I := 0 to ListBoxMedicalHist.Count - 1 do
             ListBoxMedicalHist.Checked[I] := False;
           for I := 0 to ListBoxSocialHist.Count - 1 do
             ListBoxSocialHist.Checked[I] := False;
           for I := 0 to ListBoxFamilyHist.Count - 1 do
             ListBoxFamilyHist.Checked[I] := False;
         end;
      3: MemoROS.Clear;
      4: MemoPhysical.Clear;
      5: MemoOBExam.Clear;
      6: begin
           MemoPreNatal.Clear;
           for I := 0 to cklstProblems.Count - 1 do
             cklstProblems.Checked[I] := False;
         end;
    end;
  end;
end;

//-------------------------------------------------------------------- page 1

procedure TForm1.RadioGroup3Click(Sender: TObject);
begin
  case RadioGroup3.ItemIndex of
    -1: begin
          if ((lbSummary.Caption <> '') and
              (lbSummary.Caption[Length(lbSummary.Caption)] <> '.')) then
            lbSummary.Caption := oSummary + '.';
        end;
     0: lbSummary.Caption := oSummary + ' and is here for a return visit.';
     1: lbSummary.Caption := oSummary + ' and is here for a new visit.';
     2: lbSummary.Caption := oSummary + ' and is being referred.';
  end;
end;

//-------------------------------------------------------------------- page 2
// no additional code needed

//-------------------------------------------------------------------- page 3
// no additional code needed

//-------------------------------------------------------------------- page 4

procedure TForm1.RadioGroupImportClick(Sender: TObject);
begin
  try
    case RadioGroupImport.ItemIndex of
      0: begin
           memoMedications.Clear;
           pnlMedications.BringToFront;
           memoMedications.TabStop := True;
           memoMedicationsNar.TabStop := True;
           memoMedications.Lines.AddStrings(DDCSForm1.GetPatientActiveMedications);
           memoProblems.TabStop := False;
           memoProblemsNar.TabStop := False;
           memoAllergies.TabStop := False;
           memoAllergiesNar.TabStop := False;
           pnlMedicationsResize(pnlMedications);
         end;
      1: begin
           memoProblems.Clear;
           pnlProblems.BringToFront;
           memoProblems.TabStop := True;
           memoProblemsNar.TabStop := True;
           memoProblems.Lines.AddStrings(DDCSForm1.GetPatientActiveProblems);
           memoMedications.TabStop := False;
           memoMedicationsNar.TabStop := False;
           memoAllergies.TabStop := False;
           memoAllergiesNar.TabStop := False;
           pnlProblemsResize(pnlProblems);
         end;
      2: begin
           memoAllergies.Clear;
           pnlAllergies.BringToFront;
           memoAllergies.TabStop := True;
           memoAllergiesNar.TabStop := True;
           memoAllergies.Lines.AddStrings(DDCSForm1.GetPatientAllergies);
           memoMedications.TabStop := False;
           memoMedicationsNar.TabStop := False;
           memoProblems.TabStop := False;
           memoProblemsNar.TabStop := False;
           pnlAllergiesResize(pnlAllergies);
         end;
    end;
  except
  end;
end;

procedure TForm1.pnlMedicationsResize(Sender: TObject);
var
  mHeight: Integer;
begin
  mHeight := (pnlMedications.Height - 27) div 2;

  memoMedications.Top := 0;
  memoMedications.Height := mHeight;
  lbActiveMedications.Top := mHeight + 10;
  memoMedicationsNar.Top := mHeight + 27;
  memoMedicationsNar.Height := mHeight;
end;

procedure TForm1.pnlProblemsResize(Sender: TObject);
var
  mHeight: Integer;
begin
  mHeight := (pnlProblems.Height - 27) div 2;

  memoProblems.Top := 0;
  memoProblems.Height := mHeight;
  lbActiveProblems.Top := mHeight + 10;
  memoProblemsNar.Top := mHeight + 27;
  memoProblemsNar.Height := mHeight;
end;

procedure TForm1.pnlAllergiesResize(Sender: TObject);
var
  mHeight: Integer;
begin
  mHeight := (pnlAllergies.Height - 27) div 2;

  memoAllergies.Top := 0;
  memoAllergies.Height := mHeight;
  ckAllergyLatex.Top := mHeight + 10;
  lbAllergies.Top := ckAllergyLatex.Top + ckAllergyLatex.Height + 10;
  memoAllergiesNar.Top := lbAllergies.Top + lbAllergies.Height + 5;
  memoAllergiesNar.Height := pnlAllergies.Height - memoAllergiesNar.Top;
end;

procedure TForm1.ckAllergyLatexClick(Sender: TObject);
begin
  if not ckAllergyLatex.Checked then
    Exit;

  if ShowMsg('By checking this box, I certify that I have asked ' + RPCBrokerV.PatientName +
             ' and verified NO known latex allergy.', smiWarning, smbYesNo) <> smrYes then
  begin
    ckAllergyLatex.OnClick := nil;
    ckAllergyLatex.Checked := False;
    ckAllergyLatex.OnClick := ckAllergyLatexClick;
  end;
end;

//-------------------------------------------------------------------- page 5

procedure TForm1.RadioGroupHistoryClick(Sender: TObject);
begin
  case RadioGroupHistory.ItemIndex of
    0: begin
         ListBoxMedicalHist.BringToFront;
         ListBoxMedicalHist.TabStop := True;
         ListBoxFamilyHist.TabStop := False;
         ListBoxSocialHist.TabStop := False;
       end;
    1: begin
         ListBoxFamilyHist.BringToFront;
         ListBoxFamilyHist.TabStop := True;
         ListBoxMedicalHist.TabStop := False;
         ListBoxSocialHist.TabStop := False;
       end;
    2: begin
         ListBoxSocialHist.BringToFront;
         ListBoxSocialHist.TabStop := True;
         ListBoxFamilyHist.TabStop := False;
         ListBoxMedicalHist.TabStop := False;
       end;
  end;
end;

procedure TForm1.pnlHistoryCategoriesEnter(Sender: TObject);
begin
  case RadioGroupHistory.ItemIndex of
    0: ListBoxMedicalHist.SetFocus;
    1: ListBoxFamilyHist.SetFocus;
    2: ListBoxSocialHist.SetFocus;
  end;
end;

//-------------------------------------------------------------------- page 6

procedure TForm1.ckBloodTransfusionClick(Sender: TObject);
begin
  if not ckBloodTransfusion.Checked then
    Exit;

  if ShowMsg('By checking this box, I certify that I have asked ' + RPCBrokerV.PatientName +
             ' and verified that if necessary, a blood transfusion is acceptable.', smiWarning, smbYesNo) <> smrYes then
  begin
    ckBloodTransfusion.OnClick := nil;
    ckBloodTransfusion.Checked := False;
    ckBloodTransfusion.OnClick := ckBloodTransfusionClick;
  end;
end;

//-------------------------------------------------------------------- page 7
// no additional code needed

//-------------------------------------------------------------------- page 8
// no additional code needed

//-------------------------------------------------------------------- page 9

procedure TForm1.cklstProblemsClickCheck(Sender: TObject);
var
  I: Integer;
begin
  if not problemck then
    SetLength(problems, cklstProblems.Count);

  for I := 0 to cklstProblems.Count - 1 do
    if cklstProblems.Checked[I] then
    begin
      if not problemck then
      begin
        MemoPreNatal.Lines.Add('Problems:');
        problemck := True;
      end;
      if not problems[I] then
      begin
        MemoPreNatal.Lines.Add('  ' + cklstProblems.Items[I]);
        problems[I] := True;
      end;
    end;
end;

procedure TForm1.ckPlannedAnesthesiaClick(Sender: TObject);
var
  nItem: TDDCSNoteItem;
begin
  if not ckPlannedAnesthesia.Checked then
  begin
    ckACGeneral.Visible  := False;
    ckACGeneral.Checked  := False;
    ckACEpidural.Visible := False;
    ckACEpidural.Checked := False;
    ckACSpinal.Visible   := False;
    ckACSpinal.Checked   := False;
    ckACOther.Visible    := False;
    ckACOther.Checked    := False;

    Exit;
  end;

  if ShowMsg('By checking this box, I certify that I have asked ' + RPCBrokerV.PatientName +
             ' and verified type of anesthesia planned with delivery.', smiWarning, smbYesNo) <> smrYes then
  begin
    ckPlannedAnesthesia.OnClick := nil;
    ckPlannedAnesthesia.Checked := False;
    ckPlannedAnesthesia.OnClick := ckPlannedAnesthesiaClick;

    ckACGeneral.Visible  := False;
    ckACGeneral.Checked  := False;
    ckACEpidural.Visible := False;
    ckACEpidural.Checked := False;
    ckACSpinal.Visible   := False;
    ckACSpinal.Checked   := False;
    ckACOther.Visible    := False;
    ckACOther.Checked    := False;
  end else
  begin
    ckACGeneral.Visible  := True;
    ckACEpidural.Visible := True;
    ckACSpinal.Visible   := True;
    ckACOther.Visible    := True;
  end;
end;

procedure TForm1.ShowOnNote(Sender: TObject);
var
  ck: TCheckBox;
  nItem: TDDCSNoteItem;
  I: Integer;
begin
  ck := TCheckBox(Sender);
  if ck.Checked then
  begin
    nItem := DDCSForm1.ReportCollection.GetNoteItem(ck);
    if nItem <> nil then
      nItem.HideFromNote := False;

    case ck.Tag of
      1: begin
           ckACEpidural.Checked := False;
           ckACSpinal.Checked   := False;
           ckACOther.Checked    := False;
         end;
      2: begin
           ckACGeneral.Checked  := False;
           ckACSpinal.Checked   := False;
           ckACOther.Checked    := False;
         end;
      3: begin
           ckACGeneral.Checked  := False;
           ckACEpidural.Checked := False;
           ckACOther.Checked    := False;
         end;
      4: begin
           ckACGeneral.Checked  := False;
           ckACEpidural.Checked := False;
           ckACSpinal.Checked   := False;
         end;
    end;

  end else if not ck.Checked then
  begin
    nItem := DDCSForm1.ReportCollection.GetNoteItem(ck);
    if nItem <> nil then
      nItem.HideFromNote := True;
  end;
end;

end.
