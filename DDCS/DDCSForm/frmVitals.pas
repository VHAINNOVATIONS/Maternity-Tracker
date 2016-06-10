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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Graphics, ORDtTm, ORCtrls;

type
  TSayOnFocus = record
    FOwningObject: TWinControl;
    Text: string[100];
  end;
  PSayOnFocus = ^TSayOnFocus;

  TSayOnFocusList = class(TList)
  private
    function Get(Index: Integer): PSayOnFocus;
  public
    destructor Destroy; override;
    function Add(Value: PSayOnFocus): Integer;
    property Items[Index: Integer]: PSayOnFocus read Get; default;
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
    edtMenarche: TEdit;
    edtFrequency: TEdit;
    edtCurrentEDD: TEdit;
    edtEDDLMP: TEdit;
	  edtEDDECD: TEdit;
   	edtEDDUltra: TEdit;
  	edtEDDEmbryo: TEdit;
    edtEDDOther: TEdit;
    lblOther: TEdit;
    edtFinalGA: TEdit;
	  edtEDDGA: TEdit;
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
    Label8: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    StaticText2: TLabel;
    lblLMP: TLabel;
    lblECD: TLabel;
    lblUltra: TLabel;
    lblUnknown: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    StaticText1: TLabel;
    StaticText3: TLabel;
    StaticText4: TLabel;
    StaticText5: TLabel;
    Panel2: TPanel;
    FAge: TLabel;
    FSex: TLabel;
    FBMI: TLabel;
   	Label14: TLabel;
  	lblEmbryo: TLabel;
  	Label15: TLabel;
	  EDDGrid: TGridPanel;
    ckMensesYes: TCheckBox;
    ckDurationYes: TCheckBox;
    ckAmountYes: TCheckBox;
    ckDurationNo: TCheckBox;
    ckContraceptionNo: TCheckBox;
    ckContraceptionYes: TCheckBox;
    ckAmountNo: TCheckBox;
    ckMensesNo: TCheckBox;
    ckFinalEDDLMP: TCheckBox;
    ckFinalEDDECD: TCheckBox;
    ckFinalEDDUltra: TCheckBox;
    ckFinalEDDEmbryo: TCheckBox;
    ckFinalEDDOther: TCheckBox;
    ckFinalEDDUnknown: TCheckBox;
  	ck_LMPQualifier: TCheckBox;
    dtLMP: TORDateBox;
    dtECD: TORDateBox;
    dtUltra: TORDateBox;
    dtEmbryo: TORDateBox;
    dtOther: TORDateBox;
    edtLMP: TORDateBox;
    edthcg: TORDateBox;	
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
    procedure fVitalsControlChange(Sender: TObject);
//    procedure fVitalsDrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    // EDD Calculator Page -----------------------------------------------------
    procedure dtLMPChange(Sender: TObject);
    procedure dtECDChange(Sender: TObject);
    procedure dtUltraChange(Sender: TObject);
    procedure spnWeekUltraChange(Sender: TObject);
    procedure spnDayUltraChange(Sender: TObject);
    procedure dtEmbryoChange(Sender: TObject);
    procedure spnTransferDayChange(Sender: TObject);
    procedure dtOtherChange(Sender: TObject);
    procedure spnWeekOtherChange(Sender: TObject);
    procedure spnDayOtherChange(Sender: TObject);
    procedure lblOtherChange(Sender: TObject);
    procedure lblOtherMouseEnter(Sender: TObject);
    procedure lblOtherExit(Sender: TObject);
    procedure dtEDDUnknownChange(Sender: TObject);
    procedure IsFinalEDDClick(Sender: TObject);
    // Menstrual Page ----------------------------------------------------------
    procedure edtLMPChange(Sender: TObject);
    procedure ToggleCheckBoxes(Sender: TObject);
  private
    FocusControlText: TSayOnFocusList;
    FNote: TStringList;
    TabSeen: array of Boolean;
    procedure BuildSayOnFocus(wControl: TWinControl; txt: string);
    procedure LMPChangeEvents(Switch: Boolean);
    procedure UpdateLMP;
    function CalEDD(EventType: TEventType): string;
    function CalGestationalAge(EventType: TEventType; FromDate,ToDate: Extended): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save;
    function GetPatientVitals: TStringList;
    function GetVitalsNote: TStringList;
    function GetEDDNote: TStringList;
    function GetLMPNote: TStringList;
    function GetCompleteNote: TStringList;
    function GetTextforFocus(Value: TWinControl): string;
  end;

implementation

{$R *.dfm}

uses
  ORFn, uBase, uCommon, uExtndComBroker;

const
  FMT_DATETIME = 'mm/dd/yyyy';

{$REGION 'TSayOnFocusList'}

// Private ---------------------------------------------------------------------

function TSayOnFocusList.Get(Index: Integer): PSayOnFocus;
begin
  Result := PSayOnFocus(inherited Get(Index));
end;

// Public ----------------------------------------------------------------------

destructor TSayOnFocusList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    FreeMem(Items[I]);

  inherited;
end;

function TSayOnFocusList.Add(Value: PSayOnFocus): Integer;
begin
  Result := inherited Add(Value);
end;

{$ENDREGION}

//procedure TDDCSVitals.fVitalsDrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
//var
//  iCaption: string;
//  thisTab,rCheckBox: TRect;
//
//  function GetCkRect(tStat: Boolean): TRect;
//  begin
//    if tStat then
//    begin
//      Result.Left   := Rect.Left + 6;
//      Result.Top    := Rect.Top + 6;
//      Result.Right  := Result.Left + 12;
//      Result.Bottom := Result.Top + 12;
//    end else
//    begin
//      Result.Left   := Rect.Left + 1;
//      Result.Top    := Rect.Top + 4;
//      Result.Right  := Result.Left + 12;
//      Result.Bottom := Result.Top + 12;
//    end;
//  end;
//
//begin
//  SetLength(TabSeen, fVitalsControl.PageCount);
//  iCaption := fVitalsControl.Pages[TabIndex].Caption;
//
//  thisTab := Rect;
//  Control.Canvas.FillRect(Rect);
//
//  rCheckBox := GetCkRect(Active);
//  Control.Canvas.Rectangle(rCheckBox);
//
//  thisTab.Top := rCheckBox.Bottom + 3;
//  InflateRect(thisTab, 0, -3);          // This is the size of the text area
//
//  if TabIndex <> -1 then
//  begin
//    if Active then
//      TabSeen[TabIndex] := True;
//
//    if TabSeen[TabIndex] then
//      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_CHECKED)
//    else
//      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);
//  end else
//    DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);
//
//  Control.Canvas.Font.Orientation := 900;
//  Control.Canvas.TextRect(thisTab, iCaption, [tfBottom, tfLeft, tfSingleLine]);
//end;

   // LMP ****
procedure TDDCSVitals.dtLMPChange(Sender: TObject);
begin
  if dtLMP.Text = 'Today' then
  begin
    dtLMP.Text := DateToStr(Today);
    Exit;
  end;

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
    dtLMP.OnChange := nil;
    edtLMP.OnChange := nil;
  end else
  begin
    edtLMP.OnChange := edtLMPChange;
    dtLMP.OnChange := dtLMPChange;
  end;
end;

   // ECD ****
procedure TDDCSVitals.dtECDChange(Sender: TObject);
begin
  if dtECD.Text = 'Today' then
  begin
    dtECD.Text := DateToStr(Today);
    Exit;
  end;

  ckFinalEDDECD.Checked := False;
  edtEDDECD.Text := CalEDD(evECD);
end;

   // Ultrasound ****
procedure TDDCSVitals.dtUltraChange(Sender: TObject);
begin
  if dtUltra.Text = 'Today' then
  begin
    dtUltra.Text := DateToStr(Today);
    Exit;
  end;

  ckFinalEDDUltra.Checked := False;
  edtEDDUltra.Text := CalEDD(evUlt);
end;

procedure TDDCSVitals.spnWeekUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnWeekUltra.Value < 0 then
    spnWeekUltra.Value := 0;

  dtUltraChange(Sender);
end;

procedure TDDCSVitals.spnDayUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnDayUltra.Value < 0 then
    spnDayUltra.Value := 0;

  if spnDayUltra.Value > 6 then
  begin
    spnWeekUltra.OnChange := nil;
    spnWeekUltra.Value := spnWeekUltra.Value + 1;
    spnDayUltra.Value := 0;
    spnWeekUltra.OnChange := dtUltraChange;
  end;

  dtUltraChange(Sender);
end;

   // Embryo Transfer ****
procedure TDDCSVitals.dtEmbryoChange(Sender: TObject);
begin
  if dtEmbryo.Text = 'Today' then
  begin
    dtEmbryo.Text := DateToStr(Today);
    Exit;
  end;

  ckFinalEDDEmbryo.Checked := False;
  edtEDDEmbryo.Text := CalEDD(evEmT);
end;

procedure TDDCSVitals.spnTransferDayChange(Sender: TObject);
begin
  ckFinalEDDEmbryo.Checked := False;
  dtEmbryoChange(Sender);
end;

   // Other ****
procedure TDDCSVitals.dtOtherChange(Sender: TObject);
begin
  if dtOther.Text = 'Today' then
  begin
    dtOther.Text := DateToStr(Today);
    Exit;
  end;

  ckFinalEDDOther.Checked := False;
  edtEDDOther.Text := CalEDD(evOth);
end;

procedure TDDCSVitals.spnWeekOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnWeekOther.Value < 0 then
    spnWeekOther.Value := 0;

  dtOtherChange(Sender);
end;

procedure TDDCSVitals.spnDayOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnDayOther.Value < 0 then
    spnDayOther.Value := 0;

  if spnDayOther.Value > 6 then
  begin
    spnWeekOther.OnChange := nil;
    spnWeekOther.Value := spnWeekOther.Value + 1;
    spnDayOther.Value := 0;
    spnWeekOther.OnChange := dtOtherChange;
  end;

  dtOtherChange(Sender);
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
procedure TDDCSVitals.dtEDDUnknownChange(Sender: TObject);
begin
  ckFinalEDDUnknown.Checked := False;
end;

   // Final --------------------------------------------------------------------

procedure TDDCSVitals.IsFinalEDDClick(Sender: TObject);
var
  I,Row,GA,GAgeWeeks: Integer;
  fDate: TDateTime;

  procedure StopChecked;
  var
    Row: Integer;
  begin
    for Row := 1 to 6 do
      TCheckBox(EDDGrid.ControlCollection.Controls[5, Row]).OnClick := nil;
  end;

  procedure StartChecked;
  var
    Row: Integer;
  begin
    for Row := 1 to 6 do
      TCheckBox(EDDGrid.ControlCollection.Controls[5, Row]).OnClick := IsFinalEDDClick;
  end;

  procedure UpdateGestation(EventType: TEventType; EDD,EventDate: TDateTime);
  var
    GA: string;
  begin
    // EDD Gestational Age (or Current)
    if EDD > Today then
      GA := CalGestationalAge(EventType, EventDate, Now)
    else
      GA := CalGestationalAge(EventType, EventDate, EDD);

    edtEDDGA.Text := Piece(GA,U,1) + 'w ' + Piece(GA,U,2) + 'd';

    // Current Gestational Age (or after EDD)
    GA := CalGestationalAge(EventType, EventDate, Now);
    edtFinalGA.Text := Piece(GA,U,1) + 'w ' + Piece(GA,U,2) + 'd';
  end;

begin
  if not (Sender is TCheckBox) then
    Exit;

  edtFinalGA.Text := '';
  edtCurrentEDD.Text := '';
  edtEDDGA.Text := '';

  StopChecked;
  try
    for I := 1 to 6 do
    begin
      if not (Sender = TCheckBox(EDDGrid.ControlCollection.Controls[5, I])) then
        TCheckBox(EDDGrid.ControlCollection.Controls[5, I]).Checked := False
      else
      begin
        if TCheckBox(Sender).Checked then
        begin
          Row := EDDGrid.ControlCollection.Items[EDDGrid.ControlCollection.IndexOf(TControl(Sender))].Row;
          case Row of
            1: begin                                                            // LMP
                 dtLMPChange(dtLMP);

                 if TryStrToDate(edtEDDLMP.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := edtEDDLMP.Text;
                   UpdateGestation(evLMP, fDate, StrToDate(dtLMP.Text));
                   TCheckBox(Sender).Checked := True;
                 end;
               end;
            2: begin                                                            // ECD
                 dtECDChange(dtECD);

                 if TryStrToDate(edtEDDECD.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := edtEDDECD.Text;
                   UpdateGestation(evECD, fDate, StrToDate(dtECD.Text));
                   TCheckBox(Sender).Checked := True;
                 end;
               end;
            3: begin                                                            // Ultrasound
                 dtUltraChange(dtUltra);

                 if TryStrToDate(edtEDDUltra.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := edtEDDUltra.Text;
                   UpdateGestation(evUlt, fDate, IncDay(StrToDate(dtUltra.Text), -((spnWeekUltra.Value * 7) + spnDayUltra.Value)));
                   TCheckBox(Sender).Checked := True;
                 end;
               end;
            4: begin                                                            // Embryo Transfer
                 dtEmbryoChange(dtEmbryo);

                 if TryStrToDate(edtEDDEmbryo.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := edtEDDEmbryo.Text;
                   UpdateGestation(evEmT, fDate, StrToDate(dtEmbryo.Text));
                   TCheckBox(Sender).Checked := True;
                 end;
               end;
            5: begin                                                            // Other
                 dtOtherChange(dtOther);

                 if lblOther.Text = 'Other Criteria' then
                   ckFinalEDDOther.Checked := False
                 else if TryStrToDate(edtEDDOther.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := edtEDDOther.Text;
                   UpdateGestation(evOth, fDate, IncDay(StrToDate(dtOther.Text), -((spnWeekOther.Value * 7) + spnDayOther.Value)));
                   TCheckBox(Sender).Checked := True;
                 end;
               end;
            6: begin                                                            // Unknown
                 if TryStrToDate(dtEDDUnknown.Text, fDate) then
                 begin
                   edtCurrentEDD.Text := dtEDDUnknown.Text;
                   if fDate > Today then
                   begin
                     GA := 279 - DaysBetween(fDate, Now);
                     GAgeWeeks := Trunc(GA div 7);
                     edtEDDGA.Text := IntToStr(GAgeWeeks) + 'w ' + IntToStr(GA - Trunc(GAgeWeeks * 7)) + 'd';
                     edtFinalGA.Text := edtEDDGA.Text;
                   end;
                 end else TCheckBox(Sender).Checked := False;
               end;
          end;
        end;
      end;
    end;
  finally
    StartChecked;
  end;
end;

   // Menstrual Page -----------------------------------------------------------

procedure TDDCSVitals.edtLMPChange(Sender: TObject);
begin
  if ((edtLMP.IsValid) and (edtLMP.FMDateTime <> dtLMP.FMDateTime)) then
  begin
    LMPChangeEvents(False);
    dtLMP.FMDateTime := edtLMP.FMDateTime;
    dtLMPChange(edtLMP);
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
  end;
end;

// Private ---------------------------------------------------------------------

procedure TDDCSVitals.UpdateLMP;
begin
  ck_LMPQualifier.Checked := False;
  ckMensesYes.Checked := False;
  ckMensesNo.Checked := False;
  edtFrequency.Text := '';
  ckAmountYes.Checked := False;
  ckAmountNo.Checked := False;
  ckDurationYes.Checked := False;
  ckDurationNo.Checked := False;
  ckContraceptionYes.Checked := False;
  ckContraceptionNo.Checked := False;
  edtContraceptionType.ItemIndex := -1;
  edthcg.Text := '';
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

{ Date/Time functions }
   //  function DateTimeToFMDateTime(ADateTime: TDateTime): TFMDateTime;
   //  function FMDateTimeToDateTime(ADateTime: TFMDateTime): TDateTime;
   //  function FMDateTimeOffsetBy(ADateTime: TFMDateTime; DaysDiff: Integer): TFMDateTime;
   //  function FormatFMDateTime(AFormat: string; ADateTime: TFMDateTime): string;
   //  function FormatFMDateTimeStr(const AFormat, ADateTime: string): string;

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

   // Gestational Age ----------------------------------------------------------
function TDDCSVitals.CalGestationalAge(EventType: TEventType; FromDate,ToDate: Extended): string;         // weeks^days
var
  GAgeDays,GAgeWeeks: Integer;
begin
  Result := '0^0';

  case EventType of
    evLMP: GAgeDays := DaysBetween(ToDate, FromDate);
    evECD: GAgeDays := DaysBetween(ToDate, FromDate) + 14;
    evUlt: GAgeDays := DaysBetween(ToDate, FromDate);
    evEmT: begin
             if cbTransferDay.Text = '3' then
               GAgeDays := DaysBetween(ToDate, FromDate) + 17
             else if cbTransferday.Text = '5' then
               GAgeDays := DaysBetween(ToDate, FromDate) + 19
             else
               GAgeDays := DaysBetween(ToDate, FromDate) + 18;
           end;
    evOth: GAgeDays := DaysBetween(ToDate, FromDate);
    else GAgeDays := 0;
  end;

  GAgeWeeks := Trunc(GAgeDays div 7);
  Result := IntToStr(GAgeWeeks) + U + IntToStr(GAgeDays - Trunc(GAgeWeeks * 7));
end;

// -----------------------------------------------------------------------------

procedure TDDCSVitals.fVitalsControlChange(Sender: TObject);
begin
  inherited;
  
  if csDesigning in ComponentState then
    Exit;

  if fVitalsControl.ActivePage.TabVisible then
    if Owner is TDDCSForm then
      if TDDCSForm(Owner).ScreenReader <> nil then
        TDDCSForm(Owner).ScreenReader.Say('Currently on the ' + fVitalsControl.ActivePage.Caption +
                                 ' tab of the vitals page.', False);
end;

// Public ----------------------------------------------------------------------

procedure TDDCSVitals.BuildSayOnFocus(wControl: TWinControl; txt: string);
var
  rText: PSayOnFocus;
begin
  GetMem(rText, SizeOf(TSayOnFocus));
  rText.FOwningObject := wControl;
  rText.Text := txt;
  FocusControlText.Add(rText);
end;

constructor TDDCSVitals.Create(AOwner: TComponent);
var
  sl: TStringList;
  I: Integer;
  str: string;

  function strLengthen(str: string): string;
  begin
    Result := str;
    while Length(Result) < 50 do
      Result := Result + ' ';
  end;

begin
  inherited;

  if csDesigning in ComponentState then
    Exit;

  FNote := TStringList.Create;
  SetLength(TabSeen, fVitalsControl.PageCount);

  cbTransferDay.ItemIndex := 1;

  dtLMP.Format        := FMT_DATETIME;
  dtECD.Format        := FMT_DATETIME;
  dtUltra.Format      := FMT_DATETIME;
  dtEmbryo.Format     := FMT_DATETIME;
  dtOther.Format      := FMT_DATETIME;
  dtEDDUnknown.Format := FMT_DATETIME;
  edtLMP.Format       := FMT_DATETIME;

  sl := TStringList.Create;
  try
    try
      if RPCBrokerV = nil then
        Exit;

      sl.AddStrings(GetPatientVitals);
	  
      if sl.Count > 0 then
        if sl[0] <> '-1' then
        begin
          FNote.Add('VITAL SIGNS:');
          for I := 0 to sl.Count - 1 do
          begin
            if Piece(sl[I],U,2) = 'T' then                                                          // Temperature
            begin
              FTemps.Text := Piece(sl[I],U,3);
              FTempe.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), tuFahrenheit, tuCelsius));
              FTempdt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Temperature:    ' + FTemps.Text + ' F (' + FTempe.Text + ' C)') + FTempdt.Caption);
            end
            else if Piece(sl[I],U,2) = 'P' then                                                     // Pulse
            begin
              FPulses.Text := Piece(sl[I],U,3);
              FPulsedt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Pulse:          ' + FPulses.Text) + FPulsedt.Caption);
            end                                                                                     // Respiration
            else if Piece(sl[I],U,2) = 'R' then
            begin
              FResps.Text := Piece(sl[I],U,3);
              FRespdt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Respiration:    ' + FResps.Text) + FRespdt.Caption);
            end
            else if Piece(sl[I],U,2) = 'BP' then                                                    // Blood Pressure
            begin
              // Populate Systolic (top) and Diastolic (bottom) from BP
              FSystolics.Text := Piece(Piece(sl[I],U,3),'/',1);
              FDiastolics.Text := Piece(Piece(sl[I],U,3),'/',2);
              FSystolicdt.Caption := Piece(sl[I],U,4);
              FDiastolicdt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Blood Pressure: ' + Piece(sl[I],U,3)) + Piece(sl[I],U,4));
            end
            else if Piece(sl[I],U,2) = 'HT' then                                                    // Height
            begin
              FHeights.Text := Piece(sl[I],U,3);
              FHeighte.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), duInches, duCentimeters));
              FHeightdt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Height:         ' + FHeights.Text + ' in (' + FHeighte.Text + ' cm)') + FHeightdt.Caption);
            end
            else if Piece(sl[I],U,2) = 'WT' then                                                    // Weight
            begin
              FWeights.Text := Piece(sl[I],U,3);
              FWeighte.Text := FormatFloat('0.##', Convert(StrToFloat(Piece(sl[I],U,3)), muPounds, muKilograms));
              FWeightdt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Weight:         ' + FWeights.Text + ' lb (' + FWeighte.Text + ' kg)') + FWeightdt.Caption);
            end
            else if Piece(sl[I],U,2) = 'PN' then                                                    // Pain
            begin
              FPains.Text := Piece(sl[I],U,3);
              FPaindt.Caption := Piece(sl[I],U,4);
              FNote.Add(strlengthen('  Pain:           ' + FPains.Text) + FPaindt.Caption);
            end
            // if Piece(sl[I],U,2) = 'POX'                                                          // Pulse Oximetry
            // if Piece(sl[I],U,2) = 'CVP' then                                                     // Central Venous Pressure
            // if Piece(sl[I],U,2) = 'CG' then                                                      // Circumference/Girth
            else if Piece(sl[I],U,2) = 'BMI' then                                                   // Body Mass Index
            begin
              FBMIValue.Caption := Piece(sl[I],U,3);
             FNote.Insert(1, '  BMI:            ' + Piece(sl[I],U,3));
            end
            else if Piece(sl[I],U,2) = 'AGE' then                                                   // Age
            begin
             FAgeValue.Caption := Piece(sl[I],U,3);
              FNote.Insert(1, '  Age:            ' + Piece(sl[I],U,3));
            end
            else if Piece(sl[I],U,2) = 'SEX' then                                                   // Sex
            begin
              FSexValue.Caption := Piece(sl[I],U,3);
              FNote.Insert(1, '  Sex:            ' + Piece(sl[I],U,3));
            end;
          end;
		    end;

      sl.Clear;
      if UpdateContext(MENU_CONTEXT) then
        tCallV(sl, 'DSIO DDCS VITALS LMP', [RPCBrokerV.PatientDFN, RPCBrokerV.DDCSInterface]);

      if sl.Count > 0 then
        if sl[0] <> '-1' then
        begin
          // LMP
          str := Piece(sl[0],U,1);
          if str <> '' then
            edtLMP.Text := str;

          // Qualifier
          if Piece(sl[0],U,9) = 'A' then
            ck_LMPQualifier.Checked := True;

          // Menses
          str := Piece(sl[0],U,2);
          if str = 'N' then
            ckMensesYes.Checked := True
          else if str = 'A' then
            ckMensesNo.Checked := True;

          // Frequency
          edtFrequency.Text := Piece(sl[0],U,3);

          // Menarche
          edtMenarche.Text := Piece(sl[0],U,4);

          // HCG
          edthcg.Text := Piece(sl[0],U,5);

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
    FocusControlText := TSayOnFocusList.Create;
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

    BuildSayOnFocus(   ck_LMPQualifier, 'Last Menstrual Period Approximation');
    BuildSayOnFocus(       ckMensesYes, 'Menses');
    BuildSayOnFocus(        ckMensesNo, 'Menses');
    BuildSayOnFocus(      edtFrequency, 'Frequency in days');
    BuildSayOnFocus(       edtMenarche, 'Menarche in age of onset');
    BuildSayOnFocus(       ckAmountYes, 'Amount');
    BuildSayOnFocus(        ckAmountNo, 'Amount');
    BuildSayOnFocus(     ckDurationYes, 'Duration');
    BuildSayOnFocus(      ckDurationNo, 'Duration');
    BuildSayOnFocus(ckContraceptionYes, 'On Contraception');
    BuildSayOnFocus( ckContraceptionNo, 'On Contraception');
    // 508 support -----------------------------------------------------------
  end;

  if AnsiCompareText(FSexValue.Caption, 'MALE') = 0 then
  begin
    fVitalsControl.Pages[1].TabVisible := False;
    fVitalsControl.Pages[2].TabVisible := False;
  end;

  fVitalsControl.ActivePageIndex := 0;
end;

destructor TDDCSVitals.Destroy;
begin
  if Assigned(FocusControlText) then
    FocusControlText.Free;
  if Assigned(FNote) then
    FNote.Free;
  SetLength(TabSeen, 0);

  inherited;
end;

procedure TDDCSVitals.Save;
var
  sl: TStringList;
  qual,return: string;

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
    // EDD
//    sl.Add('EDD^' + lblLMP.Caption + U + FloatToStr(dtLMP.FMDateTime) + U + edtWeekLMP.Text + 'w' +
//                    edtDayLMP.Text + 'd^' + edtEDDLMP.Text + U + ckBool(ckFinalEDDLMP));
//    sl.Add('EDD^' + lblECD.Caption + U + FloatToStr(dtECD.FMDateTime) + U + edtWeekECD.Text + 'w' +
//                    edtDayECD.Text + 'd^' + edtEDDECD.Text + U + ckBool(ckFinalEDDECD));
    sl.Add('EDD^' + lblUltra.Caption + U + FloatToStr(dtUltra.FMDateTime) + U + spnWeekUltra.Text + 'w' +
                    spnDayUltra.Text + 'd^' + edtEDDUltra.Text + U + ckBool(ckFinalEDDUltra));
//    sl.Add('EDD^' + lblEmbryo.Caption + U + FloatToStr(dtEmbryo.Date) + U + edtWeekEmbryo.Text + 'w' +
//                    edtDayEmbryo.Text + 'd^' + edtEDDEmbryo.Text + U + ckBool(ckFinalEDDEmbryo));
    sl.Add('EDD^' + lblOther.Text + U + FloatToStr(dtOther.FMDateTime) + U + spnWeekOther.Text + 'w' +
                    spnDayOther.Text + 'd^' + edtEDDOther.Text + U + ckBool(ckFinalEDDOther));
    sl.Add('EDD^' + lblUnknown.Caption + '^^^' + FloatToStr(dtEDDUnknown.FMDateTime) + U + ckBool(ckFinalEDDUnknown));

    // LMP
    if ck_LMPQualifier.Checked then
      qual := 'A'
    else
      qual := '';

    sl.Add('LMP^' + edtLMP.Text + U + SetofCodes(ckMensesYes,ckMensesNo) + U + edtFrequency.Text + U + SetofCodes(ckAmountYes,ckAmountNo) + U +
                    SetofCodes(ckDurationYes,ckDurationNo) + U + SetofCodes(ckContraceptionNo,ckContraceptionYes) + U +
                    edtContraceptionType.Text + U + edthcg.Text + U + edtMenarche.Text + U + qual);

    // Comments
    if memLMP.Lines.Count > 0 then
      sl.Add('COM^' + memLMP.Lines.Text);

    try
      if UpdateContext(MENU_CONTEXT) then
        return := sCallV('DSIO DDCS ORQQVI VITALS SAVE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, sl])
    except
    end;
  finally
    sl.Free;
  end;
end;

function TDDCSVitals.GetPatientVitals: TStringList;
// Array of vital ien^vital type^rate/value^date/time taken
begin
  Result := TStringList.Create;
  try
    if RPCBrokerV <> nil then
    begin
      if UpdateContext(MENU_CONTEXT) then
        tCallV(Result, 'DSIO DDCS ORQQVI VITALS', [RPCBrokerV.PatientDFN]);
    end;
  except
  end;
end;

function TDDCSVitals.GetVitalsNote;
begin
  Result := FNote;
  Result.Add('');
end;

function TDDCSVitals.GetEDDNote;
begin
  Result := TStringList.Create;

  if edtCurrentEDD.Text = '' then
    Exit;

  Result.Add('ESTIMATED DELIVERY DATE:');

  Result.Add('  Final EDD: ' + edtCurrentEDD.Text);
  if edtEDDGA.Text <> '' then
    Result.Add('   Gestational Age for Final EDD: ' + edtEDDGA.Text);
  if edtFinalGA.Text <> '' then
    Result.Add('   Gestational Age Today: ' + edtFinalGA.Text);
  if ckFinalEDDLMP.Checked then
    Result.Add('   The current calculation is based on  a Last Menstrual Period of ' + dtLMP.Text + '.')
  else if ckFinalEDDECD.Checked then
    Result.Add('   The current calculation is based on an Estimated Conception Date of ' + dtECD.Text + '.')
  else if ckFinalEDDUltra.Checked then
    Result.Add('   The current calculation is based on an Ultrasound conducted on ' + dtUltra.Text +
               ' with an estimated gestational age of ' + IntToStr(spnWeekUltra.Value) + ' weeks and ' +
               IntToStr(spnDayUltra.Value) + ' days.')
  else if ckFinalEDDEmbryo.Checked then
    Result.Add('   The current calculation is based on a ' + cbTransferDay.Text + '-day embryo transfer conducted on ' +
               dtEmbryo.Text + '.')
  else if ckFinalEDDOther.Checked then
    Result.Add('   The current calculation is based on an EDD Criteria of ' + lblOther.Text +
               ' with an estimated gestational age of ' + IntToStr(spnWeekOther.Value) + ' weeks and ' +
               IntToStr(spnDayOther.Value) + ' days.')
  else if ckFinalEDDUnknown.Checked then
    Result.Add('   The current methodology for calculation is unknown.');

  Result.Add('');
end;

function TDDCSVitals.GetLMPNote;
var
  I: Integer;
begin
  Result := TStringList.Create;

  if edtLMP.Text <> ''                 then Result.Add('  LMP: ' + edtLMP.Text);
  if ck_LMPQualifier.Checked           then Result.Add('   *Approximate');
  if ckMensesYes.Checked = True        then Result.Add('  Menses Regular: YES');
  if ckMensesNo.Checked = True         then Result.Add('  Menses Regular: NO');
  if edtFrequency.Text <> ''           then Result.Add('  Frequency: ' + edtFrequency.Text + ' days');
  if edtMenarche.Text <> ''            then Result.Add('  Menarche: ' + edtMenarche.Text + ' years old');
  if edthcg.Text <> ''                 then Result.Add('  hCG+: ' + edthcg.Text);
  if ckAmountYes.Checked = True        then Result.Add('  Normal Amount: YES');
  if ckAmountNo.Checked = True         then Result.Add('  Normal Amount: NO');
  if ckDurationYes.Checked = True      then Result.Add('  Normal Duration: YES');
  if ckDurationNo.Checked = True       then Result.Add('  Normal Duration: NO');
  if ckContraceptionYes.Checked = True then Result.Add('  On Contraception: YES');
  if ckContraceptionNo.Checked = True  then Result.Add('  On Contraception: NO');
  if edtContraceptionType.Text <> ''   then
  begin
    Result.Add('  What type(s) of contraception were you using most recently?');
    Result.Add('  ' + edtContraceptionType.Text);
  end;

  if memLMP.Lines.Count > 0 then
  begin
    Result.Add(' Menstrual Narrative:');
    for I := 0 to memLMP.Lines.Count - 1 do
      Result.Add('  ' + memLMP.Lines[I]);
  end;

  if Result.Count > 0 then
  begin
    Result.Insert(0, 'MENSTRUAL HISTORY: ');
    Result.Add('');
  end;
end;

function TDDCSVitals.GetCompleteNote;
begin
  Result := TStringList.Create;

  Result.AddStrings(GetVitalsNote);
  if fVitalsControl.Pages[1].TabVisible then
    Result.AddStrings(GetEDDNote);
  if fVitalsControl.Pages[2].TabVisible then
    Result.AddStrings(GetLMPNote);
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
