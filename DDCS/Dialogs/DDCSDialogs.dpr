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
  uDialog,
  uCommon,
  uExtndComBroker,
  udlgAbdomPain in 'udlgAbdomPain.pas' {dlgAbdomPain},
  udlgBackPain in 'udlgBackPain.pas' {dlgBackPain},
  udlgCoughCongest in 'udlgCoughCongest.pas' {dlgCoughCongest},
  udlgDATE in 'udlgDATE.pas' {dlgDate},
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
  udlgHistory in 'udlgHistory.pas' {dlgHistory},
  udlgEducation in 'udlgEducation.pas' {dlgEducation},
  fFamilyAdd in 'fFamilyAdd.pas' {frmFamilyAdd};

{$R *.res}

function RegisterDialogs: WideString; stdcall;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    RegisterClass(TdlgAbdomPain);              sl.Add('TdlgAbdomPain^udlgAbdomPain');
    RegisterClass(TdlgBackPain);               sl.Add('TdlgBackPain^udlgBackPain');
    RegisterClass(TdlgCoughCongest);           sl.Add('TdlgCoughCongest^udlgCoughCongest');
    RegisterClass(TdlgDate);                   sl.Add('TdlgDate^udlgDate');
    RegisterClass(TdlgFamily);                 sl.Add('TdlgFamily^udlgFamily');
    RegisterClass(TdlgFetalMov);               sl.Add('TdlgFetalMov^udlgFetalMov');
    RegisterClass(TdlgGenetic);                sl.Add('TdlgGenetic^udlgGenetic');
    RegisterClass(TdlgHeadache);               sl.Add('TdlgHeadache^udlgHeadache');
    RegisterClass(TdlgInfectHist);             sl.Add('TdlgInfectHist^udlgInfectHist');
    RegisterClass(TdlgLegPain);                sl.Add('TdlgLegPain^udlgLegPain');
    RegisterClass(TdlgMedical);                sl.Add('TdlgMedical^udlgMedical');
    RegisterClass(TdlgNausea);                 sl.Add('TdlgNausea^udlgNausea');
    RegisterClass(TdlgPelvic);                 sl.Add('TdlgPelvic^udlgPelvic');
    RegisterClass(TdlgOBSpread);               sl.Add('TdlgOBSpread^udlgOBSpread');
    RegisterClass(TdlgPalp);                   sl.Add('TdlgPalp^udlgPalp');
    // Pregnancy History ----------------------------------------------------------------------
    RegisterClass(TdlgPregHist);               sl.Add('TdlgPregHist^udlgPregHist');
    RegisterClass(TfrmPregHist);               sl.Add('TdlgPregHist^udlgPregHist');
    RegisterClass(TfrmChildHist);              sl.Add('TdlgPregHist^udlgPregHist');
    // ----------------------------------------------------------------------------------------
    RegisterClass(TdlgPreNatal);               sl.Add('TdlgPreNatal^udlgPreNatal');
    RegisterClass(TdlgRash);                   sl.Add('TdlgRash^udlgRash');
    RegisterClass(TdlgRTClinic);               sl.Add('TdlgRTClinic^udlgRTClinic');
    RegisterClass(TdlgSocial);                 sl.Add('TdlgSocial^udlgSocial');
    RegisterClass(TdlgSurgical);               sl.Add('TdlgSurgical^udlgSurgical');
    RegisterClass(TdlgVagBleed);               sl.Add('TdlgVagBleed^udlgVagBleed');
    RegisterClass(TdlgVagDischarge);           sl.Add('TdlgVagDischarge^udlgVagDischarge');
    RegisterClass(TdlgVisualChanges);          sl.Add('TdlgVisualChanges^udlgVisualChanges');
    RegisterClass(TdlgWheezing);               sl.Add('TdlgWheezing^udlgWheezing');
    RegisterClass(TdlgImmunizations);          sl.Add('TdlgImmunizations^udlgImmunizations');
    RegisterClass(TdlgPhysicalExam);           sl.Add('TdlgPhysicalExam^udlgPhysicalExam');
    RegisterClass(TdlgROS);                    sl.Add('TdlgROS^udlgROS');
    RegisterClass(TdlgHistory);                sl.Add('TdlgHistory^udlgHistory');
    RegisterClass(TdlgEducation);              sl.Add('TdlgEducation^udlgEducation');
  finally
    Result := sl.Text;
    sl.Free;
  end;
end;

function DisplayDialog(Broker: PCPRSComBroker; Build: WideString; DebugMode: Boolean): WideString; stdcall;
var
  sl: TStringList;
  dlg: ToCNTDialog;
  dlgClass: TDialogClass;

  // Build = IEN | NAME | CLASS

begin
  sl := TStringList.Create;
  try
    dlgClass := TDialogClass(FindClass(Piece(Build,'|',3)));
    dlg := dlgClass.Create(nil, Broker, DebugMode, Piece(Build,'|',1));
    try
      dlg.ShowModal;
      if dlg.ModalResult = mrOK then
        sl.AddStrings(dlg.TmpStrList);
    finally
      dlg.Free;
    end;
  finally
    Result := sl.Text;
    sl.Free;
  end;
end;

function GetDialogComponents(dlgName: WideString): WideString; stdcall;
var
  sl: TStringList;
  dlg: ToCNTDialog;
  dlgClass: TDialogClass;
  I: Integer;
begin
  sl := TStringList.Create;
  try
    dlgClass := TDialogClass(FindClass(dlgName));
    dlg := dlgClass.Create(nil);
    try
      for I := 0 to dlg.ComponentCount - 1 do
        sl.Add(dlg.Components[I].Name + U + dlg.Components[I].ClassName);
    finally
      dlg.Free;
    end;
  finally
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
