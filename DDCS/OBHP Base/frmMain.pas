unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls, ORCtrls,
  VAUtils, uBase, frmVitals, uExtndComBroker;

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
    lblProblems: TStaticText;
    cklstProblems: TCheckListBox;
    btnEducation: TButton;
    ButtonPreNatalNormal: TButton;
    ButtonPlanClear: TButton;
    MemoPreNatal: TCaptionMemo;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    ButtonComplaintClear: TButton;
    StaticText3: TStaticText;
    pnlSectionImports: TPanel;
    memoAllergies: TCaptionMemo;
    memoActiveMedications: TCaptionMemo;
    ButtonReload: TButton;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    procedure ClearTextClick(Sender: TObject);
    procedure RadioGroupImportClick(Sender: TObject);
    procedure RadioGroupHistoryClick(Sender: TObject);
    procedure cklstProblemsClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    -1: lbSummary.Caption := oSummary + '.';
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
           memoActiveMedications.Clear;
           memoActiveMedications.BringToFront;
           memoActiveMedications.Lines.AddStrings(DDCSForm1.GetPatientActiveMedications);
         end;
      1: begin
           memoAllergies.Clear;
           memoAllergies.BringToFront;
           memoAllergies.Lines.AddStrings(DDCSForm1.GetPatientAllergies);
         end;
    end;
  except
  end;
end;

//-------------------------------------------------------------------- page 5

procedure TForm1.RadioGroupHistoryClick(Sender: TObject);
begin
  case RadioGroupHistory.ItemIndex of
    0: ListBoxMedicalHist.BringToFront;
    1: ListBoxFamilyHist.BringToFront;
    2: ListBoxSocialHist.BringToFront;
  end;
end;

//-------------------------------------------------------------------- page 6
// no additional code needed

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

end.
