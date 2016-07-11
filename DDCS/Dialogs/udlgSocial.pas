unit udlgSocial;

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
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Buttons, ORDtTm,
  VA508AccessibilityManager, uDialog, uExtndComBroker, ORCtrls;

type
  TdlgSocial = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    pgBody: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet1: TTabSheet;
    lbSmoke: TLabel;
    lbChew: TLabel;
    lbSecond: TLabel;
    ckChewYes: TCheckBox;
    ckSmokeYes: TCheckBox;
    ckSecondYes: TCheckBox;
    ckSmokeNo: TCheckBox;
    ckChewNo: TCheckBox;
    ckSecondNo: TCheckBox;
    lbViolence: TLabel;
    edViolence: TEdit;
    ckViolenceNo: TCheckBox;
    ckViolenceYes: TCheckBox;
    edBirthControl: TEdit;
    ckSexTraumaYes: TCheckBox;
    ckSexTraumaNo: TCheckBox;
    edSexTrauma: TEdit;
    lbSexPartner: TLabel;
    ckSexPartnerYes: TCheckBox;
    ckSexPartnerNo: TCheckBox;
    edSexPartner: TEdit;
    lbSexConcerns: TLabel;
    ckSexConcernsYes: TCheckBox;
    ckSexConcernsNo: TCheckBox;
    edSexConcerns: TEdit;
    edEducationComment: TEdit;
    edLengthMilitaryComment: TEdit;
    edBranch: TEdit;
    lbEducation: TLabel;
    lbLengthMilitary: TLabel;
    lbBranch: TLabel;
    pnllabels1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox37: TCheckBox;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    edExercise: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    TabSheet4: TTabSheet;
    gbAlcohol: TGroupBox;
    gb5: TGroupBox;
    lbBirthControl: TLabel;
    lbSexTrauma: TLabel;
    ckSexTraumaUnknown: TCheckBox;
    ckViolenceUnknown: TCheckBox;
    pnlSmoke: TPanel;
    gbCig: TGroupBox;
    lbCig: TLabel;
    gbCigar: TGroupBox;
    lbCigar: TLabel;
    gbPipe: TGroupBox;
    lbPipeDay: TLabel;
    lbPipe: TLabel;
    pnlChew: TPanel;
    lbChewDay: TLabel;
    lbChewYears: TLabel;
    lbChewEpisode: TLabel;
    edChewEpisode: TEdit;
    spnChewDay: TSpinEdit;
    spnChewYears: TSpinEdit;
    lbSecondExpose: TLabel;
    spnSecondExpose: TSpinEdit;
    pnlMaster: TPanel;
    pnlCigSub: TPanel;
    spnCigYrs: TSpinEdit;
    lbCigYrs: TLabel;
    pnlCigarSub: TPanel;
    lbCigarYrs: TLabel;
    spnCigarYrs: TSpinEdit;
    pnlPipeSub: TPanel;
    lbPipeYrs: TLabel;
    spnPipeYrs: TSpinEdit;
    spnPipeDay: TSpinEdit;
    pnlAlcohol: TPanel;
    cbBeer: TComboBox;
    cbSpirit: TComboBox;
    cbWine: TComboBox;
    lbWineOften: TLabel;
    lbBeerOften: TLabel;
    lbSpiritOften: TLabel;
    lbWine: TLabel;
    lbBeer: TLabel;
    lbSpirit: TLabel;
    spnWine: TSpinEdit;
    spnBeer: TSpinEdit;
    spnSpirit: TSpinEdit;
    pnlDrugs: TPanel;
    cbHallucin: TComboBox;
    cbNarcotics: TComboBox;
    cbOther: TComboBox;
    cbHallucinRoute: TComboBox;
    cbNarcoticsRoute: TComboBox;
    cbOtherRoute: TComboBox;
    cbStimulantsRoute: TComboBox;
    cbStimulants: TComboBox;
    lbNarcotics: TLabel;
    lbStimulants: TLabel;
    lbOther: TLabel;
    lbNarcoticsRoute: TLabel;
    lbStimulantsRoute: TLabel;
    lbHallucinRoute: TLabel;
    lbOtherRoute: TLabel;
    lbHullucin: TLabel;
    lbNarcoticsFreq: TLabel;
    lbStimulantsFreq: TLabel;
    lbHallucinFreq: TLabel;
    lbOtherFreq: TLabel;
    edNarcoticsFreq: TEdit;
    edStimulantsFreq: TEdit;
    edHallucinFreq: TEdit;
    edOtherFreq: TEdit;
    Label1: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox17: TCheckBox;
    Edit12: TEdit;
    Label2: TLabel;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    Edit13: TEdit;
    lbLifeOther: TLabel;
    meLifeOther: TCaptionMemo;
    Panel1: TPanel;
    spnLengthMilitary: TSpinEdit;
    lbLengthMilitaryYrs: TLabel;
    Panel2: TPanel;
    lbEducationYrs: TLabel;
    spnEducation: TSpinEdit;
    pnlTobaccoQuit: TPanel;
    lbQuitTobacco: TLabel;
    lbQuitDateTobacco: TLabel;
    edQuitCommentsTobacco: TEdit;
    dtQuitTobacco: TORDateBox;
    Panel3: TPanel;
    ckMaster: TCheckBox;
    pnlAlcoholQuit: TPanel;
    lbAlcoholQuit: TLabel;
    lbAlcoholQuitDate: TLabel;
    edAlcoholQuitComments: TEdit;
    dtAlcoholQuit: TORDateBox;
    pnlDrugsQuit: TPanel;
    lbDrugsQuit: TLabel;
    lbDrugsQuitDate: TLabel;
    edDrugsQuitComments: TEdit;
    dtDrugsQuit: TORDateBox;
    Panel4: TPanel;
    lbAlcohol: TLabel;
    ckAlcoholYes: TCheckBox;
    ckAlcoholNo: TCheckBox;
    Panel5: TPanel;
    lbDrugs: TLabel;
    ckDrugsYes: TCheckBox;
    ckDrugsNo: TCheckBox;
    Panel6: TPanel;
    lbCigarDay: TLabel;
    spnCigarDay: TSpinEdit;
    Panel7: TPanel;
    spnCigDay: TSpinEdit;
    lbCigDay: TLabel;
    spnExercise: TSpinEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpinCheck(Sender: TObject);
    procedure CheckClick1(Sender: TObject);
    procedure CheckClick2(Sender: TObject);
    procedure MasterClick(Sender: TObject);
    procedure SecondClick(Sender: TObject);
    procedure SmokeClick(Sender: TObject);
    procedure CigDay(Sender: TObject);
    procedure CigarDay(Sender: TObject);
    procedure PipeDay(Sender: TObject);
    procedure ChewClick(Sender: TObject);
    procedure AlcoholClick(Sender: TObject);
    procedure DrugsClick(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
  end;

var
  dlgSocial: TdlgSocial;

implementation

{$R *.dfm}

procedure TdlgSocial.FormCreate(Sender: TObject);
var
  I: Integer;

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
  end;

begin
  // Lifestyle
  for I := 0 to pgBody.Pages[0].ControlCount - 1 do
  begin
    if pgBody.Pages[0].Controls[I] is TCheckBox then
      SetSay(TWinControl(pgBody.Pages[0].Controls[I]));
    if pgBody.Pages[0].Controls[I] is TEdit then
      SetSay(TWinControl(pgBody.Pages[0].Controls[I]));
  end;
  SayOnFocus(       spnExercise, 'Number of times per week');
  SayOnFocus( spnLengthMilitary, 'Length of time in the military in years');
  SayOnFocus(      spnEducation, 'Highest level of education in years');

  // Relationship and Sexual History
  SayOnFocus(    ckSexTraumaYes, 'Military Sexual Trauma');
  SayOnFocus(     ckSexTraumaNo, 'Military Sexual Trauma');
  SayOnFocus(ckSexTraumaUnknown, 'Military Sexual Trauma');
  SayOnFocus(     ckViolenceYes, 'Interpersonal violence?');
  SayOnFocus(      ckViolenceNo, 'Interpersonal violence?');
  SayOnFocus( ckViolenceUnknown, 'Interpersonal violence?');
  SayOnFocus(   ckSexPartnerYes, 'Have you had more than one sexual partner in the last year?');
  SayOnFocus(    ckSexPartnerNo, 'Have you had more than one sexual partner in the last year?');
  SayOnFocus(  ckSexConcernsYes, 'Do you have any sexual concerns you would like to address with your provider?');
  SayOnFocus(   ckSexConcernsNo, 'Do you have any sexual concerns you would like to address with your provider?');

  // Tobacco
  SayOnFocus( ckSmokeYes, 'Smoke');
  SayOnFocus(  ckSmokeNo, 'Smoke');
  SayOnFocus(      gbCig, 'Cigarettes Pack Year History');
  SayOnFocus(  spnCigYrs, 'Number of Cigarettes per year');
  SayOnFocus(    gbCigar, 'Cigars Pack Year History');
  SayOnFocus(spnCigarYrs, 'Number of Cigars per year');
  SayOnFocus(     gbPipe, 'Pipe Bowls Year History');
  SayOnFocus( spnPipeYrs, 'Number of Bowls per year');
  SayOnFocus(  ckChewYes, 'Chew');
  SayOnFocus(   ckChewNo, 'Chew');
  SayOnFocus(ckSecondYes, 'Environmental and or second hand exposure?');
  SayOnFocus( ckSecondNo, 'Environmental and or second hand exposure?');

  // Alcohol and Drugs
  SayOnFocus(     ckAlcoholYes, 'Does patient currently drink alcohol?');
  SayOnFocus(      ckAlcoholNo, 'Does patient currently drink alcohol?');
  SayOnFocus(           cbWine, 'Wine');
  SayOnFocus(           cbBeer, 'Beer');
  SayOnFocus(         cbSpirit, 'Spirits');
  SayOnFocus(       ckDrugsYes, 'Does patient currently use recreational or non prescribed substances?');
  SayOnFocus(        ckDrugsNo, 'Does patient currently use recreational or non prescribed substances?');
  SayOnFocus( cbNarcoticsRoute, 'Narcotics');
  SayOnFocus(cbStimulantsRoute, 'Stimulants');
  SayOnFocus(  cbHallucinRoute, 'Hallucinogens');
  SayOnFocus(     cbOtherRoute, 'Other');
  SayOnFocus(  edNarcoticsFreq, 'Narcotics');
  SayOnFocus( edStimulantsFreq, 'Stimulants');
  SayOnFocus(   edHallucinFreq, 'Hallucinogens');
  SayOnFocus(      edOtherFreq, 'Other');
end;

procedure TdlgSocial.SpinCheck(Sender: TObject);
begin
  if (Sender as TSpinEdit).Value < 0 then
    TSpinEdit(Sender).Value := 0;
end;

procedure TdlgSocial.CheckClick1(Sender: TObject);
var
  I: Integer;
  ick,ck: TCheckBox;
  ce: TEdit;
  se: TSpinEdit;
begin
  ick := TCheckBox(Sender);

  for I := 0 to pgBody.Pages[0].ControlCount - 1 do
  begin
    if pgBody.Pages[0].Controls[I] is TCheckBox then
      if pgBody.Pages[0].Controls[I].Tag = ick.Tag then
      begin
        ck := TCheckBox(pgBody.Pages[0].Controls[I]);
        if ck <> ick then
        begin
          ck.OnClick := nil;
          ck.Checked := False;
          ck.OnClick := CheckClick1;
        end;
      end;
    if pgBody.Pages[0].Controls[I] is TEdit then
      if pgBody.Pages[0].Controls[I].Tag = ick.Tag then
      begin
        ce := TEdit(pgBody.Pages[0].Controls[I]);
        if ick.Caption = 'No' then
        begin
          ce.Clear;
          ce.Enabled := False;
        end else
          ce.Enabled := True;
      end;
    if pgBody.Pages[0].Controls[I] is TSpinEdit then
      if pgBody.Pages[0].Controls[I].Tag = ick.Tag then
      begin
        se := TSpinEdit(pgBody.Pages[0].Controls[I]);
        if ick.Caption = 'No' then
        begin
          se.Value := 0;
          se.Enabled := False;
        end else
          se.Enabled := True;
      end;
  end;
end;

procedure TdlgSocial.CheckClick2(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if (ck = ckSexTraumaYes) or (ck = ckSexTraumaUnknown) and
     (ck.Checked) then
  begin
    edSexTrauma.Enabled := True;
    ckSexTraumaNo.OnClick := nil;
    ckSexTraumaNo.Checked := False;
    ckSexTraumaNo.OnClick := CheckClick2;

    if ck = ckSexTraumaYes then
    begin
      ckSexTraumaUnknown.OnClick := nil;
      ckSexTraumaUnknown.Checked := False;
      ckSexTraumaUnknown.OnClick := CheckClick2;
    end else
    begin
      ckSexTraumaYes.OnClick := nil;
      ckSexTraumaYes.Checked := False;
      ckSexTraumaYes.OnClick := CheckClick2;
    end;
  end else if ((ck = ckSexTraumaNo) and ck.Checked) then
  begin
    edSexTrauma.Clear;
    edSexTrauma.Enabled := False;

    ckSexTraumaYes.OnClick := nil;
    ckSexTraumaYes.Checked := False;
    ckSexTraumaYes.OnClick := CheckClick2;
    ckSexTraumaUnknown.OnClick := nil;
    ckSexTraumaUnknown.Checked := False;
    ckSexTraumaUnknown.OnClick := CheckClick2;
  end;

  if (ck = ckViolenceYes) or (ck = ckViolenceUnknown) and
     (ck.Checked) then
  begin
    edViolence.Enabled := True;
    ckViolenceNo.OnClick := nil;
    ckViolenceNo.Checked := False;
    ckViolenceNo.OnClick := CheckClick2;

    if ck = ckViolenceYes then
    begin
      ckViolenceUnknown.OnClick := nil;
      ckViolenceUnknown.Checked := False;
      ckViolenceUnknown.OnClick := CheckClick2;
    end else
    begin
      ckViolenceYes.OnClick := nil;
      ckViolenceYes.Checked := False;
      ckViolenceYes.OnClick := CheckClick2;
    end;
  end else if ((ck = ckViolenceNo) and ck.Checked) then
  begin
    edViolence.Clear;
    edViolence.Enabled := False;

    ckViolenceYes.OnClick := nil;
    ckViolenceYes.Checked := False;
    ckViolenceYes.OnClick := CheckClick2;
    ckViolenceUnknown.OnClick := nil;
    ckViolenceUnknown.Checked := False;
    ckViolenceUnknown.OnClick := CheckClick2;
  end;

  if (ck = ckSexPartnerYes) or (ck = ckSexPartnerNo) and
     (ck.Checked) then
  begin
    edSexPartner.Enabled := True;

    if ck = ckSexPartnerYes then
    begin
      ckSexPartnerNo.OnClick := nil;
      ckSexPartnerNo.Checked := False;
      ckSexPartnerNo.OnClick := CheckClick2;
    end else
    begin
      ckSexPartnerYes.OnClick := nil;
      ckSexPartnerYes.Checked := False;
      ckSexPartnerYes.OnClick := CheckClick2;
    end;
  end else if (ck = ckSexPartnerYes) or (ck = ckSexPartnerNo) and (not ck.Checked) then
    if ((ck <> ckSexPartnerYes) and (not ckSexPartnerYes.Checked)) or
       ((ck <> ckSexPartnerNo)  and (not ckSexPartnerNo.Checked)) then
    begin
      edSexPartner.Clear;
      edSexPartner.Enabled := False;
    end;

  if (ck = ckSexConcernsYes) or (ck = ckSexConcernsNo) and
     (ck.Checked) then
  begin
    edSexConcerns.Enabled := True;

    if ck = ckSexConcernsYes then
    begin
      ckSexConcernsNo.OnClick := nil;
      ckSexConcernsNo.Checked := False;
      ckSexConcernsNo.OnClick := CheckClick2;
    end else
    begin
      ckSexConcernsYes.OnClick := nil;
      ckSexConcernsYes.Checked := False;
      ckSexConcernsYes.OnClick := CheckClick2;
    end;
  end else if (ck = ckSexConcernsYes) or (ck = ckSexConcernsNo) and (not ck.Checked) then
    if ((ck <> ckSexConcernsYes) and (not ckSexConcernsYes.Checked)) or
       ((ck <> ckSexConcernsNo)  and (not ckSexConcernsNo.Checked)) then
    begin
      edSexConcerns.Clear;
      edSexConcerns.Enabled := False;
    end;
end;

procedure TdlgSocial.MasterClick(Sender: TObject);
begin
  if ckMaster.Checked then
    pnlMaster.Visible := False
  else
    pnlMaster.Visible := True;
end;

procedure TdlgSocial.SecondClick(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if ((ck = ckSecondYes) and ck.Checked) then
  begin
    ckSecondNo.OnClick := nil;
    ckSecondNo.Checked := False;
    ckSecondno.OnClick := SecondClick;
  end else if ((ck = ckSecondNo) and ck.Checked) then
  begin
    ckSecondYes.OnClick := nil;
    ckSecondYes.Checked := False;
    ckSecondYes.OnClick := SecondClick;
  end;
end;

procedure TdlgSocial.SmokeClick(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if ((ck = ckSmokeYes) and ck.Checked) then
  begin
    pnlSmoke.Visible := True;
    ckSmokeNo.OnClick := nil;
    ckSmokeNo.Checked := False;
    ckSmokeNo.OnClick := SmokeClick;
  end else if ((ck = ckSmokeNo) and ck.Checked) then
  begin
    pnlSmoke.Visible := False;
    ckSmokeYes.OnClick := nil;
    ckSmokeYes.Checked := False;
    ckSmokeYes.OnClick := SmokeClick;
  end else
    pnlSmoke.Visible := False;
end;

procedure TdlgSocial.CigDay(Sender: TObject);
begin
  if spnCigDay.Value < 0 then
  begin
    spnCigDay.Value := 0;
    Exit;
  end;

  spnCigYrs.Value := spnCigDay.Value * 365;
end;

procedure TdlgSocial.CigarDay(Sender: TObject);
begin
  if spnCigarDay.Value < 0 then
  begin
    spnCigarDay.Value := 0;
    Exit;
  end;

  spnCigarYrs.Value := spnCigarDay.Value * 365;
end;

procedure TdlgSocial.PipeDay(Sender: TObject);
begin
  if spnPipeDay.Value < 0 then
  begin
    spnPipeDay.Value := 0;
    Exit;
  end;

  spnPipeYrs.Value := spnPipeDay.Value * 365;
end;

procedure TdlgSocial.ChewClick(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if ((ck = ckChewYes) and ck.Checked) then
  begin
    pnlChew.Visible := True;
    ckChewNo.OnClick := nil;
    ckChewNo.Checked := False;
    ckChewNo.OnClick := ChewClick;
  end else if ((ck = ckChewNo) and ck.Checked) then
  begin
    pnlChew.Visible := False;
    ckChewYes.OnClick := nil;
    ckChewYes.Checked := False;
    ckChewYes.OnClick := ChewClick;
  end else
    pnlChew.Visible := False;
end;

procedure TdlgSocial.AlcoholClick(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if ((ck = ckAlcoholYes) and ck.Checked) then
  begin
    pnlAlcoholQuit.Visible := False;
    pnlAlcohol.Visible := True;
    ckAlcoholNo.OnClick := nil;
    ckAlcoholNo.Checked := False;
    ckAlcoholNo.OnClick := AlcoholClick;
  end else if ((ck = ckAlcoholNo) and ck.Checked) then
  begin
    pnlAlcohol.Visible := False;
    pnlAlcoholQuit.Visible := True;
    ckAlcoholYes.OnClick := nil;
    ckAlcoholYes.Checked := False;
    ckAlcoholYes.OnClick := AlcoholClick;
  end else
  begin
    pnlAlcohol.Visible := False;
    pnlAlcoholQuit.Visible := False;
  end;
end;

procedure TdlgSocial.DrugsClick(Sender: TObject);
var
  ck: TCheckBox;
begin
  ck := TCheckBox(Sender);

  if ((ck = ckDrugsYes) and ck.Checked) then
  begin
    pnlDrugsQuit.Visible := False;
    pnlDrugs.Visible := True;
    ckDrugsNo.OnClick := nil;
    ckDrugsNo.Checked := False;
    ckDrugsNo.OnClick := DrugsClick;
  end else if ((ck = ckDrugsNo) and ck.Checked) then
  begin
    pnlDrugs.Visible := False;
    pnlDrugsQuit.Visible := True;
    ckDrugsYes.OnClick := nil;
    ckDrugsYes.Checked := False;
    ckDrugsYes.OnClick := DrugsClick;
  end else
  begin
    pnlDrugs.Visible := False;
    pnlDrugsQuit.Visible := False;
  end;
end;

procedure TdlgSocial.bbtnOKClick(Sender: TObject);
var
  I: Integer;
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
  end;

  function GetNarrative(iTag: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to pgBody.Pages[0].ControlCount - 1 do
      if pgBody.Pages[0].Controls[I].Tag = iTag then
      begin
        if pgBody.Pages[0].Controls[I] is TEdit then
        begin
          Result := TEdit(pgBody.Pages[0].Controls[I]).Text;
          Break;
        end;
      end;
  end;

begin
  // Lifestyle
  TmpStrList.Add('  Lifestyle:');
  for I := 0 to pgBody.Pages[0].ControlCount - 1 do
    if pgBody.Pages[0].Controls[I] is TCheckbox then
    begin
      ck := TCheckBox(pgBody.Pages[0].Controls[I]);

      if ck.Checked then
      begin
        TmpStrList.Add('   ' + GetQuestion(ck.Tag) + ': ' + ck.Caption);
        if ck.Caption <> 'No' then
        begin
          if ck.Tag = 7 then
          begin
            if spnExercise.Value > 0 then
              TmpStrList.Add('    Number of times per week: ' + spnExercise.Text);
            if Trim(edExercise.Text) <> '' then
              TmpStrList.Add('    Comments: ' + edExercise.Text);
          end else
          begin
            tmp := GetNarrative(ck.Tag);
            if tmp <> '' then
              TmpStrList.Add('    Comments: ' + tmp);
          end;
        end;
      end;
    end;
  if meLifeOther.Lines.Count > 0 then
  begin
    TmpStrList.Add('   Other:');
    for I := 0 to meLifeOther.Lines.Count - 1 do
      TmpStrList.Add('    ' + meLifeOther.Lines[I]);
  end;
  if Trim(edBranch.Text) <> '' then
    TmpStrList.Add('   Branch of Service: ' + edBranch.Text);
  if spnLengthMilitary.Value > 0 then
  begin
    TmpStrList.Add('   Length of time in the military: ' + spnLengthMilitary.Text);
    if Trim(edLengthMilitaryComment.Text) <> '' then
      TmpStrList.Add('    Comment: ' + edLengthMilitaryComment.Text);
  end;
  if spnEducation.Value > 0 then
  begin
    TmpStrList.Add('   Highest level of education: ' + spnEducation.Text);
    if Trim(edEducationComment.Text) <> '' then
      TmpStrList.Add('    Comment: ' + edEducationComment.Text);
  end;

  // Relationship and Sexual History
  TmpStrList.Add('  Relationship and Sexual History:');
  if Trim(edBirthControl.Text) <> '' then
    TmpStrList.Add('   Most recent method of birth control: ' + edBirthControl.Text);
  if ckSexTraumaYes.Checked or ckSexTraumaNo.Checked or ckSexTraumaUnknown.Checked then
  begin
    if ckSexTraumaYes.Checked then
      TmpStrList.Add('   Military Sexual Trauma: Yes')
    else if ckSexTraumaUnknown.Checked then
      TmpStrList.Add('   Military Sexual Trauma: Unknown')
    else
      TmpStrList.Add('   Military Sexual Trauma: No');
    if ((not ckSexTraumaNo.Checked) and (Trim(edSexTrauma.Text) <> '')) then
      TmpStrList.Add('    Comments: ' + edSexTrauma.Text);
  end;
  if ckViolenceYes.Checked or ckViolenceNo.Checked or ckViolenceUnknown.Checked then
  begin
    if ckViolenceYes.Checked then
      TmpStrList.Add('   Interpersonal violence: Yes')
    else if ckViolenceUnknown.Checked then
      TmpStrList.Add('   Interpersonal violence: Unknown')
    else
      TmpStrList.Add('   Interpersonal violence: No');
    if ((not ckViolenceNo.Checked) and (Trim(edViolence.Text) <> '')) then
      TmpStrList.Add('    Comments: ' + edViolence.Text);
  end;
  if ckSexPartnerYes.Checked or ckSexPartnerNo.Checked then
  begin
    if ckSexPartnerYes.Checked then
      TmpStrList.Add('   Have you had more than one sexual partner in the last year: Yes')
    else
      TmpStrList.Add('   Have you had more than one sexual partner in the last year: No');
    if Trim(edSexPartner.Text) <> '' then
      TmpStrList.Add('    Comments: ' + edSexPartner.Text);
  end;
  if ckSexConcernsYes.Checked or ckSexConcernsNo.Checked then
  begin
    if ckSexConcernsYes.Checked then
      TmpStrList.Add('   Do you have any sexual concerns you would like to address with your provider: Yes')
    else
      TmpStrList.Add('   Do you have any sexual concerns you would like to address with your provider: No');
    if Trim(edSexConcerns.Text) <> '' then
      TmpStrList.Add('    Comments: ' + edSexConcerns.Text);
  end;

  // Tobacco
  TmpStrList.Add('  Tobacco:');
  if ckMaster.Checked then
    TmpStrList.Add('   ' + ck.Caption)
  else
  begin
    if ckSecondYes.Checked or ckSecondNo.Checked then
    begin
      if ckSecondYes.Checked then
        TmpStrList.Add('   Environmental and or second hand exposure: Yes')
      else
        TmpStrList.Add('   Environmental and or second hand exposure: No');
    end;
    if spnSecondExpose.Value > 0 then
      TmpStrList.Add('   How many hours per day exposed: ' + spnSecondExpose.Text);
    if ckSmokeYes.Checked or ckSmokeNo.Checked then
    begin
      if ckSmokeYes.Checked then
      begin
        TmpStrList.Add('   Smokes: Yes');
        if (spnCigDay.Value > 0) or (spnCigYrs.Value > 0) then
        begin
          TmpStrList.Add('    Cigarettes Pack Year History:');
          if spnCigDay.Value > 0 then
            TmpStrList.Add('     Cigarettes per day: ' + spnCigDay.Text);
          if spnCigYrs.Value > 0 then
            TmpStrList.Add('     Cigarettes per year: ' + spnCigYrs.Text);
        end;
        if (spnCigarDay.Value > 0) or (spnCigarYrs.Value > 0) then
        begin
          TmpStrList.Add('    Cigar Pack Year History:');
          if spnCigarDay.Value > 0 then
            TmpStrList.Add('     Cigars per day: ' + spnCigarDay.Text);
          if spnCigarYrs.Value > 0 then
            TmpStrList.Add('     Cigars per year: ' + spnCigarYrs.Text);
        end;
        if (spnPipeDay.Value > 0) or (spnPipeYrs.Value > 0) then
        begin
          TmpStrList.Add('    Pipe Bowls Year History:');
          if spnPipeDay.Value > 0 then
            TmpStrList.Add('     Bowls per day: ' + spnPipeDay.Text);
          if spnPipeYrs.Value > 0 then
            TmpStrList.Add('     Bowls per year: ' + spnPipeYrs.Text);
        end;
      end else
        TmpStrList.Add('   Smokes: No');
    end;
    if ckChewYes.Checked or ckChewNo.Checked then
    begin
      if ckChewYes.Checked then
      begin
        TmpStrList.Add('   Chews: Yes');
        if spnChewDay.Value > 0 then
          TmpStrList.Add('    How much each day: ' + spnChewDay.Text);
        if spnChewYears.Value > 0 then
          TmpStrList.Add('    Number of Years: ' + spnChewYears.Text);
        if Trim(edChewEpisode.Text) <> '' then
          TmpStrList.Add('    How long each episode: ' + edChewEpisode.Text);
      end else
        TmpStrList.Add('   Chews: No');
    end;
  end;
  if dtQuitTobacco.IsValid then
  begin
    TmpStrList.Add('   Date Quit: ' + dtQuitTobacco.Text);
    if Trim(edQuitCommentsTobacco.Text) <> '' then
      TmpStrList.Add('    Comments: ' + edQuitCommentsTobacco.Text);
  end;

  // Alcohol and Drugs
  TmpStrList.Add('  Alcohol and Drugs:');
  if ckAlcoholYes.Checked or ckAlcoholNo.Checked then
  begin
    if ckAlcoholYes.Checked then
    begin
      TmpStrList.Add('   Does patient currently drink alcohol: Yes');
      if spnWine.Value > 0 then
      begin
        TmpStrList.Add('    How much wine (6 oz): ' + spnWine.Text);
        if cbWine.ItemIndex <> -1 then
          TmpStrList.Add('     How often: ' + cbWine.Text);
      end;
      if spnBeer.Value > 0 then
      begin
        TmpStrList.Add('    How many beers (12 oz): ' + spnBeer.Text);
        if cbBeer.ItemIndex <> -1 then
          TmpStrList.Add('     How often: ' + cbBeer.Text);
      end;
      if spnSpirit.Value > 0 then
      begin
        TmpStrList.Add('    How many spirits (1 oz): ' + spnSpirit.Text);
        if cbSpirit.ItemIndex <> -1 then
          TmpStrList.Add('     How often: ' + cbSpirit.Text);
      end;
    end else
    begin
      TmpStrList.Add('   Does patient currently drink alcohol: No');
      if dtAlcoholQuit.IsValid then
      begin
        TmpStrList.Add('    Date Quit: ' + dtAlcoholQuit.Text);
        if Trim(edAlcoholQuitComments.Text) <> '' then
          TmpStrList.Add('     Comments: ' + edAlcoholQuitComments.Text);
      end;
    end;
  end;
  if ckDrugsYes.Checked or ckDrugsNo.Checked then
  begin
    if ckDrugsYes.Checked then
    begin
      TmpStrList.Add('   Does patient currently use recreational or non-prescribed substances: Yes');
      if cbNarcotics.ItemIndex <> -1 then
      begin
        TmpStrList.Add('    Narcotics: ' + cbNarcotics.Text);
        if cbNarcoticsRoute.ItemIndex <> -1 then
          TmpStrList.Add('     Route: ' + cbNarcoticsRoute.Text);
        if Trim(edNarcoticsFreq.Text) <> '' then
          TmpStrList.Add('     Frequency: ' + edNarcoticsFreq.Text);
      end;
      if cbStimulants.ItemIndex <> -1 then
      begin
        TmpStrList.Add('    Stimulants: ' + cbStimulants.Text);
        if cbStimulantsRoute.ItemIndex <> -1 then
          TmpStrList.Add('     Route: ' + cbStimulantsRoute.Text);
        if Trim(edStimulantsFreq.Text) <> '' then
          TmpStrList.Add('     Frequency: ' + edStimulantsFreq.Text);
      end;
      if cbHallucin.ItemIndex <> -1 then
      begin
        TmpStrList.Add('    Hallucinogens: ' + cbHallucin.Text);
        if cbHallucinRoute.ItemIndex <> -1 then
          TmpStrList.Add('     Route: ' + cbHallucinRoute.Text);
        if Trim(edHallucinFreq.Text) <> '' then
          TmpStrList.Add('     Frequency: ' + edHallucinFreq.Text);
      end;
      if cbOther.ItemIndex <> -1 then
      begin
        TmpStrList.Add('    Other: ' + cbOther.Text);
        if cbOtherRoute.ItemIndex <> -1 then
          TmpStrList.Add('     Route: ' + cbOtherRoute.Text);
        if Trim(edOtherFreq.Text) <> '' then
          TmpStrList.Add('     Frequency: ' + edOtherFreq.Text);
      end;
    end else
    begin
      TmpStrList.Add('   Does patient currently use recreational or non-prescribed substances: No');
      if dtDrugsQuit.IsValid then
      begin
        TmpStrList.Add('    Date Quit: ' + dtDrugsQuit.Text);
        if Trim(edDrugsQuitComments.Text) <> '' then
          TmpStrList.Add('     Comments: ' + edDrugsQuitComments.Text);
      end;
    end;
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Social History: ');
end;

end.
