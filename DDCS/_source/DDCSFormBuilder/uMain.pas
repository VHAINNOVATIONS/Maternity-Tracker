unit uMain;

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

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, DDCSFormBuilder_TLB, CPRSChart_TLB, StdVcl,
  Forms, SysUtils, Vcl.Dialogs, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.CheckLst, JvStringGrid, Vcl.Samples.Spin, TypInfo, StrUtils,
  uExtndComBroker, oCNTBase, uCommon;

type
  TDDCS = class(TAutoObject, IDDCS, ICPRSExtension)
  private
    procedure Initialize;
    procedure ShowoCNT;
    procedure SetStrings(var vControl: TControl; sProp, value: string);
    function InitializeControl(var vControl: TControl; rClass: string; rName: string;
             AOwner: TComponent; AParent: TWinControl): Boolean;
  protected
    function Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState; const Param1,
             Param2, Param3: WideString; var Data1, Data2: WideString): WordBool; safecall;
  end;

  TLaunchoCNT = function(Broker: PCPRSComBroker): Pointer; stdcall;

var
  oCNTDLL: THandle;
  LaunchoCNT: TLaunchoCNT;
  oCNTP: ^TForm;
  State,Another: Integer;

implementation

uses
  ComServ;

function TDDCS.InitializeControl(var vControl: TControl; rClass: string; rName: string;
                                 AOwner: TComponent; AParent: TWinControl): Boolean;
var
  C: TPersistentClass;
  sl: TStringList;
begin
  Result := False; vControl := nil;
  C := GetClass(rClass);

  if C = nil then
    Exit;

  vControl := TControl(TControlClass(C).Create(AOwner));
  vControl.Name := rName;
  vControl.Parent := AParent;

  if IsPublishedProp(vControl, 'Caption') then
    SetPropValue(vControl, 'Caption', '');

  if IsPublishedProp(vControl, 'TabStop') then
    SetPropValue(vControl, 'TabStop', True);

  if IsPublishedProp(vControl, 'Lines') then
  begin
    sl := TStringList.Create;
    try
      SetObjectProp(vControl, 'Lines', sl);
    finally
      sl.Free;
    end;
  end;

  Result := True;
end;

procedure TDDCS.SetStrings(var vControl: TControl; sProp, value: string);
var
  sl: TStringList;
  I: Integer;
begin
  sl := TStringList.Create;
  try
    for I := 1 to SubCount(value,';') + 1 do
      sl.Add(Piece(value,';',I));

    SetObjectProp(vControl, sProp, sl);
  finally
    sl.Free;
  end;
end;

// Legacy ----------------------------------------------------------------------

//Hold the active OCNT so you don't lose the windows Thread lock in CPRS
//If not done here the alternative is to ShowModal in LaunchCNT rather than Show

//This is a merger of Show and ShowModal. If we Show then CPRS releases the process
//and the Thread used by ICPRSBroker is released - Windows.CriticalSection
//However, if we use ShowModal we cannot access CPRS while the OCNT is up
procedure TDDCS.ShowoCNT;
begin
  State := 0;
  repeat
    Application.HandleMessage;
    if oCNTP = nil then
      State := 1
    else
      if not oCNTP^.Showing then
        State := 1;
  until State <> 0;
end;

// New -------------------------------------------------------------------------

procedure TDDCS.Initialize;
begin
  RegisterClasses([TDateTimePicker, TEdit, TLabeledEdit, TCheckBox, TRadioButton, TRadioGroup, TSpinEdit, TComboBox, TListBox,
                   TCheckListBox, TListView, TMemo, TRichEdit, TJvStringGrid, TGroupBox, TLabel]);
end;

function TDDCS.Execute(const CPRSBroker: ICPRSBroker; const CPRSState: ICPRSState;
          const Param1, Param2, Param3: WideString; var Data1, Data2: WideString): WordBool;
var
  sl,dl: TStringList;
  DDCSConfig,Controlled,vPropertyList,vProp,vValue: string;
  IEN,I,ctI: Integer;
  MainForm: TForm;
  InnerForm: ToForm;
  vControl: TControl;
  vPropInfo: PPropInfo;

  //   RETURN:
  //     INTERFACE: I^PROPERTY|VALUE
  //          PAGE: P^NUMBER^CAPTION
  //       CONTROL: C^NAME^CLASS^PAGE NUMBER^PROPERTY|VALUE
  //       CONTROL: CV^NAME^PROPERTY^CONFIG VALUE

begin
  // ReportMemoryLeaksOnShutdown := True;  //debug

  Result := False;

  if oCNTP <> nil then
  begin
    //Since we cannot allow the Process to end if it spawns again because it would
    //kill our thread with CPRS with have to stay in here. So a better way to go about
    //it would be to wait until the other DLL has been closed and then carry through.

    try
      oCNTP^.BringToFront;
      ShowoCNT;
    except
    end;
  end else
  begin
    RPCBrokerV := TCPRSComBroker.Create(nil);
    RPCBrokerV.COMBroker  := CPRSBroker;
    RPCBrokerV.CPRSState  := CPRSState;
    RPCBrokerV.CPRSHandle := Cardinal(CPRSState.Handle);

    if Data2 <> '' then
    begin
      // Used as XML block from TIU for Note information
      RPCBrokerV.Source.Import := Data2;
      Controlled := 'N=' + RPCBrokerV.Source.IEN;
    end else
    begin
      RPCBrokerV.Source.IEN := Piece(Piece(Param2,'=',2),';',1);
      // Used as O=### as Order IEN could also be used as N=### as Note IEN
      Controlled := Param2;
    end;

    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      Controlled := RPCBrokerV.sCallV('DSIO DDCS CONTROLLED', [Controlled]);

      // Don't want to annoy the user with a popup for every order not found a control object
      if not TryStrToInt(Piece(Controlled,U,1),IEN) or (IEN < 1) then
      begin
        Result := True;
        Exit;
      end;

      RPCBrokerV.ControlObject := Piece(Controlled,U,2);
      vPropertyList := Piece(Controlled,U,3);
      for ctI := 1 to SubCount(vPropertyList,'|') + 1 do
      begin
        if AnsiContainsText(Piece(vPropertyList,'|',ctI),'*') then
          RPCBrokerV.DDCSInterface := StringReplace(Piece(vPropertyList,'|',ctI),'*','',[rfReplaceAll])
        else
          RPCBrokerV.DDCSInterfacePages.Add(Piece(vPropertyList,'|',ctI));
      end;

      RPCBrokerV.SetContext(MENU_CONTEXT);
      DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'WARNING MESSAGE']);
      if DDCSConfig <> '' then
      begin
        if MessageDlg(DDCSConfig + ' Select YES to continue.',mtWarning,mbYesNoCancel,0) <> mrYes then
          Exit;
      end;

      // RunTime Build
      if Piece(Controlled,U,4) = '' then
      begin
        Initialize;

        sl := TStringList.Create; dl := TStringList.Create;
        try
          if RPCBrokerV.DDCSInterfacePages.Count > 0 then
            dl.AddStrings(RPCBrokerV.DDCSInterfacePages)
          else
            dl.Add(RPCBrokerV.DDCSInterface);

          try
            RPCBrokerV.SetContext(MENU_CONTEXT);
            RPCBrokerV.tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN]);
            if sl.Count > 0 then
            begin
              MainForm := TForm.Create(nil);
              with MainForm do
              begin
                Constraints.MinHeight := 530;
                Constraints.MinWidth := 630;
                Position := poMainFormCenter;
                BorderStyle := bsSizeToolWin;
              end;
              InnerForm := ToForm.Create(MainForm);
              InnerForm.Parent := MainForm;

              try
                for I := 0 to sl.Count - 1 do
                begin

                  // Interface ------------------------------------------------------
                  if Piece(sl[I],U,1)='I' then
                  begin
                    // Set Properties
                    vPropertyList := Piece(sl[I],U,2,99);
                    if vPropertyList <> '' then
                    begin
                      for ctI := 1 to SubCount(vPropertyList,U) + 1 do
                      begin
                        vProp := Piece(Piece(vPropertyList,U,ctI),'|',1);
                        if IsPublishedProp(MainForm, vProp) then
                        begin
                          vValue := Piece(Piece(vPropertyList,U,ctI),'|',2);
                          if vValue <> '' then
                            SetPropValue(MainForm, vProp, vValue);
                        end;
                      end;
                    end;
                  end;

                  // Page -----------------------------------------------------------
                  if Piece(sl[I],U,1)='P' then
                    Innerform.CreateTab(Piece(sl[I],U,3));

                  // Control --------------------------------------------------------
                  if Piece(sl[I],U,1)='C' then
                  begin
                    //                   class,name,owner,parent
                    if InitializeControl(vControl, Piece(sl[I],'^',3), Piece(sl[I],'^',2), MainForm,
                                         InnerForm.Pages[StrToInt(Piece(sl[I],'^',4))-1]) then
                    begin
                      // Set Properties
                      vPropertyList := Piece(sl[I],'^',5,99);
                      if vPropertyList <> '' then
                      begin
                        for ctI := 1 to SubCount(vPropertyList, '^') + 1 do
                        begin
                          vProp := Piece(Piece(vPropertyList, '^', ctI), '|', 1);

                          if IsPublishedProp(vControl, vProp) then
                          begin
                            vValue := Piece(Piece(vPropertyList, '^', ctI), '|', 2);
                            vPropInfo := GetPropInfo(vControl, vProp);

                            if (vPropInfo^.PropType^).Name = 'TStrings' then
                              SetStrings(vControl, vProp, vValue)
                            else
                              if vvalue <> '' then
                                SetPropValue(vControl, vprop, vvalue);
                          end;
                        end;
                      end;
                    end;
                  end;

                end;

                MainForm.ShowModal;
              finally
                if MainForm.ModalResult = mrOk then
                  Result := True;

                MainForm.Free;
              end;
            end;

          except
            on E: Exception do
            ShowMessage(E.Message);
          end;
        finally
          sl.Free; dl.Free;
        end;

      end else
      begin
        New(oCNTP);

        try
          RPCBrokerV.SetContext(MENU_CONTEXT);
          DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'LOCATION']);

          if DDCSConfig <> '' then
          begin
            oCNTDLL := SafeLoadLibrary(DDCSConfig);
            if oCNTDLL <> 0 then
            begin
              LaunchoCNT := GetProcAddress(oCNTDLL,'LaunchoCNT');
              if Assigned(LaunchoCNT) then
              begin
                oCNTP := LaunchoCNT(@RPCBrokerV);

                DDCSConfig := '';
                try
                  DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'HOLD ON SHOW']);

                  if ((DDCSConfig <> '') and (StrToBool(DDCSConfig))) then
                  begin
                    oCNTP^.ShowModal;
                    oCNTP^.Destroy;
                  end else
                  begin
                    oCNTP^.Show;
                    ShowoCNT;
                  end;

                except
                  on E: Exception do
                  ShowMessage(E.Message);
                end;

                //Pass the Note to CPRS
                Data1 := RPCBrokerV.Source.Lines.Text;
                if Data1 <> '' then
                  Result := True;
              end;
            end else
              ShowMessage('Unable to load library.');
          end else
            ShowMessage('Unable to to build path.');
        except
          On E: Exception do
          ShowMessage(E.Message);
        end;

        oCNTP := nil;
        RPCBrokerV.Clean;

        if oCNTDLL <> 0 then
          FreeLibrary(oCNTDLL);

      end;

    except
      On E: Exception do
      ShowMessage(E.Message);
    end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TDDCS, Class_DDCS,
    ciMultiInstance, tmApartment);
end.
