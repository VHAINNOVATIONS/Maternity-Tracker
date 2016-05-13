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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  VAUtils,
  uDialog,
  uCommon,
  uExtndComBroker,
  udlgAbdomPain in 'udlgAbdomPain.pas' {dlgAbdomPain},
  udlgBackPain in 'udlgBackPain.pas' {dlgBackPain},
  udlgCoughCongest in 'udlgCoughCongest.pas' {dlgCoughCongest},
  udlgFamily in 'udlgFamily.pas' {dlgFamily},
  udlgFetalMov in 'udlgFetalMov.pas' {dlgFetalMov},
  udlgHeadache in 'udlgHeadache.pas' {dlgHeadache},
  udlgInfectHist in 'udlgInfectHist.pas' {dlgInfectHist},
  udlgLegPain in 'udlgLegPain.pas' {dlgLegPain},
  udlgMedical in 'udlgMedical.pas' {dlgMedical},
  udlgModTotPregs in 'udlgModTotPregs.pas' {dlgModTotPregs},
  udlgNausea in 'udlgNausea.pas' {dlgNausea},
  udlgPalp in 'udlgPalp.pas' {dlgPalp},
  udlgPreNatal in 'udlgPreNatal.pas' {dlgPreNatal},
  udlgRash in 'udlgRash.pas' {dlgRash},
  udlgRTClinic in 'udlgRTClinic.pas' {dlgRTClinic},
  udlgSocial in 'udlgSocial.pas' {dlgSocial},
  udlgVagBleed in 'udlgVagBleed.pas' {dlgVagBleed},
  udlgVagDischarge in 'udlgVagDischarge.pas' {dlgVagDischarge},
  udlgVisualChanges in 'udlgVisualChanges.pas' {dlgVisualChanges},
  udlgWheezing in 'udlgWheezing.pas' {dlgWheezing},
  udlgPelvic in 'udlgPelvic.pas' {dlgPelvic},
  udlgPregHist in 'udlgPregHist.pas' {dlgPregHist},
  fPregHist in 'fPregHist.pas' {frmPregHist},
  fChildHist in 'fChildHist.pas' {frmChildHist},
  udlgGenetic in 'udlgGenetic.pas' {dlgGenetic},
  udlgSurgical in 'udlgSurgical.pas' {dlgSurgical},
  udlgOBSpread in 'udlgOBSpread.pas' {dlgOBSpread},
  udlgImmunizations in 'udlgImmunizations.pas' {dlgImmunizations},
  udlgROS in 'udlgROS.pas' {dlgROS},
  udlgPhysicalExam in 'udlgPhysicalExam.pas' {dlgPhysicalExam},
  udlgEducation in 'udlgEducation.pas' {dlgEducation},
  fFamilyAdd in 'fFamilyAdd.pas' {frmFamilyAdd};

{$R *.res}

function RegisterDialogs: WideString; stdcall;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    RegisterClass(TdlgAbdomPain);              sl.Add('TdlgAbdomPain^udlgAbdomPain');              // v2
    RegisterClass(TdlgBackPain);               sl.Add('TdlgBackPain^udlgBackPain');                // v2
    RegisterClass(TdlgCoughCongest);           sl.Add('TdlgCoughCongest^udlgCoughCongest');        // v2
    RegisterClass(TdlgFamily);                 sl.Add('TdlgFamily^udlgFamily');                    // broken
    RegisterClass(TdlgFetalMov);               sl.Add('TdlgFetalMov^udlgFetalMov');                // v2
    RegisterClass(TdlgGenetic);                sl.Add('TdlgGenetic^udlgGenetic');
    RegisterClass(TdlgHeadache);               sl.Add('TdlgHeadache^udlgHeadache');                // v2
    RegisterClass(TdlgInfectHist);             sl.Add('TdlgInfectHist^udlgInfectHist');            // v2
    RegisterClass(TdlgLegPain);                sl.Add('TdlgLegPain^udlgLegPain');                  // v2
    RegisterClass(TdlgMedical);                sl.Add('TdlgMedical^udlgMedical');                  // broken
    RegisterClass(TdlgNausea);                 sl.Add('TdlgNausea^udlgNausea');                    // v2
    RegisterClass(TdlgPelvic);                 sl.Add('TdlgPelvic^udlgPelvic');                    // v2
    RegisterClass(TdlgOBSpread);               sl.Add('TdlgOBSpread^udlgOBSpread');
    RegisterClass(TdlgPalp);                   sl.Add('TdlgPalp^udlgPalp');                        // v2
    // Pregnancy History ------------------------------------------------------------------------- // broken
    RegisterClass(TdlgPregHist);               sl.Add('TdlgPregHist^udlgPregHist');                // -
    RegisterClass(TfrmPregHist);               sl.Add('TdlgPregHist^udlgPregHist');                // - build into parent
    RegisterClass(TfrmChildHist);              sl.Add('TdlgPregHist^udlgPregHist');                // - build into parent
    // ------------------------------------------------------------------------------------------- // -
    RegisterClass(TdlgPreNatal);               sl.Add('TdlgPreNatal^udlgPreNatal');
    RegisterClass(TdlgRash);                   sl.Add('TdlgRash^udlgRash');                        // v2
    RegisterClass(TdlgRTClinic);               sl.Add('TdlgRTClinic^udlgRTClinic');                // v2
    RegisterClass(TdlgSocial);                 sl.Add('TdlgSocial^udlgSocial');                    // broken
    RegisterClass(TdlgSurgical);               sl.Add('TdlgSurgical^udlgSurgical');
    RegisterClass(TdlgVagBleed);               sl.Add('TdlgVagBleed^udlgVagBleed');                // v2
    RegisterClass(TdlgVagDischarge);           sl.Add('TdlgVagDischarge^udlgVagDischarge');        // v2
    RegisterClass(TdlgVisualChanges);          sl.Add('TdlgVisualChanges^udlgVisualChanges');      // v2
    RegisterClass(TdlgWheezing);               sl.Add('TdlgWheezing^udlgWheezing');                // v2
    RegisterClass(TdlgImmunizations);          sl.Add('TdlgImmunizations^udlgImmunizations');      // broken
    RegisterClass(TdlgPhysicalExam);           sl.Add('TdlgPhysicalExam^udlgPhysicalExam');
    RegisterClass(TdlgROS);                    sl.Add('TdlgROS^udlgROS');                          // v2
    RegisterClass(TdlgEducation);              sl.Add('TdlgEducation^udlgEducation');              // v2
  finally
    Result := sl.Text;
    sl.Free;
  end;
end;

function DisplayDialog(Broker: PCPRSComBroker; Build: WideString; DebugMode: Boolean): WideString; stdcall;
var
  dlgP: TPersistentClass;
  dlgClass: TDialogClass;
  dlg: TDDCSDialog;

  // Build = IEN | NAME | CLASS

begin
  Result := '';

  if Piece(Build,'|',3) = '' then
    Exit;
  dlgP := FindClass(Piece(Build,'|',3));
  if dlgP = nil then
    Exit;
  dlgClass := TDialogClass(dlgP);
  if dlgClass = nil then
    Exit;

  dlg := dlgClass.Create(nil, Broker, DebugMode, Piece(Build,'|',1));
  try
    dlg.ShowModal;

    if dlg.ModalResult = mrOK then
      Result := dlg.TmpStrList.Text;
  finally
    dlg.Free;
  end;
end;

function GetDialogComponents(dlgName: WideString): WideString; stdcall;
var
  dlgP: TPersistentClass;
  dlgClass: TDialogClass;
  dlg: TDDCSDialog;
  sl: TStringList;
  I: Integer;

  // Return --------------------------------------------------------------------
  //   (H) - CONTROL ^ CONTROL_NAME ^ CONTROL_CLASS ^ PUSH ^ ID ^ OBSERVATION

begin
  Result := '';

  if dlgName = '' then
    Exit;
  dlgP := FindClass(dlgName);
  if dlgP = nil then
    Exit;
  dlgClass := TDialogClass(dlgP);
  if dlgClass = nil then
    Exit;

  sl := TStringList.Create;
  dlg := dlgClass.Create(nil);
  try
    for I := 0 to dlg.ComponentCount - 1 do
    begin
      sl.Add('H^' + dlg.Components[I].Name + U + dlg.Components[I].ClassName);
      // sl.Add('C^' + dlg.Components[I].Name + U);    // This would be updated by DDCSFramework configuration
      // sl.Add('R^' + dlg.Components[I].Name + U);    // Once this is enabled you will be able to pass it to VistA
    end;
  finally
    dlg.Free;
    Result := sl.Text;
    sl.Free;
  end;
end;

exports
  RegisterDialogs,
  DisplayDialog,
  GetDialogComponents;

begin
end.
