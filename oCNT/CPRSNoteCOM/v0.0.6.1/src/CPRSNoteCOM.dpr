library CPRSNoteCOM;

uses
  ComServ,
  CPRSNoteCOM_TLB in 'CPRSNoteCOM_TLB.pas',
  CPRSChart_TLB in '..\..\..\My Documents\RAD Studio\7.0\Imports\CPRSChart_TLB.pas',
  MainUnit in 'MainUnit.pas' {CPRSNoteObject: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
