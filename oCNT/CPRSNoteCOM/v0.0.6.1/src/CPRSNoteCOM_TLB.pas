unit CPRSNoteCOM_TLB;

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

// $Rev: 17244 $
// File generated on 4/15/2014 8:21:29 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\AdvDev\Desktop\oCNTFramework\CPRSNoteCOM D10\CPRSNoteCOM (1)
// LIBID: {3EDFD568-368D-4EC8-A0D3-A3BE038818AA}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 CPRSChart, (C:\Vista\cprs\OR_3_306V29\CPRS-chart\CPRSChart.exe)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, CPRSChart_TLB, Graphics, OleServer, StdVCL, Variants;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CPRSNoteCOMMajorVersion = 1;
  CPRSNoteCOMMinorVersion = 0;

  LIBID_CPRSNoteCOM: TGUID = '{3EDFD568-368D-4EC8-A0D3-A3BE038818AA}';

  IID_ICPRSNoteObject: TGUID = '{3B81209F-2803-4945-8AC9-8E4878209F91}';
  CLASS_CPRSNoteObject: TGUID = '{902E9DDC-1479-4D38-8152-481413258BDC}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ICPRSNoteObject = interface;
  ICPRSNoteObjectDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  CPRSNoteObject = ICPRSNoteObject;


// *********************************************************************//
// Interface: ICPRSNoteObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B81209F-2803-4945-8AC9-8E4878209F91}
// *********************************************************************//
  ICPRSNoteObject = interface(IDispatch)
    ['{3B81209F-2803-4945-8AC9-8E4878209F91}']
  end;

// *********************************************************************//
// DispIntf:  ICPRSNoteObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B81209F-2803-4945-8AC9-8E4878209F91}
// *********************************************************************//
  ICPRSNoteObjectDisp = dispinterface
    ['{3B81209F-2803-4945-8AC9-8E4878209F91}']
  end;

// *********************************************************************//
// The Class CoCPRSNoteObject provides a Create and CreateRemote method to
// create instances of the default interface ICPRSNoteObject exposed by
// the CoClass CPRSNoteObject. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCPRSNoteObject = class
    class function Create: ICPRSNoteObject;
    class function CreateRemote(const MachineName: string): ICPRSNoteObject;
  end;

implementation

uses ComObj;

class function CoCPRSNoteObject.Create: ICPRSNoteObject;
begin
  Result := CreateComObject(CLASS_CPRSNoteObject) as ICPRSNoteObject;
end;

class function CoCPRSNoteObject.CreateRemote(const MachineName: string): ICPRSNoteObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CPRSNoteObject) as ICPRSNoteObject;
end;

end.

