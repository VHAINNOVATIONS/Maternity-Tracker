unit udlgEstDelivDate;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, System.DateUtils,
  Vcl.Samples.Spin, oCNTBase, uExtndComBroker;

type
  TdlgEstDelivDate = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
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
    lblEmbryo: TLabel;
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
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    ckFinalEDDLMP: TCheckBox;
    ckFinalEDDECD: TCheckBox;
    ckFinalEDDUltra: TCheckBox;
    ckFinalEDDEmbryo: TCheckBox;
    ckFinalEDDOther: TCheckBox;
    ckFinalEDDUnknown: TCheckBox;
    dtEDDUnknown: TDateTimePicker;
    spnTransferDay: TSpinEdit;
    edtCurrentEDD: TEdit;
    StaticText1: TStaticText;
    btnHistory: TButton;
    procedure FormCreate(Sender: TObject);
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
    procedure EDDGridResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
  private
    function GetGestationalAge(FromDate: TDateTime): string;    // weeks^days
    procedure SetDayWeek(edtWeek,edtDay: TEdit; wk,dy: string; addweek,adday: Integer);
  public
    function GetTmpStrList: TStringList;
    procedure UpdateLMP;
  end;

var
  dlgEstDelivDate: TdlgEstDelivDate;

implementation

uses
   udlgDATE, udlgMenstHist;

{$R *.dfm}

function TdlgEstDelivDate.GetTmpStrList;
begin
  TmpStrList.Clear;
  Result := TmpStrList;

  if edtCurrentEDD.Text <> '' then
  TmpStrList.Add('  Current EDD: ' + edtCurrentEDD.Text);
  if edtEDDLMP.Text <> '' then
  begin
    TmpStrList.Add('   EDD Criteria of Last Menstrual Period');
    TmpStrList.Add('    Event Date: ' + DateToStr(dtLMP.Date));
    TmpStrList.Add('    Resulted in a gestational age of ' + edtWeekLMP.Text + ' wks and ' + edtDayLMP.Text + ' days.');
    TmpStrList.Add('    The calculated EDD is ' + edtEDDLMP.Text);
    if ckFinalEDDLMP.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;
  if edtEDDECD.Text <> '' then
  begin
    TmpStrList.Add('   EDD Criteria of Estimated Conception Date');
    TmpStrList.Add('    Event Date: ' + DateToStr(dtECD.Date));
    TmpStrList.Add('    Resulted in a gestational age of ' + edtWeekECD.Text + ' wks and ' + edtDayECD.Text + ' days.');
    TmpStrList.Add('    The calculated EDD is ' + edtEDDECD.Text);
    if ckFinalEDDECD.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;
  if edtEDDUltra.Text <> '' then
  begin
    TmpStrList.Add('   EDD Criteria of Ultrasound');
    TmpStrList.Add('    Event Date: ' + DateToStr(dtUltra.Date));
    TmpStrList.Add('    Resulted in a gestational age of ' + IntToStr(spnWeekUltra.Value) + ' wks and ' +
                   IntToStr(spnDayUltra.Value) + ' days.');
    TmpStrList.Add('    The calculated EDD is ' + edtEDDUltra.Text);
    if ckFinalEDDUltra.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;
  if edtEDDEmbryo.Text <> '' then
  begin
    TmpStrList.Add('   EDD Criteria of Embryo Transfer');
    TmpStrList.Add('    Event Date: ' + IntToStr(spnTransferDay.Value) + '-day embryo transfer conducted on ' +
                   DateToStr(dtEmbryo.Date));
    TmpStrList.Add('    Resulted in a gestational age of ' + edtWeekEmbryo.Text + ' wks and ' + edtDayEmbryo.Text + ' days.');
    TmpStrList.Add('    The calculated EDD is ' + edtEDDEmbryo.Text);
    if ckFinalEDDEmbryo.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;
  if ((edtEDDOther.Text <> '') and (lblOther.Text <> 'Enter Other Criteria')) then
  begin
    TmpStrList.Add('   EDD Criteria of ' + lblOther.Text);
    TmpStrList.Add('    Event Date: ' + DateToStr(dtOther.Date));
    TmpStrList.Add('    Resulted in a gestational age of ' + IntToStr(spnWeekOther.Value) + ' wks and ' +
                   IntToStr(spnDayOther.Value) + ' days.');
    TmpStrList.Add('    The calculated EDD is ' + edtEDDOther.Text);
    if ckFinalEDDOther.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;
  if ckFinalEDDUnknown.Checked then
  begin
    TmpStrList.Add('   It is unknown what methodology was used to determine EDD.');
    TmpStrList.Add('    The calculated EDD is ' + DateToStr(dtEDDUnknown.Date));
    if ckFinalEDDUnknown.Checked then
    TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + ' and is Final.'
    else TmpStrList[TmpStrList.Count - 1] := TmpStrList[TmpStrList.Count - 1] + '.';
  end;

  if TmpStrList.Count > 0 then
  TmpStrList.Insert(0,'ESTIMATED DELIVERY DATE:');
end;

procedure TdlgEstDelivDate.bbtnOKClick(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.AddStrings(GetTmpStrList);
  finally
    sl.Free;
  end;
end;

procedure TdlgEstDelivDate.FormCreate(Sender: TObject);
begin
  // Needed for embedding
  Self.OnGetTmpStrList := GetTmpStrList;

  dtLMP.Format := 'MM/dd/yyyy';
  dtLMP.DateTime := Now;
//  dtLMPChange(Sender);
  dtECD.Format := 'MM/dd/yyyy';
  dtECD.DateTime := Now;
//  dtECDChange(Sender);
  dtUltra.Format := 'MM/dd/yyyy';
  dtUltra.DateTime := Now;
//  dtUltraChange(Sender);
  dtEmbryo.Format := 'MM/dd/yyyy';
  dtEmbryo.DateTime := Now;
//  dtEmbryoChange(Sender);
  dtOther.Format := 'MM/dd/yyyy';
  dtOther.DateTime := Now;
//  dtOtherChange(Sender);
  dtEDDUnknown.Format := 'MM/dd/yyyy';
  dtEDDUnknown.DateTime := Now;
end;

procedure TdlgEstDelivDate.FormShow(Sender: TObject);
begin
  // need this to align the spnTransferDay with its row
  Width := Width + 1;
  Width := Width - 1;
end;

procedure TdlgEstDelivDate.EDDGridResize(Sender: TObject);
begin
  spnTransferDay.Top := EDDGrid.Top + EDDGrid.Height - (EDDGrid.CellSize[0,6].Y + EDDGrid.CellSize[0,5].Y +
                        (EDDGrid.CellSize[0,4].Y div 2)) - 10;
  spnTransferDay.Left := EDDGrid.Left + (EDDGrid.CellSize[0,4].X div 2) + 14;
end;

// Gestational Age is the week/day difference from LMP to today
function TdlgEstDelivDate.GetGestationalAge(FromDate: TDateTime): string;
var
  GAgeDays,GAgeWeeks: Integer;

begin
  Result := '';
  GAgeDays := DaysBetween(Now, FromDate);
  GAgeWeeks := Trunc(GAgeDays div 7);
  Result := IntToStr(GAgeWeeks) + U + IntToStr(GAgeDays - Trunc(GAgeWeeks * 7));
end;

procedure TdlgEstDelivDate.SetDayWeek(edtWeek,edtDay: TEdit; wk,dy: string; addweek,adday: Integer);
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

// EDD by LMP is calculated by adding 280 days (40 weeks) to the first day of the last menstrual period.
procedure TdlgEstDelivDate.dtLMPChange(Sender: TObject);
var
  EDD: TDateTime;
  Gstr: string;
  I,J: Integer;

begin
  EDD := IncDay(dtLMP.Date, 280);
  edtEDDLMP.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtLMP.Date);

  if Parent.ClassName = 'TTabSheet' then
  begin
    for I := 0 to TTabSheet(Parent).PageControl.PageCount - 1 do
    begin
      for J := 0 to TTabSheet(Parent).PageControl.Pages[I].ControlCount - 1 do
      if TTabSheet(Parent).PageControl.Pages[I].Controls[J].ClassName = 'TdlgMenstHist' then
      if TdlgMenstHist(TTabSheet(Parent).PageControl.Pages[I].Controls[J]).edtLMP.Text <> DateToStr(dtLMP.Date) then
      TdlgMenstHist(TTabSheet(Parent).PageControl.Pages[I].Controls[J]).UpdateLMP(Datetostr(dtLMP.Date));
    end;
  end;

  SetDayWeek(edtWeekLMP,edtDayLMP,Piece(Gstr,U,1),Piece(Gstr,U,2),0,0);
end;

procedure TdlgEstDelivDate.UpdateLMP;
begin
  dtLMPChange(nil);
end;

// EDD by Estimated Conception date by adding 266 days to the date of conception which is 2 weeks in by
// the date of conception
procedure TdlgEstDelivDate.dtECDChange(Sender: TObject);
var
  EDD: TDateTime;
  Gstr: string;

begin
  EDD := IncDay(dtECD.Date, 266);
  edtEDDECD.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtECD.Date);
  SetDayWeek(edtWeekECD,edtDayECD,Piece(Gstr,U,1),Piece(Gstr,U,2),2,0);
end;

// EDD by Ultrasound is taking the Ultrasound date and substracting the weeks/day to get the start
procedure TdlgEstDelivDate.dtUltraChange(Sender: TObject);
begin
  edtEDDUltra.Text := DateToStr(IncDay(IncDay(dtUltra.Date, - ((spnWeekUltra.Value * 7) + spnDayUltra.Value)), 280));
end;

procedure TdlgEstDelivDate.spnWeekUltraChange(Sender: TObject);
begin
  if spnWeekUltra.Value < 0 then
  spnWeekUltra.Value := 0;

  dtUltraChange(Sender);
end;

procedure TdlgEstDelivDate.spnDayUltraChange(Sender: TObject);
begin
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
procedure TdlgEstDelivDate.dtEmbryoChange(Sender: TObject);
var
  EDD: TDateTime;
  Gstr: string;
  blast,wk,dy: Integer;

begin
  if spnTransferDay.Value = 3 then blast := 2
  else blast := spnTransferDay.Value;

  EDD := IncDay(dtEmbryo.Date, (266 - blast));
  edtEDDEmbryo.Text := DateToStr(EDD);
  Gstr := GetGestationalAge(dtEmbryo.Date);

  dy := StrToIntDef(Piece(Gstr,U,2),0) + spnTransferDay.Value;
  if spnTransferDay.Value = 3 then dy := dy - 1;
  wk := StrToIntDef(Piece(Gstr,U,1),0) + 2;
  if dy > 6 then
  begin
    wk := wk + Trunc(dy div 7);
    dy := dy - (Trunc(dy div 7) * 7);
  end;

  edtWeekEmbryo.Text := IntToStr(wk);
  edtDayEmbryo.Text := IntToStr(dy);
end;

procedure TdlgEstDelivDate.spnTransferDayChange(Sender: TObject);
begin
  dtEmbryoChange(Sender);
end;

procedure TdlgEstDelivDate.dtOtherChange(Sender: TObject);
begin
  edtEDDOther.Text := DateToStr(IncDay(IncDay(dtOther.Date, - ((spnWeekOther.Value * 7) + spnDayOther.Value)), 280));
end;

procedure TdlgEstDelivDate.spnWeekOtherChange(Sender: TObject);
begin
  if spnWeekOther.Value < 0 then
  spnWeekOther.Value := 0;

  dtOtherChange(Sender);
end;

procedure TdlgEstDelivDate.spnDayOtherChange(Sender: TObject);
begin
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

procedure TdlgEstDelivDate.lblOtherMouseEnter(Sender: TObject);
begin
  if lblOther.Text = 'Enter Other Criteria' then
  lblOther.Text := '';
end;

// checkboxes ------------------------------------------------------------------

procedure TdlgEstDelivDate.IsFinalEDDClick(Sender: TObject);
var
  I,Row: Integer;
begin
  if not (Sender is TCheckBox) then Exit;
  if not TCheckBox(Sender).Checked then Exit;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TCheckBox then
    if ((Components[I].Tag = 9) and not (Sender = Components[I])) then
    TCheckBox(Components[I]).Checked := False
    else
    begin
      Row := EDDGrid.ControlCollection.Items[EDDGrid.ControlCollection.IndexOf(TControl(Sender))].Row;
      if Row < 6 then
      edtCurrentEDD.Text := TEdit(EDDGrid.ControlCollection.Controls[4, Row]).Text
      else edtCurrentEDD.Text := DateToStr(TDateTimePicker(EDDGrid.ControlCollection.Controls[4, Row]).Date);
    end;
  end;
end;

end.
