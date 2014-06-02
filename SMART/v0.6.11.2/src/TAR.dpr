library TAR;

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
  SysUtils,
  Classes,
  TRPCB,
  Dialogs,
  Forms,
  Controls,
  StdCtrls,
  ComCtrls,
  ORNet,
  ORFn,
  ExtCtrls,
  fTARNotification in 'fTARNotification.pas' {frmTARNotification},
  fTARProcess in 'fTARProcess.pas' {frmTARProcess},
  UTARConst in 'UTARConst.pas',
  fTARNoteSelect in 'fTARNoteSelect.pas' {frmATRNoteSelect};

{$R *.res}
procedure SetATRPatient(thisPatientDFN: string); stdcall; export;
begin
  frmTARNotification.PatientDFN := thisPatientDFN;
end;

function ProviderHasIncompleteTARs() : boolean;
var
  i: integer;
  processState: string;
begin
  try
    //ORATR PROVIDER was just called
    result := false;
    for i := 0 to frmTARNotification.RPCBroker.Results.Count-1 do
      begin
      processState := Piece(frmTARNotification.RPCBroker.Results[i],'^',13);
      if ((processState = intToStr(TAR_INITIAL_PROCESS_LEVEL)) or (processState = intToStr(TAR_SOME_ACTION_TAKEN))) then
        begin
        result := true;
        Break; //there may be more, but there is at least one unprocessed TAR notification - so jump out
        end;
      end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in function ProviderHasIncompleteTARs()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function GetATRPatient(var slList: TStringList; var sATRDisplayTime: string; thisRPCBroker: TRPCBroker; thisUserDUZ: string) : boolean; stdcall; export;
var
 x: integer;
 thisFilterValue: string;
 //ProviderHasTARNotifications: boolean;
begin
  try
    Result := True;

    if frmTARNotification <> nil then
      begin
      frmTARNotification.UserDUZ := strToInt64(thisUserDUZ);
      end;

    //Create a valid broker instance
     ORNet.RPCBrokerV := TRPCBroker.Create(nil);
     ORNet.RPCBrokerV := thisRPCBroker;

     //Create a broker in this dll that can always be accessed
     if not Assigned(frmTARNotification.RPCBroker) then
       frmTARNotification.RPCBroker := TRPCBroker.Create(nil);

     //Our local broker field is now an 'alias' for ORNet.RPCBrokerV
     if Assigned(frmTARNotification.RPCBroker) then
       frmTARNotification.RPCBroker := ORNet.RPCBrokerV;

      if sATRDisplayTime <> '' then
        begin
        frmTARNotification.cbRemindMeLater.Checked := true;
        frmTARNotification.meRemindMeLater.Text := sATRDisplayTime;
        end
      else
        begin
        frmTARNotification.cbRemindMeLater.Checked := false;
        frmTARNotification.meRemindMeLater.Clear;
        end;

      frmTARNotification.lstATRAlerts.Clear;
      CallV('ORATR PROVIDER',[frmTARNotification.UserDUZ]);


      if ProviderHasIncompleteTARs then
        begin
        x := frmTARNotification.ShowModal;
        if frmTARNotification.cbRemindMeLater.Checked then
            sATRDisplayTime := frmTARNotification.meRemindMeLater.Text
        else
          sATRDisplayTime := '';
        end;

      if ( {(ProviderHasIncompleteTARs = false) or} (frmTARNotification.Cancelled)) then
       Result := true //it is NOT an ATR patient
      else
        Result := false; //it IS an ATR patient

       if Assigned(slList) then
       begin
        slList.Clear;
        slList.AddStrings(frmTARNotification.SelectedATRs);
       end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in GetATRPatient()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function IsATRPatient(thisPatientDFN: string) : boolean;
var
  thisPiece: string;
begin
  try
    CallV('ORATR PATIENT',[thisPatientDFN]);
    if frmTARNotification.RPCBroker.Results.Count > 0 then
      result := true
    else
      result := false;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in IsATRPatient()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function PatientHasIncompleteTARs() : boolean;
var
  i: integer;
  thisPatient: string;
begin
  try
    result := false;
    CallV('ORATR PATIENT',[frmTARNotification.PatientDFN]);
    for i := 0 to frmTARNotification.RPCBroker.Results.Count-1 do
      begin
      thisPatient := Piece(Piece(frmTARNotification.RPCBroker.Results[i],'^',8),',',2);
      //if it's the correct patient, and Processing Level = 0 or 1 then
      if ((thisPatient = frmTARNotification.PatientDFN) and (strToInt(Piece(frmTARNotification.RPCBroker.Results[i],'^',13)) < 2)) then
        begin
        result := true;
        Break;
        end;
      end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in PatientHasIncompleteATRs()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function PtProcessATRMult(thisRPCBroker: TRPCBroker; thisUserIEN: string; thisPatientDFN: string; var slPTSel: TStringList) : TStringList; stdcall; export;
//Nag dialog
var
 x: integer;
begin
  try
    //Result := '';
    //frmTARProcess.SelectedATRsMult.Free;
    frmTARProcess.SelectedATRsMult := TStringList.Create;
    frmTARProcess.SelectedATRsMult.Clear;
    result := frmTARProcess.SelectedATRsMult;

    if frmTARNotification <> nil then
      begin
      frmTARNotification.UserDUZ := strToInt64(thisUserIEN);
      frmTARNotification.PatientDFN := thisPatientDFN;
      end;

    try

      if PatientHasIncompleteTARs() then
        begin
          x := frmTARProcess.ShowModal;
          if (x-1 = mrOk) then
            begin
            result := frmTARProcess.SelectedATRsMult;
            end;
        end;
    except
      on E: Exception do
        MessageDlg('An exception has occurred in PtProcessATRMult()' + CRLF + E.Message, mtError, [mbOk], 0);
    end;
  finally

  end;
end;

function PtProcessATR(thisRPCBroker: TRPCBroker; thisUserIEN: string; thisPatientDFN: string) : string; stdcall; export;
//Nag dialog
var
 x: integer;
begin
  try
    //Result := '';

    if frmTARNotification <> nil then
      begin
      frmTARNotification.UserDUZ := strToInt64(thisUserIEN);
      frmTARNotification.PatientDFN := thisPatientDFN;
      end;

    try
      if PatientHasIncompleteTARs() then
        begin
          x := frmTARProcess.ShowModal;
          if (x-1 = mrOk) then
            begin
             result := frmTARProcess.SelectedATRs;
            end
          else
           Result := '';
        end;
    except
      on E: Exception do
        MessageDlg('An exception has occurred in PtProcessATR()' + CRLF + E.Message, mtError, [mbOk], 0);
    end;
  finally

  end;
end;

procedure FreeATRDLL(); stdcall; export;
begin
  try
    if Assigned(frmATRNoteSelect) then
     frmATRNoteSelect.Free;

    if Assigned(frmTARProcess) then
     frmTARProcess.Free;

    if Assigned(frmTARNotification) then
     frmTARNotification.Free;

  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure FreeATRDLL()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function StrToFMDateTime(const AString: string): TFMDateTime;
{ use %DT the validate and convert a string to Fileman format (accepts T, T-1, NOW, etc.) }
var
  x: string;
begin
  try
    x := sCallV('ORWU DT', [AString]);
    Result := StrToFloat(x);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TAR.StrToFMDateTime()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure GetEnhancedNotifications(var slNotifications: TStringList; thisRPCBroker: TRPCBroker; thisUserIEN: string); stdcall; export;
var
 sTmp: String;
 i: integer;
begin
  try
    if ((ProviderHasIncompleteTARs) and (frmTARNotification.Cancelled = true)) then
    begin
    CallV('ORATR PATIENT',[frmTARNotification.PatientDFN]);
    for i := 0 to frmTARNotification.RPCBroker.Results.Count - 1 do
      slNotifications.Add(frmTARNotification.RPCBroker.Results[i]);
    end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in GetEnhancedNotifications()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function ATRDocumentType(thisRPCBroker: TRPCBroker; thisPatientIEN: string; thisUserIEN: string; thisXQAID: string) : string; stdcall; export;
var
 x: integer;
 selectedItemIndex: integer;
 typ: string;
begin
  Result := '';

  try
    if frmTARNotification <> nil then
      begin
      frmTARNotification.UserDUZ := strToInt64(thisUserIEN);
      frmTARNotification.PatientDFN := thisPatientIEN;       
      end;

    frmATRNoteSelect.rbtnNewNote.Checked := false;
    frmATRNoteSelect.rbtnSelectAddendum.Checked := false;
    frmATRNoteSelect.rbtnSelectOwn.Checked := false;
    frmATRNoteSelect.XQAID := thisXQAID;

    repeat
      frmATRNoteSelect.lbATRNotes.Clear;

      x := 0;
      while x <> mrOK do
        begin
        x := frmATRNoteSelect.ShowModal;
        if x = mrCancel then
          begin
          frmATRNoteSelect.Close;
          Exit;
          end;
        end;

      if frmATRNoteSelect.rbtnNewNote.Checked then
      //Create New Note Using Default Note Title
       Result := 'N^'

      else
        //Select Different Note For Addendum
        if frmATRNoteSelect.rbtnSelectOwn.Checked then
          Result := 'O^'
      else
        begin //Add Addendum To Note From Initial TAR Visit Date
        selectedItemIndex := frmATRNoteSelect.lbATRNotes.ItemIndex;
        if ((selectedItemIndex > -1) and (selectedItemIndex <= frmATRNoteSelect.lbATRNotes.Items.Count)) then
          Result := 'A^' + frmATRNoteSelect.TIUNoteIEN
        else
          MessageDlg('Please select one or more Notes to process, or select a different processing option:' + CRLF +
                     '(''Create New Note Using Default Note Title'' or ''Select Different Note For Addendum'')', mtInformation, [mbOk], 0);
        end;
    until((frmATRNoteSelect.rbtnSelectAddendum.Checked) and ((selectedItemIndex > -1) and (selectedItemIndex <= frmATRNoteSelect.lbATRNotes.Items.Count))) or ((frmATRNoteSelect.rbtnNewNote.Checked) or (frmATRNoteSelect.rbtnSelectOwn.Checked));

  except
    on E: Exception do
      MessageDlg('An exception has occurred in ATRDocumentType()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

exports
  SetATRPatient,
  GetATRPatient,
  PtProcessATR,
  PtProcessATRMult,
  FreeATRDLL,
  GetEnhancedNotifications,
  ATRDocumentType;
begin
  //Initialization
  try
    if frmTARNotification = nil then
      frmTARNotification := TfrmTARNotification.Create(nil);

    if frmATRNoteSelect = nil then
        frmATRNoteSelect := TfrmATRNoteSelect.Create(nil);

    if frmTARProcess = nil then
      frmTARProcess := TfrmTARProcess.Create(frmTARNotification);

  except
    on E: Exception do
      MessageDlg('An exception has occurred in TAR.dll initialization.' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end.

