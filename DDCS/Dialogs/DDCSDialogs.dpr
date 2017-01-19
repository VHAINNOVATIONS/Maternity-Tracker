library DDCSDialogs;

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

{$R *.dres}

uses
  Winapi.Windows,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  uBase,
  DDCSUtils,
  DDCSComBroker,
  udlgAbdomPain in 'udlgAbdomPain.pas' {dlgAbdomPain},
  udlgBackPain in 'udlgBackPain.pas' {dlgBackPain},
  udlgCoughCongest in 'udlgCoughCongest.pas' {dlgCoughCongest},
  udlgFamily in 'udlgFamily.pas' {dlgFamily},
  udlgFetalMov in 'udlgFetalMov.pas' {dlgFetalMov},
  udlgHeadache in 'udlgHeadache.pas' {dlgHeadache},
  udlgInfectHist in 'udlgInfectHist.pas' {dlgInfectHist},
  udlgLegPain in 'udlgLegPain.pas' {dlgLegPain},
  udlgMedical in 'udlgMedical.pas' {dlgMedical},
  udlgNausea in 'udlgNausea.pas' {dlgNausea},
  udlgPalp in 'udlgPalp.pas' {dlgPalp},
  udlgRash in 'udlgRash.pas' {dlgRash},
  udlgRTClinic in 'udlgRTClinic.pas' {dlgRTClinic},
  udlgSocial in 'udlgSocial.pas' {dlgSocial},
  udlgVagBleed in 'udlgVagBleed.pas' {dlgVagBleed},
  udlgVagDischarge in 'udlgVagDischarge.pas' {dlgVagDischarge},
  udlgVisualChanges in 'udlgVisualChanges.pas' {dlgVisualChanges},
  udlgWheezing in 'udlgWheezing.pas' {dlgWheezing},
  udlgPelvic in 'udlgPelvic.pas' {dlgPelvic},
  udlgPregHist in 'udlgPregHist.pas' {dlgPregHist},
  udlgGenetic in 'udlgGenetic.pas' {dlgGenetic},
  udlgSurgical in 'udlgSurgical.pas' {dlgSurgical},
  udlgOBSpread in 'udlgOBSpread.pas' {dlgOBSpread},
  udlgImmunizations in 'udlgImmunizations.pas' {dlgImmunizations},
  udlgROS in 'udlgROS.pas' {dlgROS},
  udlgEducation in 'udlgEducation.pas' {dlgEducation},
  frmPregHistPreg in 'frmPregHistPreg.pas' {fPreg: TFrame},
  frmPregHistChild in 'frmPregHistChild.pas' {fChild: TFrame},
  frmPregHistPregInfo in 'frmPregHistPregInfo.pas' {fPregInfo: TFrame},
  uDialog in 'uDialog.pas',
  udlgPhysicalExam in 'udlgPhysicalExam.pas' {dlgPhysicalExam};

{$R *.res}

procedure RegisterDialogs(out Return: WideString); stdcall;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    RegisterClass(TdlgAbdomPain);              sl.Add('TdlgAbdomPain^udlgAbdomPain');
    RegisterClass(TdlgBackPain);               sl.Add('TdlgBackPain^udlgBackPain');
    RegisterClass(TdlgCoughCongest);           sl.Add('TdlgCoughCongest^udlgCoughCongest');
    RegisterClass(TdlgEducation);              sl.Add('TdlgEducation^udlgEducation');
    RegisterClass(TdlgFamily);                 sl.Add('TdlgFamily^udlgFamily');
    RegisterClass(TdlgFetalMov);               sl.Add('TdlgFetalMov^udlgFetalMov');
    RegisterClass(TdlgGenetic);                sl.Add('TdlgGenetic^udlgGenetic');
    RegisterClass(TdlgHeadache);               sl.Add('TdlgHeadache^udlgHeadache');
    RegisterClass(TdlgImmunizations);          sl.Add('TdlgImmunizations^udlgImmunizations');
    RegisterClass(TdlgInfectHist);             sl.Add('TdlgInfectHist^udlgInfectHist');
    RegisterClass(TdlgLegPain);                sl.Add('TdlgLegPain^udlgLegPain');
    RegisterClass(TdlgMedical);                sl.Add('TdlgMedical^udlgMedical');
    RegisterClass(TdlgNausea);                 sl.Add('TdlgNausea^udlgNausea');
    RegisterClass(TdlgOBSpread);               sl.Add('TdlgOBSpread^udlgOBSpread');
    RegisterClass(TdlgPalp);                   sl.Add('TdlgPalp^udlgPalp');
    RegisterClass(TdlgPelvic);                 sl.Add('TdlgPelvic^udlgPelvic');
    RegisterClass(TdlgPhysicalExam);           sl.Add('TdlgPhysicalExam^udlgPhysicalExam');
    RegisterClass(TdlgPregHist);               sl.Add('TdlgPregHist^udlgPregHist');
    RegisterClass(TdlgRash);                   sl.Add('TdlgRash^udlgRash');
    RegisterClass(TdlgROS);                    sl.Add('TdlgROS^udlgROS');
    RegisterClass(TdlgRTClinic);               sl.Add('TdlgRTClinic^udlgRTClinic');
    RegisterClass(TdlgSocial);                 sl.Add('TdlgSocial^udlgSocial');
    RegisterClass(TdlgSurgical);               sl.Add('TdlgSurgical^udlgSurgical');
    RegisterClass(TdlgVagBleed);               sl.Add('TdlgVagBleed^udlgVagBleed');
    RegisterClass(TdlgVagDischarge);           sl.Add('TdlgVagDischarge^udlgVagDischarge');
    RegisterClass(TdlgVisualChanges);          sl.Add('TdlgVisualChanges^udlgVisualChanges');
    RegisterClass(TdlgWheezing);               sl.Add('TdlgWheezing^udlgWheezing');
  finally
    Return := sl.Text;
    sl.Free;
  end;
end;

procedure GetDialogComponents(dlgName: WideString; out Return: WideString); stdcall;
var
  dlgP: TPersistentClass;
  dlgClass: TDialogClass;
  dlg: TDDCSDialog;
  sl: TStringList;
  I: Integer;

  // Return --------------------------------------------------------------------
  //   (H) - CONTROL ^ CONTROL_NAME ^ CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION

begin
  if dlgName = '' then
    Exit;
  dlgP := FindClass(dlgName);
  if dlgP = nil then
    Exit;
  dlgClass := TDialogClass(dlgP);
  if dlgClass = nil then
    Exit;

  dlg := dlgClass.Create;
  try
    sl := TStringList.Create;
    try
      for I := 0 to dlg.ComponentCount - 1 do
      begin
        sl.Add('H^' + dlg.Components[I].Name + U + dlg.Components[I].ClassName);
        // sl.Add('C^' + dlg.Components[I].Name + U);    // This would be updated by DDCSFramework configuration
        // sl.Add('R^' + dlg.Components[I].Name + U);    // Once this is enabled you will be able to pass it to VistA
      end;
      Return := sl.Text;
    finally
      sl.Free;
    end;
  finally
    dlg.Free;
  end;
end;

function DisplayDialog(const Broker: PCPRSComBroker; Build: WideString; DebugMode: Boolean; sTheme: WideString;
                       out rSave,rConfig,rText: WideString): WordBool; stdcall;
var
  dlgP: TPersistentClass;
  dlgClass: TDialogClass;
  dlg: TDDCSDialog;
  sl: TStringList;
  hp,hhp,I: Integer;
  wControl: TWinControl;

  // Build = IEN | NAME | CLASS

begin
  Result := False;

  if Piece(Build,'|',3) = '' then
    Exit;
  dlgP := FindClass(Piece(Build,'|',3));
  if dlgP = nil then
    Exit;
  dlgClass := TDialogClass(dlgP);
  if dlgClass = nil then
    Exit;

  dlg := dlgClass.Create(Broker, Piece(Build,'|',1), DebugMode, sTheme);
  try
    if DebugMode then
    begin
      hp  := Application.HintPause;
      hhp := Application.HintHidePause;

      Application.HintPause := 0;
      Application.HintHidePause := 1000000000;

      dlg.ShowHint := True;

      for I := 0 to dlg.ComponentCount - 1 do
        if dlg.Components[I] is TWinControl then
        begin
          wControl := TWinControl(dlg.Components[I]);
          wControl.Hint := dlg.Components[I].Name;
        end;
    end;

    dlg.ShowModal;
    if dlg.ModalResult = mrOK then
    begin
      Result := True;

      sl := TStringList.Create;
      try
        dlg.BuildSaveList(sl);
        if sl.Count > 0 then
          rSave := sl.Text;
        sl.Clear;
        dlg.Configuration.GetCollectiveText(sl);
        if sl.Count > 0 then
          rConfig := sl.Text;
      finally
        sl.Free;
      end;

      rText := dlg.TmpStrList.Text;
    end;

    if DebugMode then
    begin
      Application.HintPause := hp;
      Application.HintHidePause := hhp;
    end;
  finally
    dlg.Free;
  end;
end;

exports
  RegisterDialogs,
  GetDialogComponents,
  DisplayDialog;

begin
end.
