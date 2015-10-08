library DDCSFormBuilder;

uses
  ComServ,
  DDCSFormBuilder_TLB in 'DDCSFormBuilder_TLB.pas',
  uMain in 'uMain.pas' {DDCS: CoClass};

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
