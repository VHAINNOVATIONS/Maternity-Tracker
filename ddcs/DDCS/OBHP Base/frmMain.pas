unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  uExtndComBroker, oCNTBase, frmVitals,
  fBase508Form, VA508AccessibilityManager;

type
  TForm1 = class(TfrmBase508Form)
    ofrm1: ToForm;
    oPage1: ToPage;
    RadioGroup3: TRadioGroup;
    RadioReason: TGroupBox;
    memChief: TMemo;
    Panel1: TPanel;
    grpSummary: TGroupBox;
    lbSummary: TLabel;
    oPage2: ToPage;
    oPage3: ToPage;
    Panel14: TPanel;
    Label1: TStaticText;
    Panel12: TPanel;
    ButtonComplaintClear: TButton;
    ListBoxComplaints: TCheckListBox;
    Panel15: TPanel;
    MemoComplaints: TMemo;
    oPage4: ToPage;
    Panel5: TPanel;
    Panel11: TPanel;
    ButtonReload: TButton;
    Panel13: TPanel;
    RadioGroupImport: TRadioGroup;
    Panel6: TPanel;
    memoActiveMedications: TMemo;
    memoAllergies: TMemo;
    oPage5: ToPage;
    pnlHistory: TPanel;
    RadioGroupHistory: TRadioGroup;
    ButtonHistoryClear: TButton;
    Panel3: TPanel;
    ListBoxFamilyHist: TCheckListBox;
    ListBoxMedicalHist: TCheckListBox;
    ListBoxSocialHist: TCheckListBox;
    Panel4: TPanel;
    MemoHistory: TMemo;
    oPage6: ToPage;
    Panel16: TPanel;
    ButtonROS: TButton;
    Panel10: TPanel;
    ButtonROSClear: TButton;
    Panel17: TPanel;
    MemoROS: TMemo;
    oPage7: ToPage;
    Panel18: TPanel;
    Panel9: TPanel;
    ButtonPhysicalClear: TButton;
    ButtonPhysical: TButton;
    Panel19: TPanel;
    MemoPhysical: TMemo;
    oPage8: ToPage;
    Panel23: TPanel;
    ButtonOBFlow: TButton;
    ButtonOBExam: TButton;
    Panel7: TPanel;
    ButtonOBClear: TButton;
    Panel24: TPanel;
    MemoOBExam: TMemo;
    oPage9: ToPage;
    Panel22: TPanel;
    Panel20: TPanel;
    lblProblems: TStaticText;
    cklstProblems: TCheckListBox;
    Panel8: TPanel;
    btnEducation: TButton;
    ButtonPreNatalNormal: TButton;
    ButtonPlanClear: TButton;
    Panel21: TPanel;
    MemoPreNatal: TMemo;
    procedure ClearTextClick(Sender: TObject);
    procedure ButtonReloadClick(Sender: TObject);
    procedure RadioGroupImportClick(Sender: TObject);
    procedure RadioGroupHistoryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cklstProblemsClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
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
  VA508AccessibilityRouter;

procedure TForm1.FormShow(Sender: TObject);
begin
  ButtonReloadClick(Sender);
  RadioGroupImport.ItemIndex := 0;
  RadioGroupHistory.ItemIndex := 0;

  oSummary := lbSummary.Caption;
  RadioGroup3.OnClick := RadioGroup3Click;
  RadioGroup3Click(Sender);
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

  if MessageDlg('Are you sure you want to clear all the text?', mtWarning, mbYesNo, 0) = mrYes then
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
  if RadioGroupImport.ItemIndex = -1 then
    Exit;

  case RadioGroupImport.ItemIndex of
    0: begin
         MemoAllergies.BringToFront;
         MemoActiveMedications.SendToBack;
       end;
    1: begin
         MemoActiveMedications.BringToFront;
         MemoAllergies.SendToBack;
       end;
  end;
end;

procedure TForm1.ButtonReloadClick(Sender: TObject);
var
  I,J: Integer;
begin
  for I := 0 to RadioGroupImport.Items.Count - 1 do
  begin
    case I of
      0: begin
           MemoAllergies.Clear;
           try
             MemoAllergies.Lines.AddStrings(ofrm1.GetPatientAllergies);
           except
           end;
         end;
      1: begin
           MemoActiveMedications.Clear;
           try
             MemoActiveMedications.Lines.AddStrings(ofrm1.GetPatientActiveMedications);
           except
           end;
         end;
    end;
  end;
  RadioGroupImport.ItemIndex := 0;
end;

//-------------------------------------------------------------------- page 5

procedure TForm1.RadioGroupHistoryClick(Sender: TObject);
begin
  if RadioGroupHistory.ItemIndex = -1 then
    Exit;

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
