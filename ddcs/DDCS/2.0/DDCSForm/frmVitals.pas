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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ConvUtils, System.StdConvs,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.DateUtils,
  System.StrUtils, Graphics, uCommon, uExtndComBroker;

type
  TEventType = (evLMP,evECD,evUlt,evEmT,evOth,evUkn);

  TDDCSVitals = class(TFrame)
    fVitalsControl: TPageControl;
    PageMain: TTabSheet;
    FAge: TStaticText;
    FSex: TStaticText;
    FBMI: TStaticText;
    FTemps: TEdit;
    FHeights: TEdit;
    FWeights: TEdit;
    FTempdt: TStaticText;
    FHeightdt: TStaticText;
    FWeightdt: TStaticText;
    FTempl: TStaticText;
    FHeightl: TStaticText;
    FWeightl: TStaticText;
    FTempe: TEdit;
    FHeighte: TEdit;
    FWeighte: TEdit;
    FPulses: TEdit;
    FPulsedt: TStaticText;
    FPulsel: TStaticText;
    FResps: TEdit;
    FRespl: TStaticText;
    FRespdt: TStaticText;
    FPains: TEdit;
    FPainl: TStaticText;
    FPaindt: TStaticText;
    FSystolics: TEdit;
    FSystolicl: TStaticText;
    FSystolicdt: TStaticText;
    FDiastolics: TEdit;
    FDiastolicl: TStaticText;
    FDiastolicdt: TStaticText;
    PageEDD: TTabSheet;
    PageLMP: TTabSheet;
    edtContraceptionType: TComboBox;
    ckMensesYes: TCheckBox;
    ckDurationYes: TCheckBox;
    ckAmountYes: TCheckBox;
    memLMP: TMemo;
    ckDurationNo: TCheckBox;
    edthcg: TLabeledEdit;
    ckContraceptionNo: TCheckBox;
    ckContraceptionYes: TCheckBox;
    ckAmountNo: TCheckBox;
    edtMenarche: TLabeledEdit;
    edtFrequency: TLabeledEdit;
    ckMensesNo: TCheckBox;
    edtLMP: TLabeledEdit;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    sbtnGetDate1: TSpeedButton;
    Label1: TLabel;
    StaticText2: TStaticText;
    edtCurrentEDD: TEdit;
    EDDGrid: TGridPanel;
    dtLMP: TDateTimePicker;
    edtEDDLMP: TEdit;
    lblLMP: TLabel;
    lblECD: TLabel;
    lblUltra: TLabel;
    dtECD: TDateTimePicker;
    edtEDDECD: TEdit;
    dtUltra: TDateTimePicker;
    spnWeekUltra: TSpinEdit;
    spnDayUltra: TSpinEdit;
    edtEDDUltra: TEdit;
    dtEmbryo: TDateTimePicker;
    edtEDDEmbryo: TEdit;
    lblUnknown: TLabel;
    dtOther: TDateTimePicker;
    spnWeekOther: TSpinEdit;
    spnDayOther: TSpinEdit;
    edtEDDOther: TEdit;
    lblOther: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ckFinalEDDLMP: TCheckBox;
    ckFinalEDDECD: TCheckBox;
    ckFinalEDDUltra: TCheckBox;
    ckFinalEDDEmbryo: TCheckBox;
    ckFinalEDDOther: TCheckBox;
    ckFinalEDDUnknown: TCheckBox;
    dtEDDUnknown: TDateTimePicker;
    edtFinalGA: TEdit;
    Label14: TLabel;
    Panel1: TPanel;
    lblEmbryo: TLabel;
    ck_LMPQualifier: TCheckBox;
    Label15: TLabel;
    edtEDDGA: TEdit;
    cbTransferDay: TComboBox;
    procedure fVitalsDrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    // Calculation Rows --------------------------------------------------------
    procedure dtLMPChange(Sender: TObject);
    procedure edtLMPChange(Sender: TObject);
    procedure dtECDChange(Sender: TObject);
    procedure dtUltraChange(Sender: TObject);
    procedure spnWeekUltraChange(Sender: TObject);
    procedure spnDayUltraChange(Sender: TObject);
    procedure dtEmbryoChange(Sender: TObject);
    procedure spnTransferDayChange(Sender: TObject);
    procedure dtOtherChange(Sender: TObject);
    procedure spnWeekOtherChange(Sender: TObject);
    procedure spnDayOtherChange(Sender: TObject);
    procedure lblOtherMouseEnter(Sender: TObject);
    procedure lblOtherExit(Sender: TObject);
    procedure dtEDDUnknownChange(Sender: TObject);
    procedure IsFinalEDDClick(Sender: TObject);
    // Menstrual History -------------------------------------------------------
    procedure sbtnGetDate1Click(Sender: TObject);
    procedure ckMensesYesClick(Sender: TObject);
    procedure lblOtherChange(Sender: TObject);
  private
    FNote: TStringList;
    TabSeen: array of Boolean;
    function CalEDD(EventType: TEventType; EventDate: Extended): Extended;
    function CalGestationalAge(EventType: TEventType; FromDate,ToDate: Extended): string;
    procedure LMPChangeEvents(Switch: Boolean);
    procedure UpdateLMP;
    procedure ToggleCB(cb1,cb2: TCheckBox);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetPatientVitals: TStringList;
    function GetVitalsNote: TStringList;
    function GetEDDNote: TStringList;
    function GetLMPNote: TStringList;
    function GetCompleteNote: TStringList;
    procedure Save;
  end;

var
  FEDDLoad,FLMPLoad: Boolean;

implementation

{$R *.dfm}

uses
  uBase, udlgDATE;

function TDDCSVitals.GetPatientVitals: TStringList;
// Array of vital ien^vital type^rate/value^date/time taken
begin
  Result := TStringList.Create;
  try
    if RPCBrokerV = nil then
    begin
      RPCBrokerV.SetContext(MENU_CONTEXT);
      RPCBrokerV.tCallV(Result, 'DSIO DDCS ORQQVI VITALS', [RPCBrokerV.PatientDFN]);
    end;
  except
  end;
end;

procedure TDDCSVitals.fVitalsDrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  iCaption: string;
  thisTab,rCheckBox: TRect;

  function GetCkRect(tStat: Boolean): TRect;
  begin
    if tStat then
    begin
      Result.Left   := Rect.Left + 6;
      Result.Top    := Rect.Top + 6;
      Result.Right  := Result.Left + 12;
      Result.Bottom := Result.Top + 12;
    end else
    begin
      Result.Left   := Rect.Left + 1;
      Result.Top    := Rect.Top + 4;
      Result.Right  := Result.Left + 12;
      Result.Bottom := Result.Top + 12;
    end;
  end;

begin
  SetLength(TabSeen, fVitalsControl.PageCount);
  iCaption := fVitalsControl.Pages[TabIndex].Caption;

  thisTab := Rect;
  Control.Canvas.FillRect(Rect);

  rCheckBox := GetCkRect(Active);
  Control.Canvas.Rectangle(rCheckBox);

  thisTab.Top := rCheckBox.Bottom + 3;
  InflateRect(thisTab, 0, -3);          // This is the size of the text area

  if TabIndex <> -1 then
  begin
    if Active then
      TabSeen[TabIndex] := True;

    if TabSeen[TabIndex] then
      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_CHECKED)
    else
      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);
  end else
    DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);

  Control.Canvas.Font.Orientation := 900;
  Control.Canvas.TextRect(thisTab, iCaption, [tfBottom, tfLeft, tfSingleLine]);
end;

// Calculate Estimated Delivery Date -------------------------------------------

function TDDCSVitals.CalEDD(EventType: TEventType; EventDate: Extended): Extended;
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
  case EventType of
    evLMP: Result := IncDay(EventDate, 280);
    evECD: Result := IncDay(EventDate, 266);
    evUlt: Result := IncDay(IncDay(EventDate, - ((spnWeekUltra.Value * 7) + spnDayUltra.Value)), 280);
    evEmT: begin
             if cbTransferDay.Text = '3' then
               Result := IncDay(EventDate, 263)
             else if cbTransferDay.Text = '5' then
               Result := IncDay(EventDate, 261)
             else
               Result := IncDay(EventDate, 262);
           end;
    evOth: Result := IncDay(IncDay(EventDate, - ((spnWeekOther.Value * 7) + spnDayOther.Value)), 280);
    evUkn: Result := dtEDDUnknown.Date;
  end;
end;

// Gestational Age -------------------------------------------------------------

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

// Events ----------------------------------------------------------------------

   // LMP ****
procedure TDDCSVitals.dtLMPChange(Sender: TObject);
var
  testDT: TDate;
begin
  ckFinalEDDLMP.Checked := False;
  edtEDDLMP.Text := FormatDateTime('mm/dd/yyyy', CalEDD(evLMP, dtLMP.Date));

  testDT := StrToDateDef(edtLMP.Text, 0);
  if testDT <> dtLMP.Date then
  begin
    LMPChangeEvents(False);
    edtLMP.Text := DateToStr(dtLMP.Date);
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
  ckFinalEDDECD.Checked := False;
  edtEDDECD.Text := FormatDateTime('mm/dd/yyyy', CalEDD(evECD, dtECD.Date));
end;

   // Ultrasound ****
procedure TDDCSVitals.dtUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;
  edtEDDUltra.Text := FormatDateTime('mm/dd/yyyy', CalEDD(evUlt, dtUltra.Date));
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
  ckFinalEDDEmbryo.Checked := False;
  edtEDDEmbryo.Text := FormatDateTime('mm/dd/yyyy', CalEDD(evEmT, dtEmbryo.Date));
end;

procedure TDDCSVitals.spnTransferDayChange(Sender: TObject);
begin
  ckFinalEDDEmbryo.Checked := False;
  dtEmbryoChange(Sender);
end;

   // Other ****
procedure TDDCSVitals.dtOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;
  edtEDDOther.Text := FormatDateTime('mm/dd/yyyy', CalEDD(evOth, dtOther.Date));
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
  if lblOther.Text = 'Enter Other Criteria' then
  begin
    lblOther.Text := '';
    lblOther.SetFocus;
  end;
end;

procedure TDDCSVitals.lblOtherExit(Sender: TObject);
begin
  if lblOther.Text = '' then
    lblOther.Text := 'Enter Other Criteria';
end;

   // Unknown ****
procedure TDDCSVitals.dtEDDUnknownChange(Sender: TObject);
begin
  ckFinalEDDUnknown.Checked := False;
end;

// Final -----------------------------------------------------------------------

procedure TDDCSVitals.IsFinalEDDClick(Sender: TObject);
var
  Checked: Boolean;
  I,Row,GA,GAgeWeeks: Integer;
  EDD: TDate;

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

  procedure UpdateEDDandGAHeader(EventType: TEventType; EDD,EventDate: Extended);
  var
    GA: string;
  begin
    edtCurrentEDD.Text := FormatDateTime('mm/dd/yyyy', EDD);

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

  StopChecked;
  try
    Checked := False;

    for I := 1 to 6 do
    begin
      if not (Sender = TCheckBox(EDDGrid.ControlCollection.Controls[5, I])) then
        TCheckBox(EDDGrid.ControlCollection.Controls[5, I]).Checked := False
      else
      begin
        if TCheckBox(Sender).Checked then
        begin
          Checked := True;
          edtFinalGA.Text := '';
          edtCurrentEDD.Text := '';
          edtEDDGA.Text := '';

          Row := EDDGrid.ControlCollection.Items[EDDGrid.ControlCollection.IndexOf(TControl(Sender))].Row;
          case Row of
            1: begin                                                            // LMP
                 UpdateEDDandGAHeader(evLMP,
                                      StrToDate(TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text),
                                      TDateTimePicker(EDDGrid.ControlCollection.Controls[1, Row]).Date);
               end;
            2: begin                                                            // ECD
                 UpdateEDDandGAHeader(evECD,
                                      StrToDate(TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text),
                                      TDateTimePicker(EDDGrid.ControlCollection.Controls[1, Row]).Date);
               end;
            3: begin                                                            // Ultrasound
                 UpdateEDDandGAHeader(evUlt,
                                      StrToDate(TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text),
                                      IncDay(TDateTimePicker(EDDGrid.ControlCollection.Controls[1, Row]).Date,
                                             -((spnWeekUltra.Value * 7) + spnDayUltra.Value)));
               end;
            4: begin                                                            // Embryo Transfer
                 UpdateEDDandGAHeader(evEmT,
                                      StrToDate(TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text),
                                      TDateTimePicker(EDDGrid.ControlCollection.Controls[1, Row]).Date);
               end;
            5: begin                                                            // Other
                 if lblOther.Text = 'Enter Other Criteria' then
                   Checked := False
                 else
                   UpdateEDDandGAHeader(evOth,
                                        StrToDate(TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text),
                                        IncDay(TDateTimePicker(EDDGrid.ControlCollection.Controls[1, Row]).Date,
                                               -((spnWeekOther.Value * 7) + spnDayOther.Value)));
               end;
            6: begin                                                            // Unknown
                 EDD := TDateTimePicker(EDDGrid.ControlCollection.Controls[4, Row]).Date;
                 edtCurrentEDD.Text := FormatDateTime('mm/dd/yyyy', EDD);

                 if EDD > Today then
                 begin
//                   else
//                   GA := 279 + DaysBetween(Now, EDD);
                   GA := 279 - DaysBetween(EDD, Now);
                   GAgeWeeks := Trunc(GA div 7);
                   edtEDDGA.Text := IntToStr(GAgeWeeks) + 'w ' + IntToStr(GA - Trunc(GAgeWeeks * 7)) + 'd';
                   edtFinalGA.Text := edtEDDGA.Text;
                 end;
               end;
            end;
        end else
        begin
          edtFinalGA.Text := '';
          edtCurrentEDD.Text := '';
          edtEDDGA.Text := '';
        end;
      end;
    end;

    if not checked then
    begin
      edtFinalGA.Text := '';
      edtCurrentEDD.Text := '';
    end;
  finally
    StartChecked;
  end;
end;

// MENSTRAL HISTORY ------------------------------------------------------------

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

Procedure TDDCSVitals.ToggleCB(cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked then
    cb2.Checked := False;
end;

procedure TDDCSVitals.sbtnGetDate1Click(Sender: TObject);
var
  dlgGetDate: TdlgDate;
begin
  try
    dlgGetDate := TdlgDate.Create(nil);
    dlgGetDate.ShowModal;

    if dlgGetDate.ModalResult = mrOK then
    begin    // choices by tag
      if(dlgGetDate.calMonth.Date) >  Now then
        ShowDialog(Self, 'No future dates', mtWarning)
      else
        case (Sender as TSpeedButton).Tag of
          1 : edtLMP.Text := FormatDateTime('MM/dd/yyyy', dlgGetDate.calMonth.Date);
          2 : edthcg.Text := FormatDateTime('MM/dd/yyyy', dlgGetDate.calMonth.Date);
        end;
    end;
  finally
    dlgGetDate.Free;
  end;
end;

procedure TDDCSVitals.ckMensesYesClick(Sender: TObject);
begin
  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = True) then
  case (Sender as TCheckBox).Tag of
    1: ToggleCB(ckMensesYes,ckMensesNo);
    2: ToggleCB(ckMensesNo,ckMensesYes);
    3: ToggleCB(ckAmountYes,ckAmountNo);
    4: ToggleCB(ckAmountNo,ckAmountYes);
    5: ToggleCB(ckContraceptionYes,ckContraceptionNo);
    6: ToggleCB(ckContraceptionNo,ckContraceptionYes);
    7: ToggleCB(ckDurationYes,ckDurationNo);
    8: ToggleCB(ckDurationNo,ckDurationYes);
  end;
end;

procedure TDDCSVitals.edtLMPChange(Sender: TObject);
var
  testDT: TDateTime;
begin
  if not TryStrToDate(edtLMP.Text, testDT) then
  begin
    edtLMP.Text := '';
    Exit;
  end;

  if ((edtLMP.Text <> '') and (StrToDate(edtLMP.Text) <> dtLMP.Date)) then
  begin
    LMPChangeEvents(False);
    dtLMP.Date := StrToDate(edtLMP.Text);
    dtLMPChange(edtLMP);
    LMPChangeEvents(True);
  end;
end;

// MAIN ------------------------------------------------------------------------

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

  FNote := TStringList.Create;
  SetLength(TabSeen, fVitalsControl.PageCount);

  dtLMP.Format := 'MM/dd/yyyy';
  dtLMP.DateTime := Now;
  dtLMPChange(nil);
  dtECD.Format := 'MM/dd/yyyy';
  dtECD.DateTime := Now;
  dtECDChange(nil);
  dtUltra.Format := 'MM/dd/yyyy';
  dtUltra.DateTime := Now;
  dtUltraChange(nil);
  dtEmbryo.Format := 'MM/dd/yyyy';
  dtEmbryo.DateTime := Now;
  cbTransferDay.ItemIndex := 1;
  dtEmbryoChange(nil);
  dtOther.Format := 'MM/dd/yyyy';
  dtOther.DateTime := Now;
  dtOtherChange(nil);
  dtEDDUnknown.Format := 'MM/dd/yyyy';
  dtEDDUnknown.DateTime := Now;
  dtEDDUnknownChange(nil);

  if not (csDesigning in ComponentState) then
  begin
    fVitalsControl.Pages[1].Visible := False;
    fVitalsControl.Pages[2].Visible := False;

    sl := TStringList.Create;
    try
      try
        if RPCBrokerV = nil then
          Exit;

        sl.AddStrings(GetPatientVitals);

        FNote.Add('VITAL SIGNS:');
        for I := 0 to sl.Count - 1 do
        begin
          if ((I = 0) and (sl[I] = '-1')) then
            Break;

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
  //        if Piece(sl[I],U,2) = 'POX'                                                           // Pulse Oximetry
  //        if Piece(sl[I],U,2) = 'CVP' then                                                      // Central Venous Pressure
  //        if Piece(sl[I],U,2) = 'CG' then                                                       // Circumference/Girth
          else if Piece(sl[I],U,2) = 'BMI' then                                                   // Body Mass Index
          begin
            FBMI.Caption := FBMI.Caption + Piece(sl[I],U,3);
            FNote.Insert(1, '  BMI:            ' + Piece(sl[I],U,3));
          end
          else if Piece(sl[I],U,2) = 'AGE' then                                                   // Age
          begin
            FAge.Caption := FAge.Caption + Piece(sl[I],U,3);
            FNote.Insert(1, '  Age:            ' + Piece(sl[I],U,3));
          end
          else if Piece(sl[I],U,2) = 'SEX' then                                                   // Sex
          begin
            FSex.Caption := FSex.Caption + Piece(sl[I],U,3);
            FNote.Insert(1, '  Sex:            ' + Piece(sl[I],U,3));
          end;
        end;

        sl.Clear;
        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.tCallV(sl, 'DSIO DDCS VITALS LMP', [RPCBrokerV.PatientDFN, RPCBrokerV.DDCSInterface]);

        if ((sl.Count > 0) and (sl[0] <> '-1')) then
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
        ShowDialog(Self, E.Message, mtError);
      end;
    finally
      sl.Free;
    end;

    if FSex.Caption = 'Sex: FEMALE' then
    begin
      fVitalsControl.Pages[1].TabVisible := True;
      fVitalsControl.Pages[2].TabVisible := True;
    end;
  end;

  fVitalsControl.ActivePageIndex := 0;
end;

destructor TDDCSVitals.Destroy;
var
  mForm: TDDCSForm;
begin
  mForm := nil;
  if ((Parent <> nil) and (Parent is TTabSheet)) then
    if ((TTabSheet(Parent).PageControl <> nil) and (TTabSheet(Parent).PageControl is TDDCSForm)) then
       mForm := TDDCSForm(TTabSheet(Parent).PageControl);

  FNote.Free;
  SetLength(TabSeen, 0);

  inherited;

  if ((mForm <> nil) and (mForm.VitalsControl <> nil)) then
  begin
    mForm.VitalsControl := nil;
    mForm.VitalsPage := nil;
  end;
end;

function TDDCSVitals.GetVitalsNote;
begin
  Result := TStringList.Create;
  Result := FNote;
end;

function TDDCSVitals.GetLMPNote;
var
  I: Integer;
begin
  Result := TStringList.Create;

  Result.Add('MENSTRUAL HISTORY: ');
  if edtLMP.Text  <> ''                then Result.Add('  LMP: ' + edtLMP.Text);
  if ck_LMPQualifier.Checked           then Result.Add('   *Approximate');
  if ckMensesYes.Checked = True        then Result.Add('  Menses Regular: YES');
  if ckMensesNo.Checked = True         then Result.Add('  Menses Regular: NO');
  if edtFrequency.Text  <> ''          then Result.Add('  Frequency: ' + edtFrequency.Text + ' days');
  if edtMenarche.Text  <> ''           then Result.Add('  Menarche: ' + edtMenarche.Text + ' years old');
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
end;

function TDDCSVitals.GetEDDNote;
begin
  Result := TStringList.Create;

  if edtCurrentEDD.Text = '' then
    Exit;

  Result.Insert(0, 'ESTIMATED DELIVERY DATE:');

  Result.Add('  Final EDD: ' + edtCurrentEDD.Text);
  if edtEDDGA.Text <> '' then
    Result.Add('   Gestational Age for Final EDD: ' + edtEDDGA.Text);
  if edtFinalGA.Text <> '' then
    Result.Add('   Gestational Age Today: ' + edtFinalGA.Text);
  if ckFinalEDDLMP.Checked then
    Result.Add('   The current calculation is based on  a Last Menstrual Period of ' + DateToStr(dtLMP.Date) + '.')
  else if ckFinalEDDECD.Checked then
    Result.Add('   The current calculation is based on an Estimated Conception Date of ' + DateToStr(dtECD.Date) + '.')
  else if ckFinalEDDUltra.Checked then
    Result.Add('   The current calculation is based on an Ultrasound conducted on ' + DateToStr(dtUltra.Date) +
               ' with an estimated gestational age of ' + IntToStr(spnWeekUltra.Value) + ' weeks and ' +
               IntToStr(spnDayUltra.Value) + ' days.')
  else if ckFinalEDDEmbryo.Checked then
    Result.Add('   The current calculation is based on a ' + cbTransferDay.Text + '-day embryo transfer conducted on ' +
               DateToStr(dtEmbryo.Date) + '.')
  else if ckFinalEDDOther.Checked then
    Result.Add('   The current calculation is based on an EDD Criteria of ' + lblOther.Text +
               ' with an estimated gestational age of ' + IntToStr(spnWeekOther.Value) + ' weeks and ' +
               IntToStr(spnDayOther.Value) + ' days.')
  else if ckFinalEDDUnknown.Checked then
    Result.Add('   The current methodology for calculation is unknown.');
end;

function TDDCSVitals.GetCompleteNote;
begin
  Result := TStringList.Create;

  Result.AddStrings(GetVitalsNote);
  if fVitalsControl.Pages[1].TabVisible then
  begin
    Result.Add('');
    Result.AddStrings(GetEDDNote);
  end;
  if fVitalsControl.Pages[2].TabVisible then
  begin
    Result.Add('');
    Result.AddStrings(GetLMPNote);
  end;
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
//    sl.Add('EDD^' + lblLMP.Caption + U + DateToStr(dtLMP.Date) + U + edtWeekLMP.Text + 'w' +
//                    edtDayLMP.Text + 'd^' + edtEDDLMP.Text + U + ckBool(ckFinalEDDLMP));
//    sl.Add('EDD^' + lblECD.Caption + U + DateToStr(dtECD.Date) + U + edtWeekECD.Text + 'w' +
//                    edtDayECD.Text + 'd^' + edtEDDECD.Text + U + ckBool(ckFinalEDDECD));
    sl.Add('EDD^' + lblUltra.Caption + U + DateToStr(dtUltra.Date) + U + spnWeekUltra.Text + 'w' +
                    spnDayUltra.Text + 'd^' + edtEDDUltra.Text + U + ckBool(ckFinalEDDUltra));
//    sl.Add('EDD^' + lblEmbryo.Caption + U + DateToStr(dtEmbryo.Date) + U + edtWeekEmbryo.Text + 'w' +
//                    edtDayEmbryo.Text + 'd^' + edtEDDEmbryo.Text + U + ckBool(ckFinalEDDEmbryo));
    sl.Add('EDD^' + lblOther.Text + U + DateToStr(dtOther.Date) + U + spnWeekOther.Text + 'w' +
                    spnDayOther.Text + 'd^' + edtEDDOther.Text + U + ckBool(ckFinalEDDOther));
    sl.Add('EDD^' + lblUnknown.Caption + '^^^' + DateToStr(dtEDDUnknown.Date) + U + ckBool(ckFinalEDDUnknown));

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
      return := RPCBrokerV.sCallV('DSIO DDCS ORQQVI VITALS SAVE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, sl])
    except
    end;
  finally
    sl.Free;
  end;
end;

end.
