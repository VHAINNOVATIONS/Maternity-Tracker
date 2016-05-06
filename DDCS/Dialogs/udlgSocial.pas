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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, uDialog, uExtndComBroker,
  Vcl.Samples.Spin, VA508AccessibilityManager;

type
  TdlgSocial = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet1: TTabSheet;
    gb1: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    cb3: TCheckBox;
    cb4: TCheckBox;
    cb5: TCheckBox;
    cb6: TCheckBox;
    cb9: TCheckBox;
    cb10: TCheckBox;
    le2: TLabeledEdit;
    le3: TLabeledEdit;
    Label31: TLabel;
    Label32: TLabel;
    cb11: TCheckBox;
    cb12: TCheckBox;
    cb13: TCheckBox;
    cb14: TCheckBox;
    Label33: TLabel;
    cb15: TCheckBox;
    cb16: TCheckBox;
    Label34: TLabel;
    cb17: TCheckBox;
    cb18: TCheckBox;
    leOther: TLabeledEdit;
    le6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    TabSheet4: TTabSheet;
    gb4: TGroupBox;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    cbalcoholyes: TCheckBox;
    cbalcoholno: TCheckBox;
    ledalcohol: TLabeledEdit;
    gbalcohol: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ledwine: TLabeledEdit;
    cobwine: TComboBox;
    ledbeer: TLabeledEdit;
    cobbeer: TComboBox;
    ledspirits: TLabeledEdit;
    cobspirits: TComboBox;
    ledquitalcohol: TLabeledEdit;
    leddatealcohol: TLabeledEdit;
    gb5: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    cbdrugsyes: TCheckBox;
    cbdrugsno: TCheckBox;
    ledquitdrugs: TLabeledEdit;
    leddatedrugs: TLabeledEdit;
    leddrugs: TLabeledEdit;
    gbdrugs: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    cobStim: TComboBox;
    cobOther: TComboBox;
    cobRnarc: TComboBox;
    cobRStim: TComboBox;
    cobRother: TComboBox;
    cobHall: TComboBox;
    cobRHall: TComboBox;
    cobnarc: TComboBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    gb3: TGroupBox;
    sbtnGetDate1: TSpeedButton;
    Label10: TLabel;
    label11: TLabel;
    Label12: TLabel;
    cbnosmoke: TCheckBox;
    cbchew: TCheckBox;
    gbcigarette: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    lblcigarette: TLabel;
    eddays: TEdit;
    edyears: TEdit;
    cbsmoke: TCheckBox;
    ledtobacco: TLabeledEdit;
    gbcigar: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    lblcigar: TLabel;
    eddays1: TEdit;
    edyears1: TEdit;
    gbchew: TGroupBox;
    ledchewday: TLabeledEdit;
    ledchewyears: TLabeledEdit;
    ledepisode: TLabeledEdit;
    gbpipe: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    lblpipe: TLabel;
    eddays2: TEdit;
    edyears2: TEdit;
    cbsecond: TCheckBox;
    cbno1: TCheckBox;
    cbno2: TCheckBox;
    cbno3: TCheckBox;
    ledquit: TLabeledEdit;
    leddate: TLabeledEdit;
    ledsecond: TLabeledEdit;
    gbRelation: TGroupBox;
    Label25: TLabel;
    Label24: TLabel;
    le1: TLabeledEdit;
    cb2: TCheckBox;
    cb1: TCheckBox;
    edtBirthControl: TLabeledEdit;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    LabeledEdit11: TLabeledEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label35: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Label39: TLabel;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    LabeledEdit17: TLabeledEdit;
    Label40: TLabel;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    LabeledEdit16: TLabeledEdit;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    amgrMain: TVA508AccessibilityManager;
    procedure FormCreate(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure sbtnGetDate1Click(Sender: TObject);
    procedure cbalcoholyesClick(Sender: TObject);
    procedure cbalcoholnoClick(Sender: TObject);
    procedure cbdrugsyesClick(Sender: TObject);
    procedure cbdrugsnoClick(Sender: TObject);
    procedure cbnosmokeClick(Sender: TObject);
    procedure cbsmokeClick(Sender: TObject);
    procedure cbno1Click(Sender: TObject);
    procedure cbchewClick(Sender: TObject);
    procedure cbno2Click(Sender: TObject);
    procedure cbsecondClick(Sender: TObject);
    procedure cbno3Click(Sender: TObject);
    procedure eddaysChange(Sender: TObject);
    procedure eddays1Change(Sender: TObject);
    procedure eddays2Change(Sender: TObject);
    procedure edyearsChange(Sender: TObject);
    procedure cb1Click(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
  private
    procedure tobacco(Sender: TObject);
    procedure Calculate(ed1:TEdit; ed2:TEdit; lbl:TLabel);
    Procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public
    CurrentDate: string;
  end;

var
  dlgSocial: TdlgSocial;

implementation

uses
   udlgDATE;

{$R *.dfm}

procedure TdlgSocial.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TdlgSocial.sbtnGetDate1Click(Sender: TObject);
var
  TmpForm : TdlgDate;
begin
  try
    TmpForm := TdlgDate.Create( Nil );
    TmpForm.ShowModal;
    if TmpForm.ModalResult = mrOK then
     begin
      if(TmpForm.calMonth.Date) >  Now then
        showmessage('No future dates')
      else
      case (Sender as TSpeedButton).Tag of
        1: leddate.Text        := DateToStr(TmpForm.calMonth.Date);
        2: leddatealcohol.Text := DateToStr(TmpForm.calMonth.Date);
        3: leddatedrugs.Text   := DateToStr(TmpForm.calMonth.Date);
      end;
    end;
  finally
    TmpForm.Free;
  end;
end;

procedure TdlgSocial.SpinEditChange(Sender: TObject);
begin
  if TSpinEdit(Sender).Value < 0 then
    TSpinEdit(Sender).Value := 0;
end;

procedure TdlgSocial.bbtnOKClick(Sender: TObject);
var
  I: integer;
  TmpStr:  String;
  CompChecked: Integer;
begin
// START lifestyle -------------------------------------------------------------
  TmpStrList.Add('Lifestyle:');
  if cb3.Checked then
  begin
    TmpStrList.Add('  Health hazards at home/work? Yes');
    if le2.Text <> '' then
    TmpStrList.Add('    Comments: ' + le2.Text);
  end
  else if cb4.Checked then
  begin
    TmpStrList.Add('  Health hazards at home/work? No');
    if le2.Text <> '' then
    TmpStrList.Add('    Comments: ' + le2.Text);
  end;
  if cb5.Checked then
  begin
    TmpStrList.Add('  Seat belt use? Yes');
    if LabeledEdit7.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit7.Text);
  end
  else if cb6.Checked then
  begin
    TmpStrList.Add('  Seat belt use? No');
    if LabeledEdit7.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit7.Text);
  end;
 if cb9.Checked then
  begin
    TmpStrList.Add('  Dietary restrictions or limitations? Yes');
    if le3.Text <> '' then
    TmpStrList.Add('    Comments: ' + le3.Text);
  end
  else if cb10.Checked then
  begin
    TmpStrList.Add('  Dietary restrictions or limitations? No');
    if le3.Text <> '' then
    TmpStrList.Add('    Comments: ' + le3.Text);
  end;
  if cb11.Checked then
  begin
    TmpStrList.Add('  Folic acid intake? Yes');
    if LabeledEdit8.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit8.Text);
  end
  else if cb12.Checked then
  begin
    TmpStrList.Add('  Folic acid intake? No');
    if LabeledEdit8.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit8.Text);
  end;
  if cb13.Checked then
  begin
    TmpStrList.Add('  Calcium intake? Yes');
    if LabeledEdit9.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit9.Text);
  end
  else if cb14.Checked then
  begin
    TmpStrList.Add('  Calcium intake? No');
    if LabeledEdit9.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit9.Text);
  end;
  if cb15.Checked then
  begin
    TmpStrList.Add('  Regular diet? Yes');
    if le6.Text <> '' then
    TmpStrList.Add('    Describe/Comments: ' + le6.Text);
  end
  else if cb16.Checked then
  begin
    TmpStrList.Add('  Regular diet? No');
    if le6.Text <> '' then
    TmpStrList.Add('    Describe/Comments: ' + le6.Text);
  end;
  if cb17.Checked then
  begin
    TmpStrList.Add('  Caffeine intake? Yes');
    if LabeledEdit10.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit10.Text);
  end
  else if cb18.Checked then
  begin
    TmpStrList.Add('  Caffeine intake? No');
    if LabeledEdit10.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit10.Text);
  end;
  if CheckBox15.Checked then
  begin
    TmpStrList.Add('  Currently employed? Yes');
    if LabeledEdit2.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit2.Text);
  end
  else if CheckBox16.Checked then
  begin
    TmpStrList.Add('  Currently employed? No');
    if LabeledEdit2.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit2.Text);
  end;
  if CheckBox6.Checked then
  begin
    TmpStrList.Add('  PTSD? Yes');
    if LabeledEdit1.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit1.Text);
  end
  else if CheckBox5.Checked then
  begin
    TmpStrList.Add('  PTSD? No');
    if LabeledEdit1.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit1.Text);
  end;
  if CheckBox12.Checked then
  begin
    TmpStrList.Add('  Combat? Yes');
    if LabeledEdit12.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit12.Text);
  end
  else if CheckBox11.Checked then
  begin
    TmpStrList.Add('  Combat? No');
    if LabeledEdit12.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit12.Text);
  end;
  if CheckBox14.Checked then
  begin
    TmpStrList.Add('  Any known traumatic brain injuries (TBI)? Yes');
    if LabeledEdit13.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit13.Text);
  end
  else if CheckBox13.Checked then
  begin
    TmpStrList.Add('  Any known traumatic brain injuries (TBI)? No');
    if LabeledEdit13.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit13.Text);
  end;
  if Edit1.Text <> '' then
  begin
    TmpStrList.Add('  Branch of Service?');
    TmpStrList.Add('    ' + Edit1.Text);
  end;
  if SpinEdit2.Value > 0 then
  begin
    TmpStrList.Add('  Length of time in the military? ' + SpinEdit2.Text + 'yrs');
    if LabeledEdit16.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit16.Text);
  end;
  if Edit2.Text <> '' then
  begin
    TmpStrList.Add('  Current Occupation?');
    TmpStrList.Add('    ' + Edit2.Text);
  end;
  if SpinEdit1.Value > 0 then
  begin
    TmpStrList.Add('  Highest level of education? ' + SpinEdit1.Text + 'yrs');
    if LabeledEdit15.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit15.Text);
  end;


  if leOther.Text <> '' then
    TmpStrList.Add('  Other: ' + leOther.Text);
// END lifestyle ---------------------------------------------------------------

// START Relationship & Sexual History ----------------------------------------
  TmpStrList.Add('Relationship/Sexual History:');

  if edtBirthControl.Text <> '' then
  begin
    TmpStrList.Add('  Most recent method of birth control?');
    TmpStrList.Add('    ' + edtBirthControl.Text);
  end;
  if CheckBox7.Checked then
  begin
    TmpStrList.Add('  Military sexual trauma? Yes');
    if LabeledEdit11.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit11.Text);
  end
  else if CheckBox8.Checked then
  begin
    TmpStrList.Add('  Military sexual trauma? No');
    if LabeledEdit11.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit11.Text);
  end;
  if cb1.Checked then
  begin
    TmpStrList.Add('  Interpersonal violence? Yes');
    if le1.Text <> '' then
    TmpStrList.Add('    Comments: ' + le1.Text);
  end
  else if cb2.Checked then
  begin
    TmpStrList.Add('  Interpersonal violence? No');
    if le1.Text <> '' then
    TmpStrList.Add('    Comments: ' + le1.Text);
  end;
  if CheckBox17.Checked then
  begin
    TmpStrList.Add('  Have you had more than one sexual partner in the last year? Yes');
    if LabeledEdit17.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit17.Text);
  end
  else if CheckBox18.Checked then
  begin
    TmpStrList.Add('  Have you had more than one sexual partner in the last year? No');
    if LabeledEdit17.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit17.Text);
  end;
  if CheckBox19.Checked then
  begin
    TmpStrList.Add('  Do you have any sexual concerns you would like to address with your provider? Yes');
    if LabeledEdit18.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit18.Text);
  end
  else if CheckBox20.Checked then
  begin
    TmpStrList.Add('  Do you have any sexual concerns you would like to address with your provider? No');
    if LabeledEdit18.Text <> '' then
    TmpStrList.Add('    Comments: ' + LabeledEdit18.Text);
  end;
// END Relationship && Sexual History ------------------------------------------

// START Tobacco ---------------------------------------------------------------
  TmpStrList.Add('Tobacco use:');
  if cbnosmoke.Checked then
    TmpStrList.Add('  ' + cbnosmoke.Caption)
  else begin
    if cbno1.Checked then
      TmpStrList.Add('  ' + cbno1.Hint)
    else if cbsmoke.Checked then
    begin
      if (eddays.Text <> '') or (edyears.Text <> '') then
      begin
        TmpStrList.Add('  Smoking: Cigarettes');
        if eddays.Text  <> '' then  TmpStrList.Add('    Pack per Day: ' + eddays.Text);
        if edyears.Text <> '' then  TmpStrList.Add('    Number of Years: ' + edyears.Text);
        if lblcigarette.Visible = True then
          TmpStrList.Add('    ' + lblcigarette.Caption);
      end;
      if (eddays1.Text <> '') or (edyears1.Text <> '') then
      begin
        TmpStrList.Add('  Smoking: Cigar');
        if eddays1.Text  <> '' then  TmpStrList.Add('    Pack per Day: ' + eddays1.Text);
        if edyears1.Text <> '' then  TmpStrList.Add('    Number of Years: ' + edyears1.Text);
        if lblcigar.Visible = True then
          TmpStrList.Add('    ' + lblcigar.Caption);
      end;
      if (eddays2.Text <> '') or (edyears2.Text <> '') then
      begin
        TmpStrList.Add('  Smoking: Pipe');
        if eddays2.Text  <> '' then  TmpStrList.Add('    Bowls per Day: ' + eddays2.Text);
        if edyears2.Text <> '' then  TmpStrList.Add('    Number of Years: ' + edyears2.Text);
        if lblpipe.Visible = True then
          TmpStrList.Add('    ' + lblpipe.Caption);
      end;
    end;

    {chew}
    if cbno2.Checked then
      TmpStrList.Add('  ' + cbno2.Hint)
    else if cbchew.Checked then
    begin
      TmpStrList.Add('  Chew: YES');
      if ledchewday.Text   <> '' then TmpStrList.Add('    ' + ledchewday.EditLabel.Caption + ': ' + ledchewday.Text);
      if ledchewyears.Text <> '' then TmpStrList.Add('    ' + ledchewyears.EditLabel.Caption + ': ' + ledchewyears.Text);
      if ledepisode.Text   <> '' then TmpStrList.Add('    ' + ledepisode.EditLabel.Caption + ': ' + ledepisode.Text);
    end;

    {second}
    if cbno3.Checked then
      TmpStrList.Add('  ' + cbno3.Hint)
    else if cbsecond.Checked then
    begin
      TmpStrList.Add('  ' + cbsecond.Hint);
      if ledsecond.Text  <> '' then
        TmpStrList.Add('    ' + ledsecond.EditLabel.Caption + ' ' + ledsecond.Text);
    end;

    {quit}
    if ledquit.Text    <> ''   then TmpStrList.Add('  ' + ledquit.EditLabel.Caption + ': ' + ledquit.Text);
    if leddate.Text    <> ''   then TmpStrList.Add('    ' + leddate.EditLabel.Caption + ': ' + leddate.Text);
    if ledtobacco.Text <> ''   then TmpStrList.Add('    Comments: ' + ledtobacco.Text);
  end;
  TmpStrList.Add('');
// END Tobacco -----------------------------------------------------------------

// START Alcohol & Drugs -------------------------------------------------------
 {alcohol}
  if cbalcoholno.Checked then
  begin
    TmpStrList.Add('Alcohol use:');
    TmpStrList.Add('  ' + cbalcoholno.Hint);
    TmpStrList.Add('');
  end else if cbalcoholyes.Checked then
  begin
    TmpStrList.Add('Alcohol use:');
    TmpStrList.Add('  ' + cbalcoholyes.Hint);

    if (ledwine.Text <> '') and (cobwine.Text <> '') then
      TmpStrList.Add('    ' + ledwine.EditLabel.Caption + ' ' + ledwine.Text + ' ' + cobwine.Text);
    if (ledbeer.Text <> '') and (cobbeer.Text <> '') then
      TmpStrList.Add('    ' + ledbeer.EditLabel.Caption + ' ' + ledbeer.Text + ' ' + cobbeer.Text);
    if (ledspirits.Text <> '') and (cobspirits.Text <> '') then
      TmpStrList.Add('    ' + ledspirits.EditLabel.Caption + ' ' + ledspirits.Text + ' ' + cobspirits.Text);

    if ledquitalcohol.Text    <> ''   then TmpStrList.Add('  ' + ledquitalcohol.EditLabel.Caption + ': ' + ledquitalcohol.Text);
    if leddatealcohol.Text    <> ''   then TmpStrList.Add('    ' + leddatealcohol.EditLabel.Caption + ': ' + leddatealcohol.Text);
    if ledalcohol.Text        <> ''   then TmpStrList.Add('    Comments: ' + ledalcohol.Text);
    TmpStrList.Add('');
  end;

  {drugs}
  if cbdrugsno.Checked then
  begin
    TmpStrList.Add('Drug use:');
    TmpStrList.Add('  ' + cbdrugsno.Hint);
    TmpStrList.Add('');
  end else if cbdrugsyes.Checked then
  begin
    TmpStrList.Add('Drug use:');
    TmpStrList.Add('  ' + cbdrugsyes.Hint);

    if (cobNarc.Text <> '') and (cobRNarc.Text <> '') then
    begin
      if LabeledEdit3.Text <> '' then
        TmpStrList.Add('    ' + cobNarc.Hint + ': ' + cobnarc.Text + ' by ' + cobRnarc.Text + ' Frequency: ' + LabeledEdit3.Text)
      else
        TmpStrList.Add('    ' + cobNarc.Hint + ': ' + cobnarc.Text + ' by ' + cobRnarc.Text);
    end;
    if (cobStim.Text <> '') and (cobRStim.Text <> '') then
    begin
      if LabeledEdit4.Text <> '' then
        TmpStrList.Add('    ' + cobStim.Hint + ': ' + cobStim.Text + ' by ' + cobRStim.Text + ' Frequency: ' + LabeledEdit4.Text)
      else
        TmpStrList.Add('    ' + cobStim.Hint + ': ' + cobStim.Text + ' by ' + cobRStim.Text);
    end;
    if (cobHall.Text <> '') and (cobRHall.Text <> '') then
    begin
      if LabeledEdit5.Text <> '' then
        TmpStrList.Add('    ' + cobHall.Hint + ': ' + cobHall.Text + ' by ' + cobRHall.Text + ' Frequency: ' + LabeledEdit5.Text)
      else
        TmpStrList.Add('    ' + cobHall.Hint + ': ' + cobHall.Text + ' by ' + cobRHall.Text);
    end;
    if (cobOther.Text <> '') and (cobROther.Text <> '') then
    begin
      if LabeledEdit6.Text <> '' then
        TmpStrList.Add('    ' + cobOther.Hint + ': ' + cobOther.Text + ' by ' + cobROther.Text + ' Frequency: ' + LabeledEdit6.Text)
      else
        TmpStrList.Add('    ' + cobOther.Hint + ': ' + cobOther.Text + ' by ' + cobROther.Text);
    end;

    if ledquitdrugs.Text    <> ''   then TmpStrList.Add('  ' + ledquitdrugs.EditLabel.Caption + ': ' + ledquitdrugs.Text);
    if leddatedrugs.Text    <> ''   then TmpStrList.Add('    ' + leddatedrugs.EditLabel.Caption + ': ' + leddatedrugs.Text);
    if leddrugs.Text        <> ''   then TmpStrList.Add('    Comments: ' + leddrugs.Text);

    TmpStrList.Add('');
  end;
// END Alcohol & Drugs ---------------------------------------------------------
end;

procedure TdlgSocial.Calculate(ed1: TEdit; ed2: TEdit; lbl: Tlabel);
var
  packs: single;
  years: single;
  packxyears: single;
begin
  packs := strtofloat(ed1.Text);
  years := strtofloat(ed2.Text);
  packxyears := (packs * years * 365);
  lbl.Caption := lbl.Caption + ': ' + floattostr(packxyears);
  lbl.Visible := True;
end;

procedure TdlgSocial.tobacco(Sender: TObject);
begin
  if (cbsmoke.Checked) or (cbchew.Checked) or (cbsecond.Checked) then
    cbnosmoke.Visible := False
  else
    cbnosmoke.Visible := True;
end;

procedure TdlgSocial.cbnosmokeClick(Sender: TObject);
{no tobacco use}
begin
  cbsmoke.Visible := not cbnosmoke.Checked;
  cbchew.Visible := not cbnosmoke.Checked;
  cbsecond.Visible := not cbnosmoke.Checked;
  cbno1.Visible := not cbnosmoke.Checked;
  cbno2.Visible := not cbnosmoke.Checked;
  cbno3.Visible := not cbnosmoke.Checked;
  Label10.Visible := not cbnosmoke.Checked;
  Label11.Visible := not cbnosmoke.Checked;
  Label12.Visible := not cbnosmoke.Checked;

  if cbnosmoke.Checked then
  begin
    cbno1.Checked := False;
    cbno2.Checked := False;
    cbno3.Checked := False;
    cbno1.Visible := False;
    cbno2.Visible := False;
    cbno3.Visible := False;
    cbsmoke.Visible := False;
    cbchew.Visible := False;
    cbsecond.Visible := False;
  end;
end;

procedure TdlgSocial.cbsmokeClick(Sender: TObject);
{smoke yes}
begin
  gbcigarette.Visible := cbsmoke.Checked;
  gbcigar.Visible := cbsmoke.Checked;
  gbpipe.Visible := cbsmoke.Checked;
  eddays.Clear;
  edyears.Clear;
  eddays1.Clear;
  edyears1.Clear;
  eddays2.Clear;
  edyears2.Clear;
  if cbsmoke.Checked then
    cbno1.Visible := False
  else
    cbno1.Visible := True;

  Tobacco(Sender);
end;

procedure TdlgSocial.cbno1Click(Sender: TObject);
{smoke no}
begin
  if cbno1.Checked then
    cbsmoke.Visible := False
  else
    cbsmoke.Visible := True;
end;

procedure TdlgSocial.cbchewClick(Sender: TObject);
{chew yes}
begin
  gbchew.Visible := cbchew.Checked;
  ledchewday.Clear;
  ledchewyears.Clear;
  ledepisode.Clear;
  if cbchew.Checked then
    cbno2.Visible := False
  else
    cbno2.Visible := True;

  Tobacco(Sender);
end;

procedure TdlgSocial.cbno2Click(Sender: TObject);
{chew no}
begin
  if cbno2.Checked then
    cbchew.Visible := False
  else
    cbchew.Visible := True;
end;

procedure TdlgSocial.cbsecondClick(Sender: TObject);
{second yes}
begin
  ledsecond.Clear;
  ledsecond.Visible := cbsecond.Checked;
  if cbsecond.Checked then
    cbno3.Visible := False
  else
    cbno3.Visible := True;

  Tobacco(Sender);
end;

procedure TdlgSocial.cbno3Click(Sender: TObject);
{second no}
begin
  if cbno3.Checked then
    cbsecond.Visible := False
  else
    cbsecond.Visible := True;
end;

procedure TdlgSocial.eddaysChange(Sender: TObject);
{cigarettes}
begin
  lblcigarette.Caption := 'Pack year history';
  if (eddays.Text <> '') and (edyears.Text <> '') then
     Calculate(eddays,edyears,lblcigarette)
  else
    lblcigarette.Visible := False; 
end;

procedure TdlgSocial.eddays1Change(Sender: TObject);
{cigar}
begin
  lblcigar.Caption := 'Pack year history';
  if (eddays1.Text <> '') and (edyears1.Text <> '') then
     Calculate(eddays1,edyears1,lblcigar)
  else
    lblcigar.Visible := False;
end;

procedure TdlgSocial.eddays2Change(Sender: TObject);
{pipe}
begin
  lblpipe.Caption := 'Bowls year history';
  if (eddays2.Text <> '') and (edyears2.Text <> '') then
     Calculate(eddays2,edyears2,lblpipe)
  else
    lblpipe.Visible := False;
end;

procedure TdlgSocial.cbalcoholyesClick(Sender: TObject);
{alcohol - yes}
begin
  ledwine.Clear;
  ledbeer.Clear;
  ledspirits.Clear;
  cobwine.Text := '';
  cobbeer.Text := '';
  cobspirits.Text := '';
  gbalcohol.Visible := cbalcoholyes.Checked;
  if cbalcoholyes.Checked then
    cbalcoholno.Visible := False
  else
    cbalcoholno.Visible := True;
end;

procedure TdlgSocial.cbalcoholnoClick(Sender: TObject);
{alcohol - no}
begin
  if cbalcoholno.Checked then
    cbalcoholyes.Visible := False
  else
    cbalcoholyes.Visible := True;
end;

procedure TdlgSocial.cbdrugsyesClick(Sender: TObject);
{drugs - yes}
var
  I: Integer;
begin
  for I := 0 to gbdrugs.ControlCount - 1 do
    if (gbdrugs.Controls[I] is TComboBox) then
      (gbdrugs.Controls[I] as TComboBox).Text := '';

  cobnarc.Text := '';
  gbdrugs.Visible := cbdrugsyes.Checked;
  if cbdrugsyes.Checked then
    cbdrugsno.Visible := False
  else
    cbdrugsno.Visible := True;
end;

procedure TdlgSocial.cbdrugsnoClick(Sender: TObject);
{drug - no}
begin
  if cbdrugsno.Checked then
    cbdrugsyes.Visible := False
  else
    cbdrugsyes.Visible := True;
end;

procedure TdlgSocial.edyearsChange(Sender: TObject);
{cigarettes}
begin
  lblcigarette.Caption := 'Pack year history';
  if (eddays.Text <> '') and (edyears.Text <> '') then
     Calculate(eddays,edyears,lblcigarette)
  else
    lblcigarette.Visible := False;
end;

Procedure TdlgSocial.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked then
    cb2.Checked := False;
end;

procedure TdlgSocial.cb1Click(Sender: TObject);
begin
 if (Sender is TCheckBox) then
  case (Sender as TCheckBox).Tag of
    1: ToggleCB(cb3,cb4);
    2: ToggleCB(cb4,cb3);
    3: ToggleCB(cb5,cb6);
    4: ToggleCB(cb6,cb5);
    5: ToggleCB(cb9,cb10);
    6: ToggleCB(cb10,cb9);
    7: ToggleCB(cb11,cb12);
    8: ToggleCB(cb12,cb11);
    9: ToggleCB(cb13,cb14);
   10: ToggleCB(cb14,cb13);
   11: ToggleCB(cb15,cb16);
   12: ToggleCB(cb16,cb15);
   13: ToggleCB(cb17,cb18);
   14: ToggleCB(cb18,cb17);
   15: ToggleCB(CheckBox15,CheckBox16);
   16: ToggleCB(CheckBox16,CheckBox15);
   17: ToggleCB(CheckBox6,CheckBox5);
   18: ToggleCB(CheckBox5,CheckBox6);
   19: ToggleCB(CheckBox12,CheckBox11);
   20: ToggleCB(CheckBox11,CheckBox12);
   21: ToggleCB(CheckBox14,CheckBox13);
   22: ToggleCB(CheckBox13,CheckBox14);
   23: ToggleCB(CheckBox7,CheckBox8);
   24: ToggleCB(CheckBox8,CheckBox7);
   25: ToggleCB(cb1,cb2);
   26: ToggleCB(cb2,cb1);
   27: ToggleCB(CheckBox17,CheckBox18);
   28: ToggleCB(CheckBox18,CheckBox17);
   29: ToggleCB(CheckBox19,CheckBox20);
   30: ToggleCB(CheckBox20,CheckBox19);
  end;
end;

end.
