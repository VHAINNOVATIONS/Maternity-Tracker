library DDCSFormBuilder;

uses
  ComServ,
  DDCSFormBuilder_TLB in 'DDCSFormBuilder_TLB.pas',
  CPRSChart_TLB in 'CPRSChart_TLB.pas',
  uMain in 'uMain.pas' {DDCSCPRSDefault: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,
  DllInstall;

{$R *.TLB}

{$R *.RES}

begin
end.
