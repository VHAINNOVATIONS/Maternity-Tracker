library CPRSNoteCOM;

uses
  ComServ,
  CPRSNoteCOM_TLB in 'CPRSNoteCOM_TLB.pas',
  MainUnit in 'MainUnit.pas' {CPRSNoteObject: CoClass},
  CPRSChart_TLB in '..\..\..\Documents\RAD Studio\11.0\Imports\CPRSChart_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
