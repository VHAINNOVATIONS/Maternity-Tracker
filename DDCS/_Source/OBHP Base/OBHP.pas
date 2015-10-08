unit OBHP;

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
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Variants, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, CheckLst, Vcl.ComCtrls,
  uExtndComBroker, oCNTBase, frmVitals;

type
  TForm1 = class(TForm)
    ofrm1: ToForm;
    MemoOBExam: TMemo;
    ButtonOBFlow: TButton;
    MemoROS: TMemo;
    ButtonROS: TButton;
    MemoPhysical: TMemo;
    ButtonPhysical: TButton;
    ButtonOBExam: TButton;
    oPage3: ToPage;
    ListBoxComplaints: TCheckListBox;
    MemoComplaints: TMemo;
    Label1: TStaticText;
    cklstProblems: TCheckListBox;
    MemoPreNatal: TMemo;
    lblProblems: TStaticText;
    RadioGroupHistory: TRadioGroup;
    ButtonHistoryClear: TButton;
    pnlHistory: TPanel;
    Panel4: TPanel;
    MemoHistory: TMemo;
    Panel5: TPanel;
    Panel6: TPanel;
    memoAllergies: TMemo;
    memoActiveMedications: TMemo;
    Panel7: TPanel;
    ButtonOBClear: TButton;
    Panel8: TPanel;
    btnEducation: TButton;
    ButtonPreNatalNormal: TButton;
    ButtonPlanClear: TButton;
    Panel9: TPanel;
    ButtonPhysicalClear: TButton;
    Panel10: TPanel;
    ButtonROSClear: TButton;
    Panel11: TPanel;
    ButtonReload: TButton;
    Panel12: TPanel;
    ButtonComplaintClear: TButton;
    Panel13: TPanel;
    RadioGroupImport: TRadioGroup;
    Panel3: TPanel;
    ListBoxFamilyHist: TCheckListBox;
    ListBoxMedicalHist: TCheckListBox;
    ListBoxSocialHist: TCheckListBox;
    RadioGroup3: TRadioGroup;
    RadioReason: TGroupBox;
    memChief: TMemo;
    Panel1: TPanel;
    grpSummary: TGroupBox;
    oPage2: ToPage;
    lbSummary: TLabel;
    procedure ClearTextClick(Sender: TObject);
    procedure ButtonReloadClick(Sender: TObject);
    procedure RadioGroupImportClick(Sender: TObject);
    procedure RadioGroupHistoryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cklstProblemsClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    problemck: Boolean;
    problems: array of Boolean;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SetLength(problems, 0);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ButtonReloadClick(Sender);
  RadioGroupImport.ItemIndex := 0;
  RadioGroupHistory.ItemIndex := 0;
end;

//-------------------------------------------------------------------- shared

procedure TForm1.ClearTextClick(Sender: TObject);
var
  I: Integer;
begin
  if not (Sender is TButton) then Exit;

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
// no additional code needed

//-------------------------------------------------------------------- page 2
// no additional code needed

//-------------------------------------------------------------------- page 3
// no additional code needed

//-------------------------------------------------------------------- page 4

procedure TForm1.RadioGroupImportClick(Sender: TObject);
begin
  if RadioGroupImport.ItemIndex = -1 then Exit;

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
  if RadioGroupHistory.ItemIndex = -1 then Exit;

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

