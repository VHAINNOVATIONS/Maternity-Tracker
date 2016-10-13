unit frmVitals;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.ConvUtils, System.StdConvs, System.DateUtils, System.StrUtils,
  System.Generics.Collections, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Graphics, ORDtTm, ORCtrls, ORFn;

type
  TSayOnFocus = class(TObject)
    FOwningObject: TWinControl;
    Text: string;
  end;

  TEventType = (evLMP,evECD,evUlt,evEmT,evOth,evUkn);

  TDDCSVitals = class(TFrame)
    fVitalsControl: TPageControl;
    PageMain: TTabSheet;
    PageEDD: TTabSheet;
    PageLMP: TTabSheet;
    FTemps: TEdit;
    FHeights: TEdit;
    FWeights: TEdit;
    FTempe: TEdit;
    FHeighte: TEdit;
    FWeighte: TEdit;
    FPulses: TEdit;
    FResps: TEdit;
    FPains: TEdit;
    FSystolics: TEdit;
    FDiastolics: TEdit;
    edtEDDLMP: TORDateBox;
    edtEDDECD: TORDateBox;
    edtEDDUltra: TORDateBox;
    edtEDDEmbryo: TORDateBox;
    edtEDDOther: TORDateBox;
    lblOther: TEdit;
    edtFinalGA: TEdit;
    FTempdt: TLabel;
    FHeightdt: TLabel;
    FWeightdt: TLabel;
    FTempl: TLabel;
    FHeightl: TLabel;
    FWeightl: TLabel;
    FPulsedt: TLabel;
    FPulsel: TLabel;
    FRespl: TLabel;
    FRespdt: TLabel;
    FPainl: TLabel;
    FPaindt: TLabel;
    FSystolicl: TLabel;
    FSystolicdt: TLabel;
    FDiastolicl: TLabel;
    FDiastolicdt: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    lblLMP: TLabel;
    lblECD: TLabel;
    lblUltra: TLabel;
    lblUnknown: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbLMP: TLabel;
    Panel2: TPanel;
    FAge: TLabel;
    FSex: TLabel;
    FBMI: TLabel;
   	Label14: TLabel;
  	lblEmbryo: TLabel;
    ckContraceptionNo: TCheckBox;
    ckContraceptionYes: TCheckBox;
    ckLMPQualifier: TCheckBox;
    dtLMP: TORDateBox;
    dtECD: TORDateBox;
    dtUltra: TORDateBox;
    dtEmbryo: TORDateBox;
    dtOther: TORDateBox;
    edtLMP: TORDateBox;	
	  dtEDDUnknown: TORDateBox;
    edtContraceptionType: TCaptionComboBox;
   	cbTransferDay: TCaptionComboBox;
  	memLMP: TCaptionMemo;
    spnWeekUltra: TSpinEdit;
    spnDayUltra: TSpinEdit;
    spnWeekOther: TSpinEdit;
    spnDayOther: TSpinEdit;
    Panel1: TPanel;
    FAgeValue: TStaticText;
    FSexValue: TStaticText;
    FBMIValue: TStaticText;
    gbMenses: TGroupBox;
    ckMensesYes: TCheckBox;
    ckMensesNo: TCheckBox;
    Label1: TLabel;
    ckBirthPillsYes: TCheckBox;
    ckBirthPillsNo: TCheckBox;
    lbFrequency: TLabel;
    spnFreq: TSpinEdit;
    Label2: TLabel;
    edthcg: TORDateBox;
    lbHCG: TLabel;
    spnMenarche: TSpinEdit;
    lbMenarche: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    ckAmountNo: TCheckBox;
    ckAmountYes: TCheckBox;
    ckDurationNo: TCheckBox;
    ckDurationYes: TCheckBox;
    Label4: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    lbFinalEDD: TLabel;
    edtCurrentEDD: TORDateBox;
    Label15: TLabel;
    edtEDDGA: TEdit;
    lbMonthly: TLabel;
    ckMonthlyYes: TCheckBox;
    ckMonthlyNo: TCheckBox;
    ckFinalEDDLMP: TCheckBox;
    ckFinalEDDUltra: TCheckBox;
    ckFinalEDDEmbryo: TCheckBox;
    ckFinalEDDOther: TCheckBox;
    ckFinalEDDUnknown: TCheckBox;
    ckFinalEDDECD: TCheckBox;
    gbPreg: TGroupBox;
    Label16: TLabel;
    spnPrePregWt: TSpinEdit;
    Label17: TLabel;
    procedure fVitalsControlChange(Sender: TObject);
    // EDD Calculator Page -----------------------------------------------------
    procedure dtLMPExit(Sender: TObject);
    procedure dtECDExit(Sender: TObject);
    procedure dtUltraExit(Sender: TObject);
    procedure spnWeekUltraChange(Sender: TObject);
    procedure spnDayUltraChange(Sender: TObject);
    procedure dtEmbryoExit(Sender: TObject);
    procedure spnTransferDayChange(Sender: TObject);
    procedure dtOtherExit(Sender: TObject);
    procedure spnWeekOtherChange(Sender: TObject);
    procedure spnDayOtherChange(Sender: TObject);
    procedure lblOtherChange(Sender: TObject);
    procedure lblOtherMouseEnter(Sender: TObject);
    procedure lblOtherExit(Sender: TObject);
    procedure dtEDDUnknownExit(Sender: TObject);
    procedure IsFinalEDDClick(Sender: TObject);
    procedure PageEDDResize(Sender: TObject);
    procedure PageEDDShow(Sender: TObject);
    // Menstrual Page ----------------------------------------------------------
    procedure SpinCheck(Sender: TObject);
    procedure edtLMPExit(Sender: TObject);
    procedure ToggleCheckBoxes(Sender: TObject);
  private
    FocusControlText: TObjectList<TSayOnFocus>;
    TabSeen: array of Boolean;
    procedure BuildSayOnFocus(wControl: TWinControl; txt: string);
    procedure LMPChangeEvents(Switch: Boolean);
    procedure UpdateLMP;
    function CalEDD(EventType: TEventType): string;
    function CalGestationalAge(EventType: TEventType; FromDate,ToDate: TFMDateTime): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save;
    procedure GetPatientVitals(var oText: TStringList);
    procedure GetVitalsNote(var oText: TStringList);
    procedure GetEDDNote(var oText: TStringList);
    procedure GetLMPNote(var oText: TStringList);
    procedure GetCompleteNote(var oText: TStringList);
    function GetTextforFocus(Value: TWinControl): string;
  end;

implementation

{$R *.dfm}

uses
  uBase, uCommon, uExtndComBroker;

const
  FMT_DATETIME = 'mm/dd/yyyy';

   // LMP ****
procedure TDDCSVitals.dtLMPExit(Sender: TObject);
begin
  if AnsiCompareText(dtLMP.Text, 'Today') = 0 then
    dtLMP.Text := DateToStr(Today);

  ckFinalEDDLMP.Checked := False;
  edtEDDLMP.Text := CalEDD(evLMP);

  if ((edtLMP.IsValid) and (edtLMP.FMDateTime <> dtLMP.FMDateTime)) then
  begin
    LMPChangeEvents(False);
    edtLMP.FMDateTime := dtLMP.FMDateTime;
    UpdateLMP;
    LMPChangeEvents(True);
  end;
end;

procedure TDDCSVitals.LMPChangeEvents(Switch: Boolean);
begin
  if not Switch then
  begin
    dtLMP.OnExit := nil;
    edtLMP.OnExit := nil;
  end else
  begin
    edtLMP.OnExit := edtLMPExit;
    dtLMP.OnExit := dtLMPExit;
  end;
end;

// ECD ****
procedure TDDCSVitals.dtECDExit(Sender: TObject);
begin
  if AnsiCompareText(dtECD.Text, 'Today') = 0 then
    dtECD.Text := DateToStr(Today);

  ckFinalEDDECD.Checked := False;
  edtEDDECD.Text := CalEDD(evECD);
end;

   // Ultrasound ****
procedure TDDCSVitals.dtUltraExit(Sender: TObject);
begin
  if AnsiCompareText(dtUltra.Text, 'Today') = 0 then
    dtUltra.Text := DateToStr(Today);

  ckFinalEDDUltra.Checked := False;
  edtEDDUltra.Text := CalEDD(evUlt);
end;

procedure TDDCSVitals.spnWeekUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnWeekUltra.Value < 0 then
    spnWeekUltra.Value := 0;

  dtUltraExit(Sender);
end;

procedure TDDCSVitals.spnDayUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnDayUltra.Value < 0 then
    spnDayUltra.Value := 0;

  if spnDayUltra.Value > 6 then
  begin
    spnDayUltra.OnChange := nil;
    spnWeekUltra.OnChange := nil;
    spnDayUltra.Value := 0;
    spnWeekUltra.Value := spnWeekUltra.Value + 1;
    spnDayUltra.OnChange := spnDayUltraChange;
    spnWeekUltra.OnChange := spnWeekUltraChange;
  end;

  dtUltraExit(Sender);
end;

   // Embryo Transfer ****
procedure TDDCSVitals.dtEmbryoExit(Sender: TObject);
begin
  if AnsiCompareText(dtEmbryo.Text, 'Today') = 0 then
    dtEmbryo.Text := DateToStr(Today);

  ckFinalEDDEmbryo.Checked := False;
  edtEDDEmbryo.Text := CalEDD(evEmT);
end;

procedure TDDCSVitals.spnTransferDayChange(Sender: TObject);
begin
  ckFinalEDDEmbryo.Checked := False;
  dtEmbryoExit(Sender);
end;

   // Other ****
procedure TDDCSVitals.dtOtherExit(Sender: TObject);
begin
  if AnsiCompareText(dtOther.Text, 'Today') = 0 then
    dtOther.Text := DateToStr(Today);

  ckFinalEDDOther.Checked := False;
  edtEDDOther.Text := CalEDD(evOth);
end;

procedure TDDCSVitals.spnWeekOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnWeekOther.Value < 0 then
    spnWeekOther.Value := 0;

  dtOtherExit(Sender);
end;

procedure TDDCSVitals.spnDayOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnDayOther.Value < 0 then
    spnDayOther.Value := 0;

  if spnDayOther.Value > 6 then
  begin
    spnDayOther.OnChange := nil;
    spnWeekOther.OnChange := nil;
    spnDayOther.Value := 0;
    spnWeekOther.Value := spnWeekOther.Value + 1;
    spnDayOther.OnChange := spnDayOtherChange;
    spnWeekOther.OnChange := spnWeekOtherChange;
  end;

  dtOtherExit(Sender);
end;

procedure TDDCSVitals.lblOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;
end;

procedure TDDCSVitals.lblOtherMouseEnter(Sender: TObject);
begin
  if lblOther.Text = 'Other Criteria' then
  begin
    lblOther.Text := '';
    lblOther.SetFocus;
  end;
end;

procedure TDDCSVitals.lblOtherExit(Sender: TObject);
begin
  if lblOther.Text = '' then
    lblOther.Text := 'Other Criteria';
end;

   // Unknown ****
procedure TDDCSVitals.dtEDDUnknownExit(Sender: TObject);
begin
  ckFinalEDDUnknown.Checked := False;
end;

   // Final --------------------------------------------------------------------

procedure TDDCSVitals.IsFinalEDDClick(Sender: TObject);
var
  ck: TCheckBox;
  GA,GAgeWeeks: Integer;

  procedure StopChecked(ck: TCheckbox);
  begin
    ckFinalEDDLMP.OnClick     := nil;
    if ck <> ckFinalEDDLMP then
      ckFinalEDDLMP.Checked := False;
    ckFinalEDDECD.OnClick     := nil;
    if ck <> ckFinalEDDECD then
      ckFinalEDDECD.Checked := False;
    ckFinalEDDUltra.OnClick   := nil;
    if ck <> ckFinalEDDUltra then
      ckFinalEDDUltra.Checked := False;
    ckFinalEDDEmbryo.OnClick  := nil;
    if ck <> ckFinalEDDEmbryo then
      ckFinalEDDEmbryo.Checked := False;
    ckFinalEDDOther.OnClick   := nil;
    if ck <> ckFinalEDDOther then
      ckFinalEDDOther.Checked := False;
    ckFinalEDDUnknown.OnClick := nil;
    if ck <> ckFinalEDDUnknown then
      ckFinalEDDUnknown.Checked := False;
  end;

  procedure StartChecked;
  begin
    ckFinalEDDLMP.OnClick     := IsFinalEDDClick;
    ckFinalEDDECD.OnClick     := IsFinalEDDClick;
    ckFinalEDDUltra.OnClick   := IsFinalEDDClick;
    ckFinalEDDEmbryo.OnClick  := IsFinalEDDClick;
    ckFinalEDDOther.OnClick   := IsFinalEDDClick;
    ckFinalEDDUnknown.OnClick := IsFinalEDDClick;
  end;

  procedure UpdateGestation(EventType: TEventType; EDD,EventDate: TFMDateTime);
  var
    GA: string;
  begin
    // EDD Gestational Age (or Current)
    if EDD > Today then
      GA := CalGestationalAge(EventType, EventDate, DateTimeToFMDateTime(Now))
    else
      GA := CalGestationalAge(EventType, EventDate, EDD);

    edtEDDGA.Text := Piece(GA,U,1) + 'w ' + Piece(GA,U,2) + 'd';

    // Current Gestational Age (or after EDD)
    GA := CalGestationalAge(EventType, EventDate, DateTimeToFMDateTime(Now));
    edtFinalGA.Text := Piece(GA,U,1) + 'w ' + Piece(GA,U,2) + 'd';
  end;

begin
  if not (Sender is TCheckBox) then
    Exit;
  ck := TCheckBox(Sender);
  if not ck.Checked then
    Exit;

  edtFinalGA.Text    := '';
  edtCurrentEDD.Text := '';
  edtEDDGA.Text      := '';

  StopChecked(ck);
  try
    case ck.Tag of
      1: begin                                                                  // LMP
           dtLMPExit(dtLMP);

           if edtEDDLMP.IsValid then
           begin
             edtCurrentEDD.Text := edtEDDLMP.Text;
             UpdateGestation(evLMP, edtEDDLMP.FMDateTime, dtLMP.FMDateTime);
             TCheckBox(Sender).Checked := True;
           end;
         end;
      2: begin                                                                  // ECD
           dtECDExit(dtECD);

           if edtEDDECD.IsValid then
           begin
             edtCurrentEDD.Text := edtEDDECD.Text;
             UpdateGestation(evECD, edtEDDECD.FMDateTime, dtECD.FMDateTime);
             TCheckBox(Sender).Checked := True;
           end;
         end;
      3: begin                                                                  // Ultrasound
           dtUltraExit(dtUltra);

           if edtEDDUltra.IsValid then
           begin
             edtCurrentEDD.Text := edtEDDUltra.Text;
             UpdateGestation(evUlt, edtEDDUltra.FMDateTime, FMDateTimeOffsetBy(dtUltra.FMDateTime,
                                                            -((spnWeekUltra.Value * 7) + spnDayUltra.Value)));
             TCheckBox(Sender).Checked := True;
           end;
         end;
      4: begin                                                                  // Embryo Transfer
           dtEmbryoExit(dtEmbryo);

           if edtEDDEmbryo.IsValid then
           begin
             edtCurrentEDD.Text := edtEDDEmbryo.Text;
             UpdateGestation(evEmT, edtEDDEmbryo.FMDateTime, dtEmbryo.FMDateTime);
             TCheckBox(Sender).Checked := True;
           end;
         end;
      5: begin                                                                  // Other
           dtOtherExit(dtOther);

           if lblOther.Text = 'Other Criteria' then
           begin
             ckFinalEDDOther.Checked := False;
             ShowMsg('"Other Criteria" must be defined.');
           end else if edtEDDOther.IsValid then
           begin
             edtCurrentEDD.Text := edtEDDOther.Text;
             UpdateGestation(evOth, edtEDDOther.FMDateTime, FMDateTimeOffsetBy(dtOther.FMDateTime,
                                                            -((spnWeekOther.Value * 7) + spnDayOther.Value)));
             TCheckBox(Sender).Checked := True;
           end;
         end;
      6: begin                                                                  // Unknown
           if dtEDDUnknown.IsValid then
           begin
             edtCurrentEDD.Text := dtEDDUnknown.Text;
             if FMDateTimeToDateTime(dtEDDUnknown.FMDateTime) > Today then
             begin
               GA := 279 - DaysBetween(FMDateTimeToDateTime(dtEDDUnknown.FMDateTime), Now);
               GAgeWeeks := Trunc(GA div 7);
               edtEDDGA.Text := IntToStr(GAgeWeeks) + 'w ' + IntToStr(GA - Trunc(GAgeWeeks * 7)) + 'd';
               edtFinalGA.Text := edtEDDGA.Text;
             end;
           end else
           begin
             TCheckBox(Sender).Checked := False;
             ShowMsg('The estimated date of delivery must be defined.');
           end;
         end;
    end;
  finally
    StartChecked;
  end;
end;

   // --------------------------------------------------------------------------

procedure TDDCSVitals.PageEDDResize(Sender: TObject);
var
  I: Integer;
begin
  I := lblOther.Left;
  lblLMP.Left     := I;
  lblECD.Left     := I;
  lblUltra.Left   := I;
  lblUnknown.Left := I;
end;

procedure TDDCSVitals.PageEDDShow(Sender: TObject);
begin
  PageEDDResize(Sender);
end;

   // Menstrual Page -----------------------------------------------------------

procedure TDDCSVitals.SpinCheck(Sender: TObject);
begin
  if TSpinEdit(Sender).Value < 0 then
    TSpinEdit(Sender).Value := 0;
end;

procedure TDDCSVitals.edtLMPExit(Sender: TObject);
begin
  if ((edtLMP.IsValid) and (edtLMP.FMDateTime <> dtLMP.FMDateTime)) then
  begin
    LMPChangeEvents(False);
    dtLMP.FMDateTime := edtLMP.FMDateTime;
    dtLMPExit(edtLMP);
    LMPChangeEvents(True);
  end;
end;

procedure TDDCSVitals.ToggleCheckBoxes(Sender: TObject);

  Procedure ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
  begin
    if cb1.Checked then
      cb2.Checked := False;
  end;

begin
  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = True) then
  case (Sender as TCheckBox).Tag of
     1: ToggleCB(ckMensesYes, ckMensesNo);
     2: ToggleCB(ckMensesNo, ckMensesYes);
     3: ToggleCB(ckAmountYes, ckAmountNo);
     4: ToggleCB(ckAmountNo, ckAmountYes);
     5: ToggleCB(ckContraceptionYes, ckContraceptionNo);
     6: ToggleCB(ckContraceptionNo, ckContraceptionYes);
     7: ToggleCB(ckDurationYes, ckDurationNo);
     8: ToggleCB(ckDurationNo, ckDurationYes);
     9: ToggleCB(ckBirthPillsYes, ckBirthPillsNo);
    10: ToggleCB(ckBirthPillsNo, ckBirthPillsYes);
    11: ToggleCB(ckMonthlyYes, ckMonthlyNo);
    12: ToggleCB(ckMonthlyNo, ckMonthlyYes);
  end;
end;

// Private ---------------------------------------------------------------------

procedure TDDCSVitals.UpdateLMP;
begin
  ckLMPQualifier.Checked := False;
  ckMensesYes.Checked := False;
  ckMensesNo.Checked := False;
  ckMonthlyYes.Checked := False;
  ckMonthlyNo.Checked := False;
  spnFreq.Value := 0;
  spnMenarche.Value := 0;
  edthcg.Text := '';
  ckAmountYes.Checked := False;
  ckAmountNo.Checked := False;
  ckDurationYes.Checked := False;
  ckDurationNo.Checked := False;
  ckContraceptionYes.Checked := False;
  ckContraceptionNo.Checked := False;
  ckBirthPillsYes.Checked := False;
  ckBirthPillsNo.Checked := False;
  edtContraceptionType.ItemIndex := -1;
  memLMP.Clear;
end;

   // Calculate Estimated Delivery Date ----------------------------------------
function TDDCSVitals.CalEDD(EventType: TEventType): string;
   //   1. LMP
   //       EDD by LMP is calculated by adding 280 days (40 weeks) to the first day of
   //       the last menstrual period.
   //   2. ECD
   //       EDD by Estimated Conception date by adding 266 days to the date of conception
   //       which is 2 weeks in by the date of conception
   //   3. Ultrasound
   //       EDD by Ultrasound is taking the Ultrasound date and substracting the weeks/day
   //       to get the start
   //   4. Embryo Transfer
   //       Date of 3-day embryo transfer is the date + 264
   //       Date of 5-day embryo (blast) transfer is the date + 261
   //   5. Other
   //   6. Unknown
begin
  Result := '';

  case EventType of
    evLMP: Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(dtLMP.FMDateTime, 280));
    evECD: Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(dtECD.FMDateTime, 266));
    evUlt: Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(FMDateTimeOffsetBy(dtUltra.FMDateTime,
                                                    - ((spnWeekUltra.Value * 7) + spnDayUltra.Value)), 280));
    evEmT: begin
             if cbTransferDay.Text = '3' then
               Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(dtEmbryo.FMDateTime, 263))
             else if cbTransferDay.Text = '5' then
               Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(dtEmbryo.FMDateTime, 261))
             else
               Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(dtEmbryo.FMDateTime, 262));
           end;
    evOth: Result := FormatFMDateTime('MM/DD/YYYY', FMDateTimeOffsetBy(FMDateTimeOffsetBy(dtOther.FMDateTime,
                                                    - ((spnWeekOther.Value * 7) + spnDayOther.Value)), 280));
    evUkn: Result := FormatFMDateTime('MM/DD/YYYY', dtEDDUnknown.FMDateTime);
  end;
end;

   // Gestational Age ----------------------------------------------------------// weeks^days
function TDDCSVitals.CalGestationalAge(EventType: TEventType; FromDate,ToDate: TFMDateTime): string;
var
  GAgeDays,GAgeWeeks: Integer;
  tDate,fDate: TDateTime;
begin
  Result := '0^0';

  tDate := FMDateTimeToDateTime(ToDate);
  fDate := FMDateTimeToDateTime(FromDate);

  case EventType of
    evLMP: GAgeDays := DaysBetween(tDate, fDate);
    evECD: GAgeDays := DaysBetween(tDate, fDate) + 14;
    evUlt: GAgeDays := DaysBetween(tDate, fDate);
    evEmT: begin
             if cbTransferDay.Text = '3' then
               GAgeDays := DaysBetween(tDate, fDate) + 17
             else if cbTransferday.Text = '5' then
               GAgeDays := DaysBetween(tDate, fDate) + 19
             else
               GAgeDays := DaysBetween(tDate, fDate) + 18;
           end;
    evOth: GAgeDays := DaysBetween(tDate, fDate);
    else GAgeDays := 0;
  end;

  GAgeWeeks := Trunc(GAgeDays div 7);
  Result := IntToStr(GAgeWeeks) + U + IntToStr(GAgeDays - Trunc(GAgeWeeks * 7));
end;

// -----------------------------------------------------------------------------

procedure TDDCSVitals.fVitalsControlChange(Sender: TObject);
var
  DDCSF: TDDCSForm;
begin
  inherited;
  
  if csDesigning in ComponentState then
    Exit;

  if fVitalsControl.ActivePage.TabVisible then
    if ((Parent <> nil) and (Parent.Parent <> nil) and (Parent.Parent is TDDCSForm)) then
    begin
      DDCSF := TDDCSForm(Parent.Parent);
      if DDCSF.ScreenReader <> nil then
        DDCSF.ScreenReader.SayString('Currently on the ' + fVitalsControl.ActivePage.Caption +
                               ' tab of the vitals page. To navigate between vitals tabs' +
                               ' use the up and down arrows.', False);
    end;
end;

// Public ----------------------------------------------------------------------

procedure TDDCSVitals.BuildSayOnFocus(wControl: TWinControl; txt: string);
var
  rText: TSayOnFocus;
begin
  rText := TSayOnFocus.Create;
  rText.FOwningObject := wControl;
  rText.Text := txt;
  FocusControlText.Add(rText);
end;

constructor TDDCSVitals.Create(AOwner: TComponent);
var
  sl: TStringList;
  I: Integer;
  str: string;

  procedure DisableButton(fDate: TORDateBox);
  var
    I: Integer;
    bt: TORDateButton;
  begin
    for I := 0 to fDate.ControlCount - 1 do
      if fDate.Controls[I] is TORDateButton then
      begin
        bt := TORDateButton(fDate.Controls[I]);
        bt.Enabled := False;
        bt.onClick := nil;
        Break;
      end;
  end;

begin
  inherited;

  if csDesigning in ComponentState then
    Exit;

  SetLength(TabSeen, fVitalsControl.PageCount);

  cbTransferDay.ItemIndex := 1;

  edtCurrentEDD.Format  := FMT_DATETIME;
  DisableButton(edtCurrentEDD);
  dtLMP.Format          := FMT_DATETIME;
  edtEDDLMP.Format      := FMT_DATETIME;
  DisableButton(edtEDDLMP);
  dtECD.Format          := FMT_DATETIME;
  edtEDDECD.Format      := FMT_DATETIME;
  DisableButton(edtEDDECD);
  dtUltra.Format        := FMT_DATETIME;
  edtEDDUltra.Format    := FMT_DATETIME;
  DisableButton(edtEDDUltra);
  dtEmbryo.Format       := FMT_DATETIME;
  edtEDDEmbryo.Format   := FMT_DATETIME;
  DisableButton(edtEDDEmbryo);
  dtOther.Format        := FMT_DATETIME;
  edtEDDOther.Format    := FMT_DATETIME;
  DisableButton(edtEDDOther);
  dtEDDUnknown.Format   := FMT_DATETIME;
  edtLMP.Format         := FMT_DATETIME;
  edthcg.Format         := FMT_DATETIME;

  sl := TStringList.Create;
  try
    try
      if RPCBrokerV = nil then
        Exit;

      GetPatientVitals(sl);
      if sl.Count > 0 then
        if sl[0] <> '-1' then
        begin
          for I := 0 to sl.Count - 1 do
          begin
            if Piece(sl[I],U,2) = 'T' then                                                          // Temperature
            begin
              FTemps.Text := Piece(sl[I],U,3);
              FTempe.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), tuFahrenheit, tuCelsius));
              FTempdt.Caption := Piece(sl[I],U,4);
            end
            else if Piece(sl[I],U,2) = 'P' then                                                     // Pulse
            begin
              FPulses.Text := Piece(sl[I],U,3);
              FPulsedt.Caption := Piece(sl[I],U,4);
            end                                                                                     // Respiration
            else if Piece(sl[I],U,2) = 'R' then
            begin
              FResps.Text := Piece(sl[I],U,3);
              FRespdt.Caption := Piece(sl[I],U,4);
            end
            else if Piece(sl[I],U,2) = 'BP' then                                                    // Blood Pressure
            begin
              // Populate Systolic (top) and Diastolic (bottom) from BP
              FSystolics.Text := Piece(Piece(sl[I],U,3),'/',1);
              FDiastolics.Text := Piece(Piece(sl[I],U,3),'/',2);
              FSystolicdt.Caption := Piece(sl[I],U,4);
              FDiastolicdt.Caption := Piece(sl[I],U,4);
            end
            else if Piece(sl[I],U,2) = 'HT' then                                                    // Height
            begin
              FHeights.Text := Piece(sl[I],U,3);
              FHeighte.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), duInches, duCentimeters));
              FHeightdt.Caption := Piece(sl[I],U,4);
            end
            else if Piece(sl[I],U,2) = 'WT' then                                                    // Weight
            begin
              FWeights.Text := Piece(sl[I],U,3);
              FWeighte.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), muPounds, muKilograms));
              FWeightdt.Caption := Piece(sl[I],U,4);
            end
            else if Piece(sl[I],U,2) = 'PN' then                                                    // Pain
            begin
              FPains.Text := Piece(sl[I],U,3);
              FPaindt.Caption := Piece(sl[I],U,4);
            end
            // if Piece(sl[I],U,2) = 'POX'                                                          // Pulse Oximetry
            // if Piece(sl[I],U,2) = 'CVP' then                                                     // Central Venous Pressure
            // if Piece(sl[I],U,2) = 'CG' then                                                      // Circumference/Girth
            else if Piece(sl[I],U,2) = 'PREPREGWT' then                                             // Pre Pregnancy Weight
              spnPrePregWt.Value := StrToIntDef(Piece(sl[I],U,3),0)
            else if Piece(sl[I],U,2) = 'BMI' then                                                   // Body Mass Index
              FBMIValue.Caption := Piece(sl[I],U,3)
            else if Piece(sl[I],U,2) = 'AGE' then                                                   // Age
              FAgeValue.Caption := Piece(sl[I],U,3)
            else if Piece(sl[I],U,2) = 'SEX' then                                                   // Sex
              FSexValue.Caption := Piece(sl[I],U,3);
          end;
		    end;

      sl.Clear;
      if UpdateContext(MENU_CONTEXT) then
        tCallV(sl, 'DSIO DDCS VITALS LMP', [RPCBrokerV.Patient.DFN, RPCBrokerV.DDCSInterface]);

      // (0)LMP^MENSES^FREQUENCY^MENARCHE^HCG^AMOUNT^DURATION^ON_CONTRACEPTION^QUALIFIER^
      //    MENSES_MONTHLY^BIRTH_PILLS_CONCEPTION
      // (#)C1^^<LIST of COMMENTS>
      // (#)C2^^<LIST of CONTRACEPTION>

      if ((sl.Count > 0) and (sl[0] <> '-1')) then
      begin
        // LMP
        str := Piece(sl[0],U,1);
        if str <> '' then
        begin
          edtLMP.Text := str;
          dtLMP.Text := str;
          dtLMPExit(dtLMP);
        end;

        // Menses
        str := Piece(sl[0],U,2);
        if str = 'N' then
          ckMensesYes.Checked := True
        else if str = 'A' then
          ckMensesNo.Checked := True;

        // Frequency
        spnFreq.Value := StrToIntDef(Piece(sl[0],U,3), 0);

        // Menarche
        spnMenarche.Value := StrToIntDef(Piece(sl[0],U,4), 0);

        // HCG
        str := Piece(sl[0],U,5);
        if str <> '' then
          edthcg.Text := str;

        // Amount
        str := Piece(sl[0],U,6);
        if str = 'N' then
          ckAmountYes.Checked := True
        else if str = 'A' then
          ckAmountNo.Checked := True;

        // Duration
        str := Piece(sl[0],U,7);
        if str = 'N' then
          ckDurationYes.Checked := True
        else if str = 'A' then
          ckDurationNo.Checked := True;

        // On Contraception
        str := Piece(sl[0],U,8);
        if str = 'Y' then
          ckContraceptionYes.Checked := True
        else if str = 'N' then
          ckContraceptionNo.Checked := True;

        // Qualifier
        if Piece(sl[0],U,9) = 'A' then
          ckLMPQualifier.Checked := True;

        // Menses Monthly
        str := Piece(sl[0],U,10);
        if str = 'Y' then
          ckMonthlyYes.Checked := True
        else if str = 'N' then
          ckMonthlyNo.Checked := True;

        // On Birth Control Pills on Conception
        str := Piece(sl[0],U,11);
        if str = 'Y' then
          ckBirthPillsYes.Checked := True
        else if str = 'N' then
          ckBirthPillsNo.Checked := True;

        // Contraception Type
        if sl.Count > 1 then
          for I := 1 to sl.Count - 1 do
          begin
            if Piece(sl[I],U,1) = 'C1' then
              memLMP.Lines.Add(Piece(sl[I],U,3));
            if Piece(sl[I],U,1) = 'C2' then
            begin
              edtContraceptionType.Items.Add(Piece(sl[I],U,3));

              if AnsiContainsText(Piece(sl[I],U,2), 'TRUE') then
                edtContraceptionType.ItemIndex := edtContraceptionType.Items.Count - 1;
            end;
          end;
      end;
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    sl.Free;

    // 508 support -----------------------------------------------------------
    FocusControlText := TObjectList<TSayOnFocus>.Create(True);
    BuildSayOnFocus(         FAgeValue, 'Patient age in years');
    BuildSayOnFocus(         FSexValue, 'Patient sex');
    BuildSayOnFocus(         FBMIValue, 'Patient B M I');
    BuildSayOnFocus(            FTemps, 'Temperature in Fahrenheit reported on '     + FTempdt.Caption);
    BuildSayOnFocus(            FTempe, 'Temperature in Celsius reported on '        + FTempdt.Caption);
    BuildSayOnFocus(          FHeights, 'Height in Inches reported on '            + FHeightdt.Caption);
    BuildSayOnFocus(          FHeighte, 'Height in Centimeters reported on '       + FHeightdt.Caption);
    BuildSayOnFocus(          FWeights, 'Weight in Pounds reported on '            + FWeightdt.Caption);
    BuildSayOnFocus(          FWeighte, 'Weight in Kilograms reported on '         + FWeightdt.Caption);
    BuildSayOnFocus(           FPulses, 'Pulse reported on '                        + FPulsedt.Caption);
    BuildSayOnFocus(            FResps, 'Respiration reported on '                   + FRespdt.Caption);
    BuildSayOnFocus(            FPains, 'Level of Pain reported on '                 + FPaindt.Caption);
    BuildSayOnFocus(        FSystolics, 'Blood Pressure Systolic reported on '   + FSystolicdt.Caption);
    BuildSayOnFocus(       FDiastolics, 'Blood Pressure Diastolic reported on ' + FDiastolicdt.Caption);
    BuildSayOnFocus(      spnPrePregWt, 'Pre Pregnancy Weight in pounds');

    BuildSayOnFocus(     edtCurrentEDD, 'Final Estimated Delivery Date');
    BuildSayOnFocus(          edtEDDGA, 'Gestational Age');
    BuildSayOnFocus(         edtEDDLMP, 'Estimated Delivery Date');
    BuildSayOnFocus(         edtEDDECD, 'Estimated Delivery Date');
    BuildSayOnFocus(      spnWeekUltra, 'Ultrasound Gestational Age in Weeks');
    BuildSayOnFocus(       spnDayUltra, 'Ultrasound Gestational Age in Days');
    BuildSayOnFocus(       edtEDDUltra, 'Estimated Delivery Date');
    BuildSayOnFocus(     cbTransferDay, 'Embryo Transfer Blastocyst Transfer Day');
    BuildSayOnFocus(      edtEDDEmbryo, 'Estimated Delivery Date Embryo Transfer');
    BuildSayOnFocus(      dtEDDUnknown, 'Estimated Delivery Date');
    BuildSayOnFocus(     ckFinalEDDLMP, 'Last Menstrual Period Final Estimated Delivery Date');
    BuildSayOnFocus(     ckFinalEDDECD, 'Estimated Conception Date Final Estimated Delivery Date');
    BuildSayOnFocus(   ckFinalEDDUltra, 'Ultrasound Final Estimated Delivery Date');
    BuildSayOnFocus(  ckFinalEDDEmbryo, 'Embryo Transfer Final Estimated Delivery Date');
    BuildSayOnFocus( ckFinalEDDUnknown, 'Unknown Final Estimated Delivery Date');
    BuildSayOnFocus(      spnWeekOther, 'Other Criteria Gestational Age in Weeks');
    BuildSayOnFocus(       spnDayOther, 'Other Criteria Gestational Age in Days');
    BuildSayOnFocus(       edtEDDOther, 'Estimated Delivery Date Other Criteria');
    BuildSayOnFocus(   ckFinalEDDOther, 'Other Criteria Final Estimated Delivery Date');

    BuildSayOnFocus(    ckLMPQualifier, 'Last Menstrual Period Approximation');
    BuildSayOnFocus(           spnFreq, 'Duration of Flow Frequency in days');
    BuildSayOnFocus(       spnMenarche, 'Menarche in age of onset');
    BuildSayOnFocus(      ckMonthlyYes, 'Menses Monthly');
    BuildSayOnFocus(       ckMonthlyNo, 'Menses Monthly');
    BuildSayOnFocus(       ckAmountYes, 'Menses Amount');
    BuildSayOnFocus(        ckAmountNo, 'Menses Amount');
    BuildSayOnFocus(     ckDurationYes, 'Menses Duration');
    BuildSayOnFocus(      ckDurationNo, 'Menses Duration');
    BuildSayOnFocus(ckContraceptionYes, 'On Contraception');
    BuildSayOnFocus( ckContraceptionNo, 'On Contraception');
    BuildSayOnFocus(   ckBirthPillsYes, 'On Birth Control Pills at Conception');
    BuildSayOnFocus(    ckBirthPillsNo, 'On Birth Control Pills at Conception');
    // 508 support -----------------------------------------------------------
  end;

  if AnsiCompareText(FSexValue.Caption, 'MALE') = 0 then
  begin
    gbPreg.Visible := False;
    fVitalsControl.Pages[1].TabVisible := False;
    fVitalsControl.Pages[2].TabVisible := False;
  end;

  fVitalsControl.ActivePageIndex := 0;
end;

destructor TDDCSVitals.Destroy;
begin
  if Assigned(FocusControlText) then
    FocusControlText.Free;
  SetLength(TabSeen, 0);

  inherited;
end;

procedure TDDCSVitals.Save;
var
  sl: TStringList;
  qual: string;

  function SetofCodes(cb1,cb2: TCheckBox): string;
  begin
    if cb1.Checked then
      Result := string(cb1.Caption).Chars[0]
    else if cb2.Checked then
      Result := string(cb2.Caption).Chars[0]
    else
      Result := '';
  end;

  function ckBool(cb: TCheckBox): string;
  begin
    if cb.Checked then
      Result := '1'
    else
      Result := '0';
  end;

begin
  sl := TStringList.Create;
  try
    // VITALS
    // VIT^PRE_PREGNANCY_WEIGHT

    sl.Add('VIT^' + spnPrePregWt.Text);

    // EDD^CRITERIA^EVENT_DATE^GESTATIONAL_AGE^EDD
    // EDD^CRITERIA|OTHER-DISPLAY-NAME^EVENT_DATE^GESTATIONAL_AGE^EDD

    if ckFinalEDDLMP.Checked then
      sl.Add('EDD^LMP^' + FloatToStr(dtLMP.FMDateTime) + '^^' + edtCurrentEDD.Text)
    else if ckFinalEDDECD.Checked then
      sl.Add('EDD^ECD^' + FloatToStr(dtECD.FMDateTime) + '^^' + edtCurrentEDD.Text)
    else if ckFinalEDDUltra.Checked then
      sl.Add('EDD^ULT^' + FloatToStr(dtUltra.FMDateTime) + U + spnWeekUltra.Text
             + 'w' + spnDayUltra.Text + 'd' + U + edtCurrentEDD.Text)
    else if ckFinalEDDEmbryo.Checked then
      sl.Add('EDD^EMB^' + FloatToStr(dtEmbryo.FMDateTime) + '^^' + edtCurrentEDD.Text)
    else if ckFinalEDDOther.Checked then
      sl.Add('EDD^OTH|' + lblOther.Text + U + FloatToStr(dtOther.FMDateTime)  + U
             + spnWeekOther.Text + 'w' + spnDayOther.Text + 'd' + U + edtCurrentEDD.Text)
    else if ckFinalEDDUnknown.Checked then
      sl.Add('EDD^EDD^' + '^^' + edtCurrentEDD.Text);

    // LMP
    if ckLMPQualifier.Checked then
      qual := 'A'
    else
      qual := '';

    // LMP^MENSES^FREQUENCY^AMOUNT^DURATION^ON_CONTRACEPTION^RECENT_CONTRACEPTIVE^
    // hCG+^MENARCHE^QUALIFIER^MENSES_MONTHLY^BIRTH_PILLS_CONCEPTION

    sl.Add('LMP^' + edtLMP.Text + U + SetofCodes(ckMensesYes,ckMensesNo) + U + spnFreq.Text + U +
           SetofCodes(ckAmountYes,ckAmountNo) + U + SetofCodes(ckDurationYes,ckDurationNo)  + U +
           SetofCodes(ckContraceptionYes,ckContraceptionNo) + U + edtContraceptionType.Text + U +
           edthcg.Text + U + spnMenarche.Text + U + qual +                                    U +
           SetofCodes(ckMonthlyYes,ckMonthlyNo) + U + SetofCodes(ckBirthPillsYes,ckBirthPillsNo));

    // COM^TEXT

    if memLMP.Lines.Count > 0 then
      sl.Add('COM^' + memLMP.Lines.Text);

    try
      if UpdateContext(MENU_CONTEXT) then
        sCallV('DSIO DDCS ORQQVI VITALS SAVE', [RPCBrokerV.ControlObject, RPCBrokerV.TIUNote.IEN, sl])
    except
    end;
  finally
    sl.Free;
  end;
end;

// Array of vital ien^vital type^rate/value^date/time taken
procedure TDDCSVitals.GetPatientVitals(var oText: TStringList);
begin
  oText.Clear;
  try
    if RPCBrokerV <> nil then
    begin
      if UpdateContext(MENU_CONTEXT) then
        tCallV(oText, 'DSIO DDCS ORQQVI VITALS', [RPCBrokerV.Patient.DFN]);
    end;
  except
  end;
end;

procedure TDDCSVitals.GetVitalsNote(var oText: TStringList);

  function strLengthen(str: string): string;
  begin
    Result := str;
    while Length(Result) < 50 do
      Result := Result + ' ';
  end;

begin
  oText.Clear;

  oText.Add('  Sex:            ' + FSexValue.Caption);
  oText.Add('  Age:            ' + FAgeValue.Caption);
  oText.Add('  BMI:            ' + FBMIValue.Caption);
  oText.Add('');

  oText.Add('VITALS:');
  if FTemps.Text <> '' then
    oText.Add(strlengthen('  Temperature:          ' + FTemps.Text + ' F (' + FTempe.Text + ' C)') + FTempdt.Caption);
  if FPulses.Text <> '' then
    oText.Add(strlengthen('  Pulse:                ' + FPulses.Text) + FPulsedt.Caption);
  if FResps.Text <> '' then
    oText.Add(strlengthen('  Respiration:          ' + FResps.Text) + FRespdt.Caption);
  if FSystolics.Text <> '' then
    oText.Add(strlengthen('  Systolic:             ' + FSystolics.Text) + FSystolicdt.Caption);
  if FDiastolics.Text <> '' then
    oText.Add(strlengthen('  Diastolic:            ' + FDiastolics.Text) + FDiastolicdt.Caption);
  if FHeights.Text <> '' then
    oText.Add(strlengthen('  Height:               ' + FHeights.Text + ' in (' + FHeighte.Text + ' cm)') + FHeightdt.Caption);
  if FWeights.Text <> '' then
    oText.Add(strlengthen('  Weight:               ' + FWeights.Text + ' lb (' + FWeighte.Text + ' kg)') + FWeightdt.Caption);
  if FPains.Text <> '' then
    oText.Add(strlengthen('  Pain:                 ' + FPains.Text) + FPaindt.Caption);

  if ((spnPrePregWt.Visible) and (spnPrePregWt.Value > 0)) then
  begin
    oText.Add('');
    otext.Add('  Pre-pregnancy Weight: ' + spnPrePregWt.Text + ' lbs');
  end;
end;

procedure TDDCSVitals.GetEDDNote(var oText: TStringList);
begin
  oText.Clear;

  if edtCurrentEDD.Text = '' then
    Exit;

  oText.Add('ESTIMATED DELIVERY DATE:');

  oText.Add('  Final EDD: ' + edtCurrentEDD.Text);
  if edtEDDGA.Text <> '' then
    oText.Add('   Gestational Age for Final EDD: ' + edtEDDGA.Text);
  if edtFinalGA.Text <> '' then
    oText.Add('   Gestational Age Today: ' + edtFinalGA.Text);
  if ckFinalEDDLMP.Checked then
    oText.Add('   The current calculation is based on  a Last Menstrual Period of ' + dtLMP.Text + '.')
  else if ckFinalEDDECD.Checked then
    oText.Add('   The current calculation is based on an Estimated Conception Date of ' + dtECD.Text + '.')
  else if ckFinalEDDUltra.Checked then
    oText.Add('   The current calculation is based on an Ultrasound conducted on ' + dtUltra.Text +
              ' with an estimated gestational age of ' + IntToStr(spnWeekUltra.Value) + ' weeks and ' +
              IntToStr(spnDayUltra.Value) + ' days.')
  else if ckFinalEDDEmbryo.Checked then
    oText.Add('   The current calculation is based on a ' + cbTransferDay.Text + '-day embryo transfer conducted on ' +
              dtEmbryo.Text + '.')
  else if ckFinalEDDOther.Checked then
    oText.Add('   The current calculation is based on an EDD Criteria of ' + lblOther.Text +
              ' with an estimated gestational age of ' + IntToStr(spnWeekOther.Value) + ' weeks and ' +
              IntToStr(spnDayOther.Value) + ' days.')
  else if ckFinalEDDUnknown.Checked then
    oText.Add('   The current methodology for calculation is unknown.');
end;

procedure TDDCSVitals.GetLMPNote(var oText: TStringList);
var
  I: Integer;
begin
  oText.Clear;

  if edtLMP.Text <> ''                 then oText.Add('  LMP: ' + edtLMP.Text);
  if ckLMPQualifier.Checked            then oText.Add('   *Approximate');
  if ckMensesYes.Checked               then oText.Add('  Menses Regular: YES');
  if ckMensesNo.Checked                then oText.Add('  Menses Regular: NO');
  if ckMonthlyYes.Checked              then oText.Add('  Menses Monthly: YES');
  if ckMonthlyNo.Checked               then oText.Add('  Menses Monthly: NO');
  if ckAmountYes.Checked               then oText.Add('  Normal Amount: YES');
  if ckAmountNo.Checked                then oText.Add('  Normal Amount: NO');
  if ckDurationYes.Checked             then oText.Add('  Normal Duration: YES');
  if ckDurationNo.Checked              then oText.Add('  Normal Duration: NO');
  if spnFreq.Value > 0                 then oText.Add('  Duration of Flow Frequency: ' + spnFreq.Text + ' days');
  if spnMenarche.Value > 0             then oText.Add('  Menarche: ' + spnMenarche.Text + ' years old');
  if edthcg.Text <> ''                 then oText.Add('  hCG+: ' + edthcg.Text);
  if ckContraceptionYes.Checked        then oText.Add('  On Contraception: YES');
  if ckContraceptionNo.Checked         then oText.Add('  On Contraception: NO');
  if ckBirthPillsYes.Checked           then oText.Add('  On Birth Control Pills on Conception: YES');
  if ckBirthPillsNo.Checked            then oText.Add('  On Birth Control Pills on Conception: NO');
  if edtContraceptionType.Text <> ''   then
  begin
    oText.Add('  What type(s) of contraception were you using most recently?');
    oText.Add('  ' + edtContraceptionType.Text);
  end;

  if memLMP.Lines.Count > 0 then
  begin
    oText.Add(' Menstrual Narrative:');
    for I := 0 to memLMP.Lines.Count - 1 do
      oText.Add('  ' + memLMP.Lines[I]);
  end;

  if oText.Count > 0 then
    oText.Insert(0, 'MENSTRUAL HISTORY: ');
end;

procedure TDDCSVitals.GetCompleteNote(var oText: TStringList);
var
  sl: TStringList;
begin
  oText.Clear;

  sl := TStringList.Create;
  try
    GetVitalsNote(oText);
    if fVitalsControl.Pages[1].TabVisible then
    begin
      GetEDDNote(sl);
      if sl.Count > 0 then
      begin
        oText.Add('');
        oText.AddStrings(sl);
      end;
      sl.Clear;
    end;
    if fVitalsControl.Pages[2].TabVisible then
    begin
      GetLMPNote(sl);
      if sl.Count > 0 then
      begin
        oText.Add('');
        oText.AddStrings(sl);
      end;
      sl.Clear;
    end;
  finally
    sl.Free;
  end;
end;

function TDDCSVitals.GetTextforFocus(Value: TWinControl): string;
var
  I: Integer;
begin
  Result := '';

  for I := 0 to FocusControlText.Count - 1 do
    if FocusControlText[I].FOwningObject = Value then
    begin
      Result := FocusControlText[I].Text;
      Break;
    end;
end;

end.
