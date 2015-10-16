library DDCSDialogs;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  Windows,
  SysUtils,
  Classes,
  Forms,
  Controls,
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
  CPRSChart_TLB in '..\..\..\Documents\RAD Studio\11.0\Imports\CPRSChart_TLB.pas',
  udlgModTotPregsConfirm in 'udlgModTotPregsConfirm.pas' {dlgModTotPregsConfirm},
  fFamilyAdd in 'fFamilyAdd.pas' {frmFamilyAdd};

{$R *.res}

function RegisterDialogs: TStringList; stdcall;
begin
  Result := TStringList.Create;

  RegisterClass(TdlgAbdomPain);              Result.Add('TdlgAbdomPain^udlgAbdomPain');
  RegisterClass(TdlgBackPain);               Result.Add('TdlgBackPain^udlgBackPain');
  RegisterClass(TdlgCoughCongest);           Result.Add('TdlgCoughCongest^udlgCoughCongest');
  RegisterClass(TdlgDate);                   Result.Add('TdlgDate^udlgDate');
  RegisterClass(TdlgFamily);                 Result.Add('TdlgFamily^udlgFamily');
  RegisterClass(TdlgFetalMov);               Result.Add('TdlgFetalMov^udlgFetalMov');
  RegisterClass(TdlgGenetic);                Result.Add('TdlgGenetic^udlgGenetic');
  RegisterClass(TdlgHeadache);               Result.Add('TdlgHeadache^udlgHeadache');
  RegisterClass(TdlgInfectHist);             Result.Add('TdlgInfectHist^udlgInfectHist');
  RegisterClass(TdlgLegPain);                Result.Add('TdlgLegPain^udlgLegPain');
  RegisterClass(TdlgMedical);                Result.Add('TdlgMedical^udlgMedical');
  RegisterClass(TdlgNausea);                 Result.Add('TdlgNausea^udlgNausea');
  RegisterClass(TdlgPelvic);                 Result.Add('TdlgPelvic^udlgPelvic');
  RegisterClass(TdlgOBSpread);               Result.Add('TdlgOBSpread^udlgOBSpread');
  RegisterClass(TdlgPalp);                   Result.Add('TdlgPalp^udlgPalp');
  // Pregnancy History ----------------------------------------------------------------------
  RegisterClass(TdlgPregHist);               Result.Add('TdlgPregHist^udlgPregHist');
  RegisterClass(TfrmPregHist);               Result.Add('TdlgPregHist^udlgPregHist');
  RegisterClass(TfrmChildHist);              Result.Add('TdlgPregHist^udlgPregHist');
  // ----------------------------------------------------------------------------------------
  RegisterClass(TdlgPreNatal);               Result.Add('TdlgPreNatal^udlgPreNatal');
  RegisterClass(TdlgRash);                   Result.Add('TdlgRash^udlgRash');
  RegisterClass(TdlgRTClinic);               Result.Add('TdlgRTClinic^udlgRTClinic');
  RegisterClass(TdlgSocial);                 Result.Add('TdlgSocial^udlgSocial');
  RegisterClass(TdlgSurgical);               Result.Add('TdlgSurgical^udlgSurgical');
  RegisterClass(TdlgVagBleed);               Result.Add('TdlgVagBleed^udlgVagBleed');
  RegisterClass(TdlgVagDischarge);           Result.Add('TdlgVagDischarge^udlgVagDischarge');
  RegisterClass(TdlgVisualChanges);          Result.Add('TdlgVisualChanges^udlgVisualChanges');
  RegisterClass(TdlgWheezing);               Result.Add('TdlgWheezing^udlgWheezing');
  RegisterClass(TdlgImmunizations);          Result.Add('TdlgImmunizations^udlgImmunizations');
  RegisterClass(TdlgPhysicalExam);           Result.Add('TdlgPhysicalExam^udlgPhysicalExam');
  RegisterClass(TdlgROS);                    Result.Add('TdlgROS^udlgROS');
  RegisterClass(TdlgHistory);                Result.Add('TdlgHistory^udlgHistory');
  RegisterClass(TdlgEducation);              Result.Add('TdlgEducation^udlgEducation');
end;

function DisplayDialog(Broker: PCPRSComBroker; Build: string; DebugMode: Boolean): TStringList; stdcall;
var
  dlg: ToCNTDialog;
  dlgClass: TDialogClass;

  // Build = IEN | NAME | CLASS

begin
  Result := TStringList.Create;

  dlgClass := TDialogClass(FindClass(Piece(Build,'|',3)));
  dlg := dlgClass.Create(nil, Broker, DebugMode, Piece(Build,'|',1));
  try
    dlg.ShowModal;
    if dlg.ModalResult = mrOK then
      Result.AddStrings(dlg.TmpStrList);
  finally
    dlg.Free;
  end;
end;

function GetDialogComponents(dlgName: string): TStringList; stdcall;
var
  dlg: ToCNTDialog;
  dlgClass: TDialogClass;
  I: Integer;
begin
  Result := TStringList.Create;

  dlgClass := TDialogClass(FindClass(dlgName));
  dlg := dlgClass.Create(nil);
  try
    for I := 0 to dlg.ComponentCount - 1 do
      Result.Add(dlg.Components[I].Name + U + dlg.Components[I].ClassName);
  finally
    dlg.Free;
  end;
end;

exports
  RegisterDialogs,
  DisplayDialog,
  GetDialogComponents;

begin
end.
