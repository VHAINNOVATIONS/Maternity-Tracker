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
  StdCtrls, ExtCtrls, Buttons, ComCtrls, uDialog, uExtndComBroker;

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
    gb4: TGroupBox;
    Label2: TLabel;
    cbalcoholyes: TCheckBox;
    cbalcoholno: TCheckBox;
    ledalcohol: TLabeledEdit;
    gb5: TGroupBox;
    Label3: TLabel;
    cbdrugsyes: TCheckBox;
    cbdrugsno: TCheckBox;
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
    eddays: TEdit;
    edyears: TEdit;
    cbsmoke: TCheckBox;
    ledtobacco: TLabeledEdit;
    gbcigar: TGroupBox;
    Label1: TLabel;
    Label7: TLabel;
    eddays1: TEdit;
    edyears1: TEdit;
    gbchew: TGroupBox;
    ledchewday: TLabeledEdit;
    ledchewyears: TLabeledEdit;
    gbpipe: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    eddays2: TEdit;
    edyears2: TEdit;
    cbsecond: TCheckBox;
    cbno1: TCheckBox;
    cbno2: TCheckBox;
    cbno3: TCheckBox;
    ledquit: TLabeledEdit;
    leddate: TLabeledEdit;
    lblcigarette: TLabel;
    lblcigar: TLabel;
    lblpipe: TLabel;
    ledepisode: TLabeledEdit;
    ledsecond: TLabeledEdit;
    gbalcohol: TGroupBox;
    ledwine: TLabeledEdit;
    Label13: TLabel;
    cobwine: TComboBox;
    ledbeer: TLabeledEdit;
    Label14: TLabel;
    cobbeer: TComboBox;
    ledspirits: TLabeledEdit;
    Label15: TLabel;
    cobspirits: TComboBox;
    ledquitalcohol: TLabeledEdit;
    leddatealcohol: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    ledquitdrugs: TLabeledEdit;
    leddatedrugs: TLabeledEdit;
    SpeedButton2: TSpeedButton;
    leddrugs: TLabeledEdit;
    gbdrugs: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    cobStim: TComboBox;
    cobOther: TComboBox;
    Label19: TLabel;
    cobRnarc: TComboBox;
    Label20: TLabel;
    cobRStim: TComboBox;
    Label21: TLabel;
    cobRother: TComboBox;
    cobHall: TComboBox;
    cobRHall: TComboBox;
    Label22: TLabel;
    Label23: TLabel;
    cobnarc: TComboBox;
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
    gbRelation: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    UpDown1: TUpDown;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    Label5: TLabel;
    CheckBox6: TCheckBox;
    CheckBox5: TCheckBox;
    Label6: TLabel;
    le1: TLabeledEdit;
    cb2: TCheckBox;
    cb1: TCheckBox;
    Label25: TLabel;
    edtBirthControl: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label24: TLabel;
    Label35: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    Label36: TLabel;
    Label37: TLabel;
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
    procedure AdvComboBoxDropDown(Sender: TObject);
    procedure edyearsChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure cb1Click(Sender: TObject);
    procedure cb5Click(Sender: TObject);
  private                                        { Private declarations }
    procedure tobacco(Sender: TObject);
    procedure Calculate(ed1:TEdit; ed2:TEdit; lbl:TLabel);
    Procedure ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
  public                                         { Public declarations }
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
{get date}
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

procedure TdlgSocial.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I: integer;
  TmpStr:  String;
  CompChecked: Integer;

  {Check for at least 1 checkbox = True }
  function Check4CB(InGB: TGroupBox): boolean;
  var
    J: integer;
  begin
    for J := 0 to InGB.ControlCount - 1 do
    begin
      if (InGB.Controls[J] is TCheckBox) and ((InGB.Controls[J] as TCheckBox).Checked = True) then
      begin
        Result := TRUE;
        Exit;
      end;
    end;
    Result := FALSE;
  end;

  {Check for label edit boxes }
  function Check4LED(InGB: TGroupBox): boolean;
  var
    J: integer;
  begin
    for J := 0 to InGB.ControlCount - 1 do
    begin
      if (InGB.Controls[J] is TLabeledEdit) and ((InGB.Controls[J] as TLabeledEdit).Text <> '') then
      begin
        Result := TRUE;
        Exit;
      end;
    end;
    Result := FALSE;
  end;

begin
  {Lifestyle}
  if (Check4CB(gb1) = True) then
  begin
    TmpStrList.Add('Lifestyle:');
    if cb3.Checked then
    begin
      TmpStrList.Add('  Health Hazards at home/work? Yes');
      if le2.Text <> '' then
      TmpStrList.Add('    Comments: ' + le2.Text);
    end
    else if cb4.Checked then
    begin
      TmpStrList.Add('  Health Hazards at home/work? No');
      if le2.Text <> '' then
      TmpStrList.Add('    Comments: ' + le2.Text);
    end;
    // 3rd question
    if cb5.Checked then
    begin
      TmpStrList.Add('  Seat Belt use? Yes');
      if LabeledEdit7.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit7.Text);
    end
    else if cb6.Checked then
    begin
      TmpStrList.Add('  Seat Belt use? No');
      if LabeledEdit7.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit7.Text);
    end;
   // 4th question
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
    // 5th question
    if cb11.Checked then
    begin
      TmpStrList.Add('  Folic Acid intake? Yes');
      if LabeledEdit8.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit8.Text);
    end
    else if cb12.Checked then
    begin
      TmpStrList.Add('  Folic Acid intake? No');
      if LabeledEdit8.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit8.Text);
    end;
    // 6th question
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
    // 7th question
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
    // 8th question
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

    if leOther.Text <> '' then
    TmpStrList.Add('  ' + leOther.Text);
  end;
  {Sexual History}
  if (Check4CB(gbRelation) = True) or (LabeledEdit1.Text <> '0') then
  begin
    TmpStrList.Add('Relationship/Sexual History:');
    // 1st question
    TmpStrList.Add('  Age at first sexual encounter: ' + LabeledEdit1.Text);
    // 2nd question
    if trim(edtBirthControl.Text) <> '' then
    TmpStrList.Add('  Most Recent Method of Birth Control: ' + edtBirthControl.Text);
    // 3rd question
    if CheckBox9.Checked then
    begin
      TmpStrList.Add('  Change in or more than one sexual partner in last 12 months? Yes');
      if LabeledEdit12.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit12.Text);
    end
    else if CheckBox10.Checked then
    begin
      TmpStrList.Add('  Change in or more than one sexual partner in last 12 months? No');
      if LabeledEdit12.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit12.Text);
    end;
    // 4th question
    if CheckBox1.Checked then
    begin
      TmpStrList.Add('  Do you have sex with men? Yes');
      if LabeledEdit13.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit13.Text);
    end
    else if CheckBox2.Checked then
    begin
      TmpStrList.Add('  Do you have sex with men? No');
      if LabeledEdit13.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit13.Text);
    end;
    // 5th question
    if CheckBox3.Checked then
    begin
      TmpStrList.Add('  Do you have sex with women? Yes');
      if LabeledEdit14.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit14.Text);
    end
    else if CheckBox4.Checked then
    begin
      TmpStrList.Add('  Do you have sex with women? No');
      if LabeledEdit14.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit14.Text);
    end;
    // 6th question
    if CheckBox5.Checked then
    begin
      TmpStrList.Add('  Are you satisfied with your current sexual experiences? Yes');
      if LabeledEdit2.Text <> '' then TmpStrList.Add('  Comments: ' + LabeledEdit2.Text);
    end
    else if CheckBox6.Checked then
    begin
      TmpStrList.Add('  Are you satisfied with your current sexual experiences? No');
      if LabeledEdit2.Text <> '' then TmpStrList.Add('  Comments: ' + LabeledEdit2.Text);
    end;
    // 7th question
    if cb1.Checked then
    begin
      TmpStrList.Add('  Interpersonal Violence? Yes');
      if le1.Text <> '' then
      TmpStrList.Add('    Comments: ' + le1.Text);
    end
    else if cb2.Checked then
    begin
      TmpStrList.Add('  Interpersonal Violence? No');
      if le1.Text <> '' then
      TmpStrList.Add('    Comments: ' + le1.Text);
    end;
    // 8th question
    if Checkbox7.Checked then
    begin
      TmpStrList.Add('  Military Sexual Trauma? Yes');
      if LabeledEdit11.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit11.Text);
    end
    else if CheckBox8.Checked then
    begin
      TmpStrList.Add('  Military Sexual Trauma? No');
      if LabeledEdit11.Text <> '' then
      TmpStrList.Add('    Comments: ' + LabeledEdit11.Text);
    end;
  end;
  {tobacco use}
  if (Check4CB(gb3) = True) or (ledtobacco.Text <> '') then
  begin
    TmpStrList.Add('Tobacco use:');
    if cbnosmoke.Checked = True then TmpStrList.Add('  ' + cbnosmoke.Caption);
    if cbno1.Checked     = True then TmpStrList.Add('  ' + cbno1.Hint);
    {smoke}
    if cbsmoke.Checked = True then
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
    if cbno2.Checked = True then TmpStrList.Add('  ' + cbno2.Hint);
    if cbchew.Checked = True then
    begin
      TmpStrList.Add('  Chew: YES');
      if ledchewday.Text   <> '' then TmpStrList.Add('    ' + ledchewday.EditLabel.Caption + ': ' + ledchewday.Text);
      if ledchewyears.Text <> '' then TmpStrList.Add('    ' + ledchewyears.EditLabel.Caption + ': ' + ledchewyears.Text);
      if ledepisode.Text   <> '' then TmpStrList.Add('    ' + ledepisode.EditLabel.Caption + ': ' + ledepisode.Text);
    end;
    {second}
    if cbsecond.Checked = True then TmpStrList.Add('  ' + cbsecond.Hint);
    if ledsecond.Text  <> ''   then TmpStrList.Add('    ' + ledsecond.EditLabel.Caption + ' ' + ledsecond.Text);
    if cbno3.Checked    = True then TmpStrList.Add('  ' + cbno3.Hint);

    if ledquit.Text    <> ''   then TmpStrList.Add('  ' + ledquit.EditLabel.Caption + ': ' + ledquit.Text);
    if leddate.Text    <> ''   then TmpStrList.Add('    ' + leddate.EditLabel.Caption + ': ' + leddate.Text);
    if ledtobacco.Text <> ''   then TmpStrList.Add('    Comments: ' + ledtobacco.Text);
      TmpStrList.Add('');
  end;
  {alcohol}
  if (Check4CB(gb4) = True) or (ledalcohol.Text <> '') then
  begin
    TmpStrList.Add('Alcohol use:');
    if cbalcoholno.Checked = True then TmpStrList.Add('  ' + cbalcoholno.Hint);
    if cbalcoholyes.Checked = True then
    begin
      TmpStrList.Add('  ' + cbalcoholyes.Hint);
      if (ledwine.Text <> '') and (cobwine.Text <> '') then
        TmpStrList.Add('    ' + ledwine.EditLabel.Caption + ' ' + ledwine.Text + ' ' + cobwine.Text);
      if (ledbeer.Text <> '') and (cobbeer.Text <> '') then
        TmpStrList.Add('    ' + ledbeer.EditLabel.Caption + ' ' + ledbeer.Text + ' ' + cobbeer.Text);
      if (ledspirits.Text <> '') and (cobspirits.Text <> '') then
        TmpStrList.Add('    ' + ledspirits.EditLabel.Caption + ' ' + ledspirits.Text + ' ' + cobspirits.Text);
    end;
    if ledquitalcohol.Text    <> ''   then TmpStrList.Add('  ' + ledquitalcohol.EditLabel.Caption + ': ' + ledquitalcohol.Text);
    if leddatealcohol.Text    <> ''   then TmpStrList.Add('    ' + leddatealcohol.EditLabel.Caption + ': ' + leddatealcohol.Text);
    if ledalcohol.Text        <> ''   then TmpStrList.Add('    Comments: ' + ledalcohol.Text);
    TmpStrList.Add('');
  end;
  {drugs}
  if (Check4CB(gb5) = True) or (leddrugs.Text <> '') then
  begin
    TmpStrList.Add('Drug use:');
    if cbdrugsno.Checked = True then TmpStrList.Add('  ' + cbdrugsno.Hint);
    if cbdrugsyes.Checked = True then
    begin
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
    end;
    if ledquitdrugs.Text    <> ''   then TmpStrList.Add('  ' + ledquitdrugs.EditLabel.Caption + ': ' + ledquitdrugs.Text);
    if leddatedrugs.Text    <> ''   then TmpStrList.Add('    ' + leddatedrugs.EditLabel.Caption + ': ' + leddatedrugs.Text);
    if leddrugs.Text        <> ''   then TmpStrList.Add('    Comments: ' + leddrugs.Text);
    TmpStrList.Add('');
  end;
end;

procedure TdlgSocial.Calculate(ed1:TEdit; ed2:TEdit; lbl:Tlabel);
{calculate packs per year}
var
  packs      : single;
  years      : single;
  packxyears : single;
begin
  packs := strtofloat(ed1.Text);
  years := strtofloat(ed2.Text);
  packxyears := (packs * years * 365);
  lbl.Caption := lbl.Caption + ': ' + floattostr(packxyears);
  lbl.Visible := True;
end;

procedure TdlgSocial.tobacco(Sender: TObject);
{tobacco use}
begin
  if (cbsmoke.Checked = True) or (cbchew.Checked = True) or
     (cbsecond.Checked = True)  then
    cbnosmoke.Visible := False
  else
    cbnosmoke.Visible := True;
end;

procedure TdlgSocial.cbnosmokeClick(Sender: TObject);
{no tobacco use}
begin
  cbsmoke.Visible  :=  not cbnosmoke.Checked;
  cbchew.Visible   :=  not cbnosmoke.Checked;
  cbsecond.Visible :=  not cbnosmoke.Checked;
  cbno1.Visible    :=  not cbnosmoke.Checked;
  cbno2.Visible    :=  not cbnosmoke.Checked;
  cbno3.Visible    :=  not cbnosmoke.Checked;
  Label10.Visible    :=  not cbnosmoke.Checked;
  Label11.Visible    :=  not cbnosmoke.Checked;
  Label12.Visible    :=  not cbnosmoke.Checked;

  if cbnosmoke.Checked then
  begin
    cbno1.Checked    :=  FALSE;
    cbno2.Checked    :=  FALSE;
    cbno3.Checked    :=  FALSE;
    cbno1.Visible    :=  FALSE;
    cbno2.Visible    :=  FALSE;
    cbno3.Visible    :=  FALSE;
    cbsmoke.Visible  :=  FALSE;
    cbchew.Visible   :=  FALSE;
    cbsecond.Visible :=  FALSE;
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
  if cbsmoke.Checked = True then
    cbno1.Visible := False
  else
    cbno1.Visible := True;

//   if cbsmoke.Checked = True then
//    cbno1.Checked := False
//  else
//    cbno1.Checked := True;
  Tobacco(Sender);
end;

procedure TdlgSocial.cbno1Click(Sender: TObject);
{smoke no}
begin
  if cbno1.Checked = True then
    cbsmoke.Visible := False
  else
    cbsmoke.Visible := True;
  //if cbno1.Checked = True then
//    cbsmoke.Checked := False
//  else
//    cbsmoke.Checked := True;
end;

procedure TdlgSocial.cbchewClick(Sender: TObject);
{chew yes}
begin
  gbchew.Visible := cbchew.Checked;
  ledchewday.Clear;
  ledchewyears.Clear;
  ledepisode.Clear;
  if cbchew.Checked = True then
    cbno2.Visible := False
  else
    cbno2.Visible := True;
  Tobacco(Sender);
end;

procedure TdlgSocial.cbno2Click(Sender: TObject);
{chew no}
begin
  if cbno2.Checked = True then
    cbchew.Visible := False
  else
    cbchew.Visible := True;
end;

procedure TdlgSocial.cbsecondClick(Sender: TObject);
{second yes}
begin
  ledsecond.Clear;
  ledsecond.Visible := cbsecond.Checked;
  if cbsecond.Checked = True then
    cbno3.Visible := False
  else
    cbno3.Visible := True;
  Tobacco(Sender);
end;

procedure TdlgSocial.cbno3Click(Sender: TObject);
{second no}
begin
  if cbno3.Checked = True then
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
  cobwine.Text    := '';
  cobbeer.Text    := '';
  cobspirits.Text := '';
  gbalcohol.Visible := cbalcoholyes.Checked;
  if cbalcoholyes.Checked = True then
    cbalcoholno.Visible := False
  else
    cbalcoholno.Visible := True;
end;

procedure TdlgSocial.cbalcoholnoClick(Sender: TObject);
{alcohol - no}
begin
  if cbalcoholno.Checked = True then
    cbalcoholyes.Visible := False
  else
    cbalcoholyes.Visible := True;
end;

procedure TdlgSocial.cbdrugsyesClick(Sender: TObject);
{drugs - yes}
var
  I : integer;
begin
  for I := 0 to gbdrugs.ControlCount -1 do
    if (gbdrugs.Controls[I] is TComboBox) then
      (gbdrugs.Controls[I] as TComboBox).Text := '';
  cobnarc.Text := '';
  gbdrugs.Visible := cbdrugsyes.Checked;
  if cbdrugsyes.Checked = True then
    cbdrugsno.Visible := False
  else
    cbdrugsno.Visible := True;
end;

procedure TdlgSocial.cbdrugsnoClick(Sender: TObject);
{drug - no}
begin
  if cbdrugsno.Checked = True then
    cbdrugsyes.Visible := False
  else
    cbdrugsyes.Visible := True;
end;

procedure TdlgSocial.AdvComboBoxDropDown(Sender: TObject);
var
  MaxWidth : integer;
  cntr : integer;
begin
//  if (TComboBox(Sender).DropWidth) = 0 then
//  begin
//    MaxWidth := 0;
//    for cntr := 0 to TComboBox(Sender).Items.Count-1 do
//    begin
//      label9999.Caption := TComboBox(Sender).Items[cntr];
//      if MaxWidth < label9999.Width then
//        MaxWidth := label9999.Width;
//    end;
//    if (MaxWidth >= TComboBox(Sender).Width) then
//      TComboBox(Sender).DropWidth := MaxWidth + 10;
//  end;
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


procedure TdlgSocial.CheckBox1Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin {Yes}
    if (Sender as TCheckBox).Checked = TRUE then
    begin
      CheckBox2.Checked := FALSE; {No}
      CheckBox1.Checked := TRUE; {Yes}
    end
    else
    begin {None}
      CheckBox1.Checked := FALSE;
    end;
  end
  else if (Sender as TCheckBox).Tag = 2 then
  begin {No}
    CheckBox1.Checked := FALSE;
  end
  else if (Sender as TCheckBox).Tag = 3 then
  begin {Yes}
    if (Sender as TCheckBox).Checked = TRUE then
    begin
      CheckBox4.Checked := FALSE;
      CheckBox3.Checked := TRUE;
    end
    else
    begin {None}
      CheckBox3.Checked := FALSE;
    end;
  end
  else if (Sender as TCheckBox).Tag = 4 then
  begin {No}
    CheckBox3.Checked := FALSE;
  end
  else if (Sender as TCheckBox).Tag = 5 then
  begin {Yes}
    CheckBox6.Checked := FALSE;
  end
  else if (Sender as TCheckBox).Tag = 6 then
  begin {No}
    if (Sender as TCheckBox).Checked = TRUE then
    begin
      CheckBox5.Checked := FALSE;
      CheckBox6.Checked := TRUE;
    end
    else
    begin
      CheckBox6.Checked := FALSE;
    end;
  end;
end;

Procedure TdlgSocial.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
    cb2.Checked := False;
end;

procedure TdlgSocial.cb1Click(Sender: TObject);
begin
//  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = True) then
     case (Sender as TCheckBox).Tag of
        1: ToggleCB(cb1,cb2);
        2: ToggleCB(cb2,cb1);
        3: ToggleCB(cb3,cb4);
        4: ToggleCB(cb4,cb3);
   //     5: ToggleCB(cb5,cb6);
   //     6: ToggleCB(cb6,cb5);
        9: ToggleCB(cb9,cb10);
        10: ToggleCB(cb10,cb9);
        11: begin {Yes}
              if cb11.Checked then
              begin
                ToggleCB(cb11,cb12);
              end
              else
              begin
                //le4.Visible := FALSE;
                //le4.Clear;
              end;
            end;
        12: begin {No}
              ToggleCB(cb12,cb11);
            end;
        13: begin {Yes}
              if cb13.Checked then
              begin
                ToggleCB(cb13,cb14);
              end
              else
              begin
                //le5.Visible := FALSE;
                //le5.Clear;
              end;
            end;
        14: begin  {No}
              ToggleCB(cb14,cb13);
            end;
        15: ToggleCB(cb15,cb16);
        16: ToggleCB(cb16,cb15);
        17: begin
              if cb17.Checked then
              begin
                ToggleCB(cb17,cb18);
              end
              else
              begin
              end;
            end;
        18: begin
              ToggleCB(cb18,cb17);
            end;
   end;  {end case}
end;

procedure TdlgSocial.cb5Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 5 then
  begin {Yes}
    if cb5.Checked then
    begin
      cb6.Checked := FALSE;
    end;
  end
  else if (Sender as TCheckBox).Tag = 6 then
  begin {No}
    if cb6.Checked = True then
      cb5.Checked := FALSE
    else
    begin
      //cb7.Checked := FALSE;
      //cb8.Checked := FALSE;
    end;
  end;
end;

end.
