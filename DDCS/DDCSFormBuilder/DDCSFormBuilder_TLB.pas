unit DDCSFormBuilder_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 11/17/2016 4:28:00 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\DSSDeveloper\Documents\GitHub\Maternity-Tracker\DDCS\DDCSFormBuilder\DDCSFormBuilder (1)
// LIBID: {61BBAF10-F0AE-432C-89D7-1CF6D033BD47}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v1.0 CPRSChart, (C:\Users\DSSDeveloper\Documents\GitHub\Maternity-Tracker\DDCS\_lib\CPRSChart.exe)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, CPRSChart_TLB, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DDCSFormBuilderMajorVersion = 1;
  DDCSFormBuilderMinorVersion = 0;

  LIBID_DDCSFormBuilder: TGUID = '{61BBAF10-F0AE-432C-89D7-1CF6D033BD47}';

  IID_IDDCSCPRSBroker: TGUID = '{0DD1DF25-9EFF-4BF1-94CF-943E7109CE26}';
  IID_IDDCSCPRSState: TGUID = '{937E841E-CCB9-4D52-BA8A-33996E21876A}';
  IID_IDDCSCPRSExtension: TGUID = '{5D2BB4DC-FA83-41F5-B691-FD6A88A72802}';
  CLASS_DDCSCPRSDefault: TGUID = '{A5B2B08E-7045-4C77-9233-32B52C6E5B25}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum BrokerParamType
type
  BrokerParamType = TOleEnum;
const
  bptLiteral = $00000000;
  bptReference = $00000001;
  bptList = $00000002;
  bptUndefined = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IDDCSCPRSBroker = interface;
  IDDCSCPRSBrokerDisp = dispinterface;
  IDDCSCPRSState = interface;
  IDDCSCPRSStateDisp = dispinterface;
  IDDCSCPRSExtension = interface;
  IDDCSCPRSExtensionDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  DDCSCPRSDefault = ICPRSExtension;


// *********************************************************************//
// Interface: IDDCSCPRSBroker
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0DD1DF25-9EFF-4BF1-94CF-943E7109CE26}
// *********************************************************************//
  IDDCSCPRSBroker = interface(ICPRSBroker)
    ['{0DD1DF25-9EFF-4BF1-94CF-943E7109CE26}']
  end;

// *********************************************************************//
// DispIntf:  IDDCSCPRSBrokerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0DD1DF25-9EFF-4BF1-94CF-943E7109CE26}
// *********************************************************************//
  IDDCSCPRSBrokerDisp = dispinterface
    ['{0DD1DF25-9EFF-4BF1-94CF-943E7109CE26}']
    function SetContext(const Context: WideString): WordBool; dispid 1;
    function Server: WideString; dispid 2;
    function Port: Integer; dispid 3;
    function DebugMode: WordBool; dispid 4;
    property RPCVersion: WideString dispid 5;
    property ClearParameters: WordBool dispid 6;
    property ClearResults: WordBool dispid 7;
    procedure CallRPC(const RPCName: WideString); dispid 8;
    property Results: WideString dispid 9;
    property Param[Index: Integer]: WideString dispid 10;
    property ParamType[Index: Integer]: BrokerParamType dispid 11;
    property ParamList[Index: Integer; const Node: WideString]: WideString dispid 12;
    function ParamCount: Integer; dispid 13;
    function ParamListCount(Index: Integer): Integer; dispid 14;
  end;

// *********************************************************************//
// Interface: IDDCSCPRSState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {937E841E-CCB9-4D52-BA8A-33996E21876A}
// *********************************************************************//
  IDDCSCPRSState = interface(ICPRSState)
    ['{937E841E-CCB9-4D52-BA8A-33996E21876A}']
    function StationID: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDDCSCPRSStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {937E841E-CCB9-4D52-BA8A-33996E21876A}
// *********************************************************************//
  IDDCSCPRSStateDisp = dispinterface
    ['{937E841E-CCB9-4D52-BA8A-33996E21876A}']
    function StationID: WideString; dispid 10;
    function Handle: WideString; dispid 1;
    function UserDUZ: WideString; dispid 2;
    function UserName: WideString; dispid 3;
    function PatientDFN: WideString; dispid 4;
    function PatientName: WideString; dispid 5;
    function PatientDOB: WideString; dispid 6;
    function PatientSSN: WideString; dispid 7;
    function LocationIEN: Integer; dispid 8;
    function LocationName: WideString; dispid 9;
  end;

// *********************************************************************//
// Interface: IDDCSCPRSExtension
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5D2BB4DC-FA83-41F5-B691-FD6A88A72802}
// *********************************************************************//
  IDDCSCPRSExtension = interface(ICPRSExtension)
    ['{5D2BB4DC-FA83-41F5-B691-FD6A88A72802}']
  end;

// *********************************************************************//
// DispIntf:  IDDCSCPRSExtensionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5D2BB4DC-FA83-41F5-B691-FD6A88A72802}
// *********************************************************************//
  IDDCSCPRSExtensionDisp = dispinterface
    ['{5D2BB4DC-FA83-41F5-B691-FD6A88A72802}']
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
                     const Param1: WideString; const Param2: WideString; const Param3: WideString;
                     var Data1: WideString; var Data2: WideString): WordBool; dispid 1;
  end;

// *********************************************************************//
// The Class CoDDCSCPRSDefault provides a Create and CreateRemote method to
// create instances of the default interface ICPRSExtension exposed by
// the CoClass DDCSCPRSDefault. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDDCSCPRSDefault = class
    class function Create: ICPRSExtension;
    class function CreateRemote(const MachineName: string): ICPRSExtension;
  end;

implementation

uses System.Win.ComObj;

class function CoDDCSCPRSDefault.Create: ICPRSExtension;
begin
  Result := CreateComObject(CLASS_DDCSCPRSDefault) as ICPRSExtension;
end;

class function CoDDCSCPRSDefault.CreateRemote(const MachineName: string): ICPRSExtension;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DDCSCPRSDefault) as ICPRSExtension;
end;

end.

