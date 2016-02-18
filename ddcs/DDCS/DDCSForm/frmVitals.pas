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
  System.StrUtils, uCommon, uExtndComBroker;

type
  TfVitals = class(TFrame)
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
    btnHistory: TButton;
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
    Button1: TButton;
    StaticText2: TStaticText;
    edtCurrentEDD: TEdit;
    EDDGrid: TGridPanel;
    dtLMP: TDateTimePicker;
    edtWeekLMP: TEdit;
    edtDayLMP: TEdit;
    edtEDDLMP: TEdit;
    lblLMP: TLabel;
    lblECD: TLabel;
    lblUltra: TLabel;
    dtECD: TDateTimePicker;
    edtWeekECD: TEdit;
    edtDayECD: TEdit;
    edtEDDECD: TEdit;
    dtUltra: TDateTimePicker;
    spnWeekUltra: TSpinEdit;
    spnDayUltra: TSpinEdit;
    edtEDDUltra: TEdit;
    dtEmbryo: TDateTimePicker;
    edtWeekEmbryo: TEdit;
    edtDayEmbryo: TEdit;
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
    spnTransferDay: TSpinEdit;
    ck_LMPQualifier: TCheckBox;
    procedure dtLMPChange(Sender: TObject);
    procedure dtUltraChange(Sender: TObject);
    procedure dtECDChange(Sender: TObject);
    procedure spnWeekUltraChange(Sender: TObject);
    procedure spnDayUltraChange(Sender: TObject);
    procedure dtOtherChange(Sender: TObject);
    procedure spnWeekOtherChange(Sender: TObject);
    procedure spnDayOtherChange(Sender: TObject);
    procedure dtEmbryoChange(Sender: TObject);
    procedure IsFinalEDDClick(Sender: TObject);
    procedure lblOtherMouseEnter(Sender: TObject);
    procedure spnTransferDayChange(Sender: TObject);
    procedure edtLMPChange(Sender: TObject);
    procedure sbtnGetDate1Click(Sender: TObject);
    procedure ckMensesYesClick(Sender: TObject);
    procedure dtEDDUnknownChange(Sender: TObject);
  private
    FNote: TStringList;
    function GetGestationalAge(FromDate: Extended): string;    // weeks^days
    procedure SetDayWeek(edtWeek,edtDay: TEdit; wk,dy: string; addweek,adday: Integer);
    procedure UpdateEDD;
    procedure UpdateLMP;
    procedure LMPChangeEvents(Switch: Boolean);
    procedure ToggleCB(cb1: TCheckBox; cb2: TCheckBox);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetVitalsNote: TStringList;
    function GetEDDNote: TStringList;
    function GetLMPNote: TStringList;
    function GetCompleteNote: TStringList;
    procedure Save;
  end;

  function GetPatientVitals: TStringList;
  function CreateInTab(AOwner: TComponent; Broker: PCPRSComBroker): TfVitals;

var
  FEDDLoad,FLMPLoad: Boolean;
  VitalForm: TfVitals;

implementation

{$R *.dfm}

uses
  udlgDATE;

function GetPatientVitals: TStringList;
// Array of vital ien^vital type^rate/value^date/time taken
begin
  Result := TStringList.Create;
  try
    RPCBrokerV.SetContext(MENU_CONTEXT);
    RPCBrokerV.tCallV(Result, 'DSIO DDCS ORQQVI VITALS', [RPCBrokerV.PatientDFN]);
  except
  end;
end;

function CreateInTab(AOwner: TComponent; Broker: PCPRSComBroker): TfVitals;
var
  VitalForm: TfVitals;
begin
  Result := nil;

  RPCBrokerV := Broker^;

  VitalForm := TfVitals.Create(AOwner);
  with VitalForm do
  begin
    Parent := TWinControl(AOwner);
    Name := 'ofrm1vitals';
    Align := alClient;
    Show;
  end;
  FEDDLoad := True; FLMPLoad := True;
  Result := VitalForm;
end;

procedure TfVitals.LMPChangeEvents(Switch: Boolean);
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

// ESTIMATED DATE OF DELIVERY --------------------------------------------------

// Gestational Age is the week/day difference from LMP to today
function TfVitals.GetGestationalAge(FromDate: Extended): string;
var
  GAgeDays,GAgeWeeks: Integer;
begin
  Result := '';
  GAgeDays := DaysBetween(Now, FromDate) + 1;  // added '+ 1' due to VA
  GAgeWeeks := Trunc(GAgeDays div 7);
  Result := IntToStr(GAgeWeeks) + U + IntToStr(GAgeDays - Trunc(GAgeWeeks * 7));
end;

procedure TfVitals.SetDayWeek(edtWeek,edtDay: TEdit; wk,dy: string; addweek,adday: Integer);
var
  wkI,dyI: Integer;
begin
  dyI := StrToIntDef(dy,0) + adday;
  wkI := StrToIntDef(wk,0) + addweek;

  if dyI > 6 then
  begin
    wkI := wkI + Trunc(dyI div 7);
    dyI := dyI - (Trunc(dyI div 7) * 7);
  end;

  edtDay.Text := IntToStr(dyI);
  edtWeek.Text := IntToStr(wkI);
end;

procedure TfVitals.spnTransferDayChange(Sender: TObject);
begin
  ckFinalEDDEmbryo.Checked := False;
  dtEmbryoChange(Sender);
end;

procedure TfVitals.UpdateEDD;
var
  EDD: TDateTime;
  Gstr: string;
begin
  EDD := IncDay(dtLMP.Date, 280);
  edtEDDLMP.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtLMP.Date);

  SetDayWeek(edtWeekLMP,edtDayLMP,Piece(Gstr,U,1),Piece(Gstr,U,2),0,0);
end;

// EDD by LMP is calculated by adding 280 days (40 weeks) to the first day of the last menstrual period.
procedure TfVitals.dtLMPChange(Sender: TObject);
begin
  ckFinalEDDLMP.Checked := False;

  UpdateEDD;

  if ((edtLMP.Text = '') or (dtLMP.Date <> StrToDate(edtLMP.Text))) then
  begin
    LMPChangeEvents(False);
    edtLMP.Text := DateToStr(dtLMP.Date);
    UpdateLMP;
    LMPChangeEvents(True);
  end;
end;

// EDD by Estimated Conception date by adding 266 days to the date of conception which is 2 weeks in by
// the date of conception
procedure TfVitals.dtECDChange(Sender: TObject);
var
  EDD: TDateTime;
  Gstr: string;
begin
  ckFinalEDDECD.Checked := False;

  EDD := IncDay(dtECD.Date, 266);
  edtEDDECD.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtECD.Date);
  SetDayWeek(edtWeekECD,edtDayECD,Piece(Gstr,U,1),Piece(Gstr,U,2),2,0);
end;

procedure TfVitals.dtEDDUnknownChange(Sender: TObject);
begin
  ckFinalEDDUnknown.Checked := False;
end;

// EDD by Ultrasound is taking the Ultrasound date and substracting the weeks/day to get the start
procedure TfVitals.dtUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  edtEDDUltra.Text := DateToStr(IncDay(IncDay(dtUltra.Date, - ((spnWeekUltra.Value * 7) + spnDayUltra.Value)), 280));
end;

procedure TfVitals.spnWeekUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnWeekUltra.Value < 0 then
    spnWeekUltra.Value := 0;

  dtUltraChange(Sender);
end;

procedure TfVitals.spnDayUltraChange(Sender: TObject);
begin
  ckFinalEDDUltra.Checked := False;

  if spnDayUltra.Value < 0 then
    spnDayUltra.Value := 0;

  if spnDayUltra.Value > 6 then
  begin
    spnWeekUltra.OnChange := nil;
    spnWeekUltra.Value := spnWeekUltra.Value + Trunc(spnDayUltra.Value div 7);
    spnDayUltra.Value := spnDayUltra.Value - (Trunc(spnDayUltra.Value div 7) * 7);
    spnWeekUltra.OnChange := dtUltraChange;
  end;

  dtUltraChange(Sender);
end;

// Date of 3-day embryo transfer is the date + 264
// Date of 5-day embryo (blast) transfer is the date + 261
procedure TfVitals.dtEmbryoChange(Sender: TObject);
var
  EDD: TDateTime;
  Gstr: string;
  blast,wk,dy: Integer;
begin
  ckFinalEDDEmbryo.Checked := False;

  if spnTransferDay.Value = 3 then
    blast := 2
  else
    blast := spnTransferDay.Value;

  EDD := IncDay(dtEmbryo.Date, (267 - blast));
  edtEDDEmbryo.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtEmbryo.Date);

  dy := StrToIntDef(Piece(Gstr,U,2),0) + spnTransferDay.Value;
//  if spnTransferDay.Value = 3 then       // Change due to the VA
  dy := dy - 1;


  wk := StrToIntDef(Piece(Gstr,U,1),0) + 2;
  if dy > 6 then
  begin
    wk := wk + Trunc(dy div 7);
    dy := dy - (Trunc(dy div 7) * 7);
  end;

  edtWeekEmbryo.Text := IntToStr(wk);
  edtDayEmbryo.Text := IntToStr(dy);
end;

procedure TfVitals.dtOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  edtEDDOther.Text := DateToStr(IncDay(IncDay(dtOther.Date, - ((spnWeekOther.Value * 7) + spnDayOther.Value)), 280));
end;

procedure TfVitals.spnWeekOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnWeekOther.Value < 0 then
    spnWeekOther.Value := 0;

  dtOtherChange(Sender);
end;

procedure TfVitals.spnDayOtherChange(Sender: TObject);
begin
  ckFinalEDDOther.Checked := False;

  if spnDayOther.Value < 0 then
    spnDayOther.Value := 0;

  if spnDayOther.Value > 6 then
  begin
    spnWeekOther.OnChange := nil;
    spnWeekOther.Value := spnWeekOther.Value + Trunc(spnDayOther.Value div 7);
    spnDayOther.Value := spnDayOther.Value - (Trunc(spnDayOther.Value div 7) * 7);
    spnWeekOther.OnChange := dtOtherChange;
  end;

  dtOtherChange(Sender);
end;

procedure TfVitals.lblOtherMouseEnter(Sender: TObject);
begin
  if lblOther.Text = 'Enter Other Criteria' then
    lblOther.Text := '';
end;

procedure TfVitals.IsFinalEDDClick(Sender: TObject);
var
  I,Row,daydiff: Integer;
  Checked: Boolean;

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

begin
  if not (Sender is TCheckBox) then
    Exit;

  StopChecked;

  Checked := False;

  for I := 1 to 6 do
  begin
    if not (Sender = TCheckBox(EDDGrid.ControlCollection.Controls[5, I])) then
      TCheckBox(EDDGrid.ControlCollection.Controls[5, I]).Checked := False
    else
      if TCheckBox(Sender).Checked then
      begin
        Checked := True;
        edtFinalGA.Text := '';
        edtCurrentEDD.Text := '';

        Row := EDDGrid.ControlCollection.Items[EDDGrid.ControlCollection.IndexOf(TControl(Sender))].Row;
        if Row < 6 then
          edtCurrentEDD.Text := TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text
        else
          edtCurrentEDD.Text := DateToStr(TDateTimePicker(EDDGrid.ControlCollection.Controls[4, Row]).Date);

        // Final GA
        if edtCurrentEDD.Text <> '' then
        begin
          // First get EDC then determine the Current GA with today's date
          case Row of
            1: edtFinalGA.Text := edtWeekLMP.Text + 'w ' + edtDayLMP.Text + 'd';         // LMP
            2: edtFinalGA.Text := edtWeekECD.Text + 'w ' + edtDayECD.Text + 'd';         // EDC
            3: edtFinalGA.Text := spnWeekUltra.Text + 'w ' + spnDayUltra.Text + 'd';     // Ultrasound
            4: edtFinalGA.Text := edtWeekEmbryo.Text + 'w ' + edtDayEmbryo.Text + 'd';   // Embryo Transfer
            5: edtFinalGA.Text := spnWeekOther.Text + 'w ' + spnDayOther.Text + 'd';     // Other
            6: begin                                                                     // Unknown
                 daydiff := DaysBetween(Today, IncDay(dtEDDUnknown.Date, -281));    // 281 from 280 due to VA
                 edtFinalGA.Text := IntToStr(Trunc(daydiff div 7)) + 'w ' + IntToStr(daydiff - (Trunc(daydiff div 7) * 7)) + 'd';
               end;
          end;
        end else
        begin
          edtFinalGA.Text := '';
          edtCurrentEDD.Text := '';
        end;
      end;
  end;

  if not checked then
  begin
    edtFinalGA.Text := '';
    edtCurrentEDD.Text := '';
  end;

  StartChecked;
end;

// MENSTRAL HISTORY ------------------------------------------------------------

procedure TfVitals.UpdateLMP;
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

procedure TfVitals.sbtnGetDate1Click(Sender: TObject);
var
  dlgGetDate: TdlgDate;
begin
  try
    dlgGetDate := TdlgDate.Create( Nil );
    dlgGetDate.ShowModal;
    if dlgGetDate.ModalResult = mrOK then
    begin    // choices by tag
    if(dlgGetDate.calMonth.Date) >  Now then
      ShowDialog(Owner, 'No future dates', mtWarning)
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

Procedure TfVitals.ToggleCB( cb1:TCheckBox; cb2:TCheckBox);
begin
  if cb1.Checked = True then
    cb2.Checked := False;
end;

procedure TfVitals.ckMensesYesClick(Sender: TObject);
{toggle check boxes }
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

procedure TfVitals.edtLMPChange(Sender: TObject);
var
  testDT: TDateTime;
begin
  if not TryStrToDate(edtLMP.Text,testDT) then
  begin
    edtLMP.Text := '';
    Exit;
  end;

  if ((edtLMP.Text <> '') and (StrToDate(edtLMP.Text) <> dtLMP.Date)) then
  begin
    LMPChangeEvents(False);
    UpdateLMP;
    dtLMP.Date := StrToDate(edtLMP.Text);
    UpdateEDD;
    LMPChangeEvents(True);
  end;
end;

// MAIN ------------------------------------------------------------------------

constructor TfVitals.Create(AOwner: TComponent);
var
  sl: TStringList;
  I: Integer;
  str: string;

  function strlengthen(str: string): string;
  begin
    Result := str;
    while Length(Result) < 50 do
      Result := Result + ' ';
  end;

begin
  inherited Create(AOwner);
  FNote := TStringList.Create;

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
  spnTransferDay.Value := 5;
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
        sl.AddStrings(GetPatientVitals);

        FNote.Add('VITAL SIGNS:');
        for I := 0 to sl.Count - 1 do
        begin
          if ((I = 0) and (sl[I] = '-1')) then Break;

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
        ShowDialog(Owner, E.Message, mtError);
      end;
    finally
      sl.Free;
    end;

    if FSex.Caption <> 'Sex: FEMALE' then
    begin
      fVitalsControl.Pages[1].TabVisible := False;
      fVitalsControl.Pages[2].TabVisible := False;
    end;
  end;

  fVitalsControl.ActivePageIndex := 0;
end;

function TfVitals.GetVitalsNote;
begin
  Result := TStringList.Create;
  Result := FNote;
end;

function TfVitals.GetLMPNote;
var
  I: Integer;
begin
  Result := TStringList.Create;
  Result.Clear;

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

function TfVitals.GetEDDNote;
begin
  Result := TStringList.Create;
  Result.Clear;

  if edtCurrentEDD.Text <> '' then
    Result.Add('  Current EDD: ' + edtCurrentEDD.Text);
  if edtFinalGA.Text <> '' then
    Result.Add('   Current GA: ' + edtFinalGA.Text);
  if edtEDDLMP.Text <> '' then
  begin
    Result.Add('   EDD Criteria of Last Menstrual Period');
    Result.Add('    Event Date: ' + DateToStr(dtLMP.Date));
    Result.Add('    Resulted in a gestational age of ' + edtWeekLMP.Text + ' wks and ' + edtDayLMP.Text + ' days.');
    Result.Add('    The calculated EDD is ' + edtEDDLMP.Text);
    if ckFinalEDDLMP.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;
  if edtEDDECD.Text <> '' then
  begin
    Result.Add('   EDD Criteria of Estimated Conception Date');
    Result.Add('    Event Date: ' + DateToStr(dtECD.Date));
    Result.Add('    Resulted in a gestational age of ' + edtWeekECD.Text + ' wks and ' + edtDayECD.Text + ' days.');
    Result.Add('    The calculated EDD is ' + edtEDDECD.Text);
    if ckFinalEDDECD.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;
  if edtEDDUltra.Text <> '' then
  begin
    Result.Add('   EDD Criteria of Ultrasound');
    Result.Add('    Event Date: ' + DateToStr(dtUltra.Date));
    Result.Add('    Resulted in a gestational age of ' + IntToStr(spnWeekUltra.Value) + ' wks and ' +
                   IntToStr(spnDayUltra.Value) + ' days.');
    Result.Add('    The calculated EDD is ' + edtEDDUltra.Text);
    if ckFinalEDDUltra.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;
  if edtEDDEmbryo.Text <> '' then
  begin
    Result.Add('   EDD Criteria of Embryo Transfer');
    Result.Add('    Event Date: ' + IntToStr(spnTransferDay.Value) + '-day embryo transfer conducted on ' +
                   DateToStr(dtEmbryo.Date));
    Result.Add('    Resulted in a gestational age of ' + edtWeekEmbryo.Text + ' wks and ' + edtDayEmbryo.Text + ' days.');
    Result.Add('    The calculated EDD is ' + edtEDDEmbryo.Text);
    if ckFinalEDDEmbryo.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;
  if ((edtEDDOther.Text <> '') and (lblOther.Text <> 'Enter Other Criteria')) then
  begin
    Result.Add('   EDD Criteria of ' + lblOther.Text);
    Result.Add('    Event Date: ' + DateToStr(dtOther.Date));
    Result.Add('    Resulted in a gestational age of ' + IntToStr(spnWeekOther.Value) + ' wks and ' +
                   IntToStr(spnDayOther.Value) + ' days.');
    Result.Add('    The calculated EDD is ' + edtEDDOther.Text);
    if ckFinalEDDOther.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;
  if ckFinalEDDUnknown.Checked then
  begin
    Result.Add('   It is unknown what methodology was used to determine EDD.');
    Result.Add('    The calculated EDD is ' + DateToStr(dtEDDUnknown.Date));
    if ckFinalEDDUnknown.Checked then
      Result[Result.Count - 1] := Result[Result.Count - 1] + ' and is Final.'
    else
      Result[Result.Count - 1] := Result[Result.Count - 1] + '.';
  end;

  if Result.Count > 0 then
    Result.Insert(0,'ESTIMATED DELIVERY DATE:');
end;

function TfVitals.GetCompleteNote;
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

procedure TfVitals.Save;
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
    sl.Add('EDD^' + lblLMP.Caption + U + DateToStr(dtLMP.Date) + U + edtWeekLMP.Text + 'w' +
                    edtDayLMP.Text + 'd^' + edtEDDLMP.Text + U + ckBool(ckFinalEDDLMP));
    sl.Add('EDD^' + lblECD.Caption + U + DateToStr(dtECD.Date) + U + edtWeekECD.Text + 'w' +
                    edtDayECD.Text + 'd^' + edtEDDECD.Text + U + ckBool(ckFinalEDDECD));
    sl.Add('EDD^' + lblUltra.Caption + U + DateToStr(dtUltra.Date) + U + spnWeekUltra.Text + 'w' +
                    spnDayUltra.Text + 'd^' + edtEDDUltra.Text + U + ckBool(ckFinalEDDUltra));
    sl.Add('EDD^' + lblEmbryo.Caption + U + DateToStr(dtEmbryo.Date) + U + edtWeekEmbryo.Text + 'w' +
                    edtDayEmbryo.Text + 'd^' + edtEDDEmbryo.Text + U + ckBool(ckFinalEDDEmbryo));
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

destructor TfVitals.Destroy;
begin
  FNote.Free;
  inherited Destroy;
end;

end.
