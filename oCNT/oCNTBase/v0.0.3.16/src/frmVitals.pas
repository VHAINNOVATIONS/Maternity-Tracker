unit frmVitals;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Math,
  System.Types, System.ConvUtils, System.StdConvs, Vcl.Samples.Spin, Vcl.ComCtrls,
  uExtndComBroker;

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
    StaticText1: TStaticText;
    PageEDD: TTabSheet;
    PageLMP: TTabSheet;
    procedure PageEDDShow(Sender: TObject);
    procedure PageLMPShow(Sender: TObject);
  private
    { Private declarations }
    FNote: TStringList;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetNote: TStringList;
    procedure SaveDialogs;
  end;

  function CreateInTab(AOwner: TComponent; Broker: PCPRSComBroker): TfVitals;

var
  FEDDLoad,FLMPLoad: Boolean;

implementation

uses
  oCNTBase;

var
  EDDForm,LMPForm: ToCNTDialog;

{$R *.dfm}

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

procedure TfVitals.SaveDialogs;
begin
  if Assigned(EDDForm) then
  begin
//    if Pos('SN',ToCNTDialog(EDDForm)) > 0 then
//    begin
//      if MessageDlg('EDD infromation will be submitted to VistA now; otherwise, click "NO".',
//                    mtWarning, mbYesNo, 0) = mrYes then
//      ToCNTDialog(EDDForm);
//    end else
    EDDForm.Save;
  end;
  if Assigned(LMPForm) then
  begin
//    if Pos('SN',ToCNTDialog(LMPForm).Action) > 0 then
//    begin
//      if MessageDlg('LMP infromation will be submitted to VistA now; otherwise, click "NO".',
//                    mtWarning, mbYesNo, 0) = mrYes then
//      ToCNTDialog(LMPForm).Save;
//    end else
    LMPForm.Save;
  end;
end;

function TfVitals.GetNote: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(FNote);
  Result.Add('');
  Result.AddStrings(EDDForm.OnGetTmpStrList);
  Result.Add('');
  Result.AddStrings(LMPForm.OnGetTmpStrList);
end;

procedure TfVitals.PageEDDShow(Sender: TObject);
begin
  if FEDDLoad and Assigned(EDDForm) then
  begin
    FEDDLoad := False;
    EDDForm.Show;
  end;
end;

procedure TfVitals.PageLMPShow(Sender: TObject);
begin
  if FLMPLoad and Assigned(LMPForm) then
  begin
    FLMPLoad := False;
    LMPForm.Show;
  end;
end;

constructor TfVitals.Create(AOwner: TComponent);
var
  sl: TStringList;
  I: Integer;

  function strlengthen(str: string): string;
  begin
    Result := str;
    while Length(Result) < 50 do
    Result := Result + ' ';
  end;

begin
  inherited Create(AOwner);
  FNote := TStringList.Create;

  if not (csDesigning in ComponentState) then
  begin
    fVitalsControl.Pages[1].Visible := False;
    fVitalsControl.Pages[2].Visible := False;

    sl := TStringList.Create;
    try
      try
        sl.AddStrings(RPCBrokerV.GetPatientVitals);
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
      except
        on E: Exception do
        ShowMessage(E.Message);
      end;
    finally
      sl.Free;
    end;

    if FSex.Caption = 'Sex: FEMALE' then
    begin
      fVitalsControl.Pages[1].TabVisible := True;
      fVitalsControl.Pages[2].TabVisible := True;

      if DialogDLL <> 0 then
      begin
        EDDForm := EmbedDialog(Pointer(fVitalsControl.Pages[1]), @RPCBrokerV, 'TdlgEstDelivDate', False)^;
        LMPForm := EmbedDialog(Pointer(fVitalsControl.Pages[2]), @RPCBrokerV, 'TdlgMenstHist', False)^;
      end;
    end;
  end;

  fVitalsControl.ActivePageIndex := 0;
end;

destructor TfVitals.Destroy;
begin
  FNote.Free;
  inherited Destroy;
end;

end.
