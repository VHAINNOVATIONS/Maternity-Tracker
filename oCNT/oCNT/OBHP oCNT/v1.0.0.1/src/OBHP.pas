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
  Dialogs, StdCtrls, ImgList, ExtCtrls, Spin, Buttons, uExtndComBroker, oCNTBase;

type
  TForm1 = class(TForm)
    ofrm1: ToForm;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    MemoComplaints: TMemo;
    ListBoxComplaints: TListBox;
    ButtonComplaintClear: TButton;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    RadioGroupImport: TRadioGroup;
    ButtonReload: TButton;
    RadioGroupHistory: TRadioGroup;
    MemoHistory: TMemo;
    ListBoxMedicalHist: TListBox;
    ButtonHistoryClear: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ButtonEDDCal: TButton;
    MemoPreNatal: TMemo;
    ButtonPreNatalNormal: TButton;
    ButtonPlanClear: TButton;
    ListBoxFamilyHist: TListBox;
    ListBoxSocialHist: TListBox;
    MemoOBExam: TMemo;
    Label7: TLabel;
    ButtonOBExam: TButton;
    ButtonOBClear: TButton;
    Label8: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    SpinEdit7: TSpinEdit;
    Label15: TLabel;
    SpinEdit8: TSpinEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LabeledEdit1: TLabeledEdit;
    ButtonLMPDate: TSpeedButton;
    MemoROS: TMemo;
    ButtonROS: TButton;
    ButtonROSClear: TButton;
    MemoPhysical: TMemo;
    ButtonPhysical: TButton;
    ButtonPhysicalClear: TButton;
    Panel3: TPanel;
    MemoAllergies: TMemo;
    MemoActiveMedications: TMemo;
    MemoActiveProblems: TMemo;
    procedure ClearTextClick(Sender: TObject);
    procedure ButtonReloadClick(Sender: TObject);
    procedure RadioGroupImportClick(Sender: TObject);
    procedure RadioGroupHistoryClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
  private
    Created: Boolean;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
var
  sl: TStringList;
begin
  if not Created then
  begin
    ButtonReloadClick(Sender);
    RadioGroupImport.ItemIndex := 0;
    RadioGroupHistory.ItemIndex := 0;

    sl := TStringList.Create;
    try
      try
        sl.AddStrings(RPCBrokerV.GetPatientVitals);
      except
      end;
    finally
      sl.Free;
    end;

    ofrm1.PageIndex := 0;

    Created := True;
  end;
end;

//-------------------------------------------------------------------- shared

procedure TForm1.ClearTextClick(Sender: TObject);
begin
  if not (Sender is TButton) then Exit;

  if MessageDlg('Are you sure you want to clear all the text?', mtWarning, mbYesNo, 0) = mrYes then
  begin
    case TButton(Sender).Tag of
    1: MemoComplaints.Clear;
    2: MemoHistory.Clear;
    3: MemoROS.Clear;
    4: MemoPhysical.Clear;
    5: MemoOBExam.Clear;
    6: MemoPreNatal.Clear;
    end;
  end;
end;

//-------------------------------------------------------------------- page 1
// Vitals SetUp in FormCreate

//-------------------------------------------------------------------- page 2

procedure TForm1.Panel3Resize(Sender: TObject);
begin
  Panel3.Top := 104;
end;

procedure TForm1.RadioGroupImportClick(Sender: TObject);
begin
  if RadioGroupImport.ItemIndex = -1 then Exit;

  case RadioGroupImport.ItemIndex of
  0: begin
//       MemoAllergies.Show;
       MemoAllergies.BringToFront;
       MemoActiveProblems.Align := alCustom;
       MemoActiveMedications.Align := alCustom;
       MemoAllergies.Align := alBottom;
//       MemoActiveProblems.SendToBack;
//       MemoActiveProblems.Hide;
//       MemoActiveMedications.SendToBack;
//       MemoActiveMedications.Hide;
     end;
  1: begin
//       MemoActiveProblems.Show;
       MemoActiveProblems.BringToFront;
       MemoAllergies.Align := alCustom;
       MemoActiveMedications.Align := alCustom;
       MemoActiveProblems.Align := alBottom;
//       MemoAllergies.SendToBack;
//       MemoAllergies.Hide;
//       MemoActiveMedications.SendToBack;
//       MemoActiveMedications.Hide;
     end;
  2: begin
//       MemoActiveMedications.Show;
       MemoActiveMedications.BringToFront;
       MemoAllergies.Align := alCustom;
       MemoActiveProblems.Align := alCustom;
       MemoActiveMedications.Align := alBottom;
//       MemoActiveProblems.SendToBack;
//       MemoActiveProblems.Hide;
//       MemoAllergies.SendToBack;
//       MemoAllergies.Hide;
     end;
  end;
end;

procedure TForm1.ButtonReloadClick(Sender: TObject);
var
  sl: TStringList;
  I,J: Integer;
begin
  sl := TStringList.Create;
  try
    for I := 0 to RadioGroupImport.Items.Count - 1 do
    begin
      case I of
      0: begin
           sl.Clear;
           MemoAllergies.Clear;
           try
             sl.AddStrings(RPCBrokerV.GetPatientAllergies);
             if sl.Count > 0 then
             begin
               MemoAllergies.Lines.Add('ALLERGIES:');
               for J := 0 to sl.Count - 1 do
               MemoAllergies.Lines.Add('  ' + Piece(sl[J],U,2));
             end;
           except
           end;
         end;
      1: begin
           sl.Clear;
           MemoActiveProblems.Clear;
           sl.AddStrings(RPCBrokerV.GetPatientActiveProblems);
           MemoActiveProblems.Lines.AddStrings(sl);
         end;
      2: begin
           sl.Clear;
           MemoActiveMedications.Clear;
           sl.AddStrings(RPCBrokerV.GetPatientActiveMedications);
           MemoActiveMedications.Lines.AddStrings(sl);
         end;
      end;
    end;
    MemoAllergies.Align := alBottom;
    MemoAllergies.BringToFront;
  finally
    sl.Free;
  end;
end;

//-------------------------------------------------------------------- page 3

procedure TForm1.RadioGroupHistoryClick(Sender: TObject);
begin
  if RadioGroupHistory.ItemIndex = -1 then Exit;

  case RadioGroupHistory.ItemIndex of
  0: begin
       ListBoxMedicalHist.Show;
       ListBoxMedicalHist.BringToFront;
       ListBoxFamilyHist.SendToBack;
       ListBoxFamilyHist.Hide;
       ListBoxSocialHist.SendToBack;
       ListBoxSocialHist.Hide;
     end;
  1: begin
       ListBoxFamilyHist.Show;
       ListBoxFamilyHist.BringToFront;
       ListBoxSocialHist.SendToBack;
       ListBoxSocialHist.Hide;
       ListBoxMedicalHist.SendToBack;
       ListBoxMedicalHist.Hide;
     end;
  2: begin
       ListBoxSocialHist.Show;
       ListBoxSocialHist.BringToFront;
       ListBoxMedicalHist.SendToBack;
       ListBoxMedicalHist.Hide;
       ListBoxFamilyHist.SendToBack;
       ListBoxFamilyHist.Hide;
     end;
  end;
end;

//-------------------------------------------------------------------- page 4
// no additional code needed

//-------------------------------------------------------------------- page 5
// no additional code needed

//-------------------------------------------------------------------- page 6
// no additional code needed

//-------------------------------------------------------------------- page 7
// no additional code needed

end.

