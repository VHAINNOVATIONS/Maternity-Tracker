unit fTARNotification;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TRPCB, StdCtrls, ComCtrls, ORCtrls, {rCore,} VAUtils, ORNet, UTARConst,
  ORDtTm, ORFn, Mask;

type
  TAlertRec = class
    AlertData: string;
  end;

  TfrmTARNotification = class(TForm)
    ListBox1: TListBox;
    lstATRAlerts: TCaptionListView;
    buOK: TButton;
    buCancel: TButton;
    dlgNextATRPopup: TORDateTimeDlg;
    buSetNextTARNotificationDateTime: TButton;
    meRemindMeLater: TMaskEdit;
    cbRemindMeLater: TCheckBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure buOkClick(Sender: TObject);
    procedure buCancelClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstATRAlertsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lstATRAlertsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure lstATRAlertsDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buSetNextTARNotificationDateTimeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstATRAlertsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    descending: boolean;
    sortedColumn: integer;
    FRPCBroker: TRPCBroker;
    //FATRPtSelOnce: boolean;
    FUserDUZ: Int64;
    FPatientDFN: string;
    FPatientSSN: string;
    FLastInitLast4: string;
    FCancelled: boolean;
    FslSelectedATRs: TStringList;
    listIsLoaded: boolean;
  public
    FsortCol: integer;
    FsortAscending: boolean;
    FsortDirection: char;
    FcolumnToSort: integer;
    FNextATRPopupTime: TFMDateTime;
    FAlertIEN: string;
    //property 
    property AlertIEN: string read FAlertIEN write FAlertIEN;
    property SelectedATRs: TStringList read FslSelectedATRs write FslSelectedATRs;
    property RPCBroker: TRPCBroker read FRPCBroker write FRPCBroker;
    property NextATRPopupTime: TFMDateTime read FNextATRPopupTime write FNextATRPopupTime;
    property UserDUZ: Int64 read FUserDUZ write FUserDUZ;
    property PatientDFN: string read FPatientDFN write FPatientDFN;
    property PatientSSN: string read FPatientSSN write FPatientSSN;
    property LastInitLast4: string read FLastInitLast4 write FLastInitLast4;
    property Cancelled: boolean read FCancelled write FCancelled;
    procedure SetNextATRNotificationDateTime(Sender: TObject);
    function GetSelectedATRs : TStringList;
    procedure SetATRProcessingLevel(thisAlertIEN: string; thisProcessingLevel: integer);
    function TARIsComplete(thisBrokerResults: string) : boolean;
    function TARProcessingIsComplete(thisAlertData: string) : boolean;
  end;

var
  frmTARNotification: TfrmTARNotification;
  columnToSort: integer;

implementation

uses
  fTARProcess,
  fTARNoteSelect;

{$R *.dfm}

procedure TfrmTARNotification.SetATRProcessingLevel(thisAlertIEN: string; thisProcessingLevel: integer);
begin
  try
    CallV('ORATR SET ATR PROCESSING LEVEL',[thisAlertIEN, thisProcessingLevel]);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure SetATRProcessingLevel()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.SetNextATRNotificationDateTime(Sender: TObject);
begin
  try
    dlgNextATRPopup.Execute;
    //showmessage(DateTimeToStr(FMDateTimeToDateTime(dlgNextATRPopup.FMDateTime))); //debug
    if dlgNextATRPopup.FMDateTime > 0 then
      NextATRPopupTime := dlgNextATRPopup.FMDateTime
    else
      dlgNextATRPopup.FMDateTime := 0;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure SetNextATRNotificationDateTime()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.buSetNextTARNotificationDateTimeClick(Sender: TObject);
begin
  SetNextATRNotificationDateTime(Sender);
end;

function TfrmTARNotification.GetSelectedATRs : TStringList;
var
  i: integer;
begin
  try
    result := frmTARNotification.SelectedATRs;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure GetSelectedATRs()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

function TfrmTARNotification.TARProcessingIsComplete(thisAlertData: string) : boolean;
//Validation routine to determine 'Completion' of processing for a given TAR
/////***** No longer called as of v 0.6.3.0 *****/////
var
  i: integer;
  thisAlertTIUNoteIEN: string;
  thisTIUNoteIEN: string;
  slUnsigned: TStringList;
  slSignedByAuthor: TStringList;
begin
  try
    result := false;

    slUnsigned := TStringList.Create;
    slSignedByAuthor := TStringList.Create;

    //Look for this ATR IEN in Unsigned group
    CallV('TIU DOCUMENTS BY CONTEXT',[3,2,PatientDFN,1990101,DateTimeToFMDateTime(Date),UserDUZ,0,0,0,0]);
    FastAssign(frmTARNotification.RPCBroker.Results,slUnsigned);

    for i := 0 to slUnsigned.Count-1 do
      begin
      thisAlertTIUNoteIEN := Piece(Piece(thisAlertData,'^',8),';',8);
      thisTIUNoteIEN := Piece(slUnsigned[i],'^',1);

      //if found in this 'Unsigned' group then TAR processing NOT Complete
      if ((thisAlertTIUNoteIEN <> '') and (thisAlertTIUNoteIEN = thisTIUNoteIEN)) then
        begin
        result := false;
        Exit;
        end;
      end;

    //Look for this ATR IEN in SignedByAuthor group
    CallV('TIU DOCUMENTS BY CONTEXT',[3,1,PatientDFN,1990101,DateTimeToFMDateTime(Date),UserDUZ,0,0,0,0]); //4=Signed Documents by Author
    FastAssign(frmTARNotification.RPCBroker.Results,slSignedByAuthor);

    for i := 0 to slSignedByAuthor.Count-1 do
      begin
      thisAlertTIUNoteIEN := Piece(Piece(thisAlertData,'^',8),';',8);
      thisTIUNoteIEN := Piece(slSignedByAuthor[i],'^',1);

      //if found in this group then TAR processing IS Complete
      if ((thisAlertTIUNoteIEN <> '') and (thisAlertTIUNoteIEN = thisTIUNoteIEN)) then
        result := true; //has a signed note, so TAR processing IS complete
      end;

    //If not found in either group then
      // result will be false;

    if slUnsigned <> nil then
      FreeAndNil(slUnsigned);

    if slSignedByAuthor <> nil then
      FreeAndNil(slSignedByAuthor);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.TARProcessingIsComplete()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.buOkClick(Sender: TObject);
var
  i: integer;
  thisAlertData: string;
begin
  try
    Cancelled := false;
    self.SelectedATRs.Clear;
    for i := 0 to lstATRAlerts.Items.Count - 1 do
      begin
      if (lstATRAlerts.Items[i].Selected) then //or (lstATRAlerts.Items[i].Checked)) then
        begin
        thisAlertData := TAlertRec(self.lstATRAlerts.Items[i].SubItems.Objects[1]).AlertData;
        self.PatientDFN := Piece(Piece(thisAlertData,'^',8),',',2);
        self.SelectedATRs.Add(thisAlertData);
        SetATRProcessingLevel(Piece(Piece(thisAlertData,';',7),'^',1), TAR_SOME_ACTION_TAKEN) //1
        end;
      end;

    Close;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.buOkClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.buCancelClick(Sender: TObject);
begin
  try
    Cancelled := true;
    PatientSSN := '';
    PatientDFN := '';
    self.Close;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.buCancelClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.FormCreate(Sender: TObject);
begin
  try
    lstATRAlerts.Items.Clear;
    self.SelectedATRs := TStringList.Create;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.FormCreate()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.FormDestroy(Sender: TObject);
begin
  try
    if self.FslSelectedATRs <> nil then
      FreeAndNil(self.FslSelectedATRs);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.FormDestroy()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;

  inherited;
end;

function TfrmTARNotification.TARIsComplete(thisBrokerResults: string) : boolean;
var
  processLevel: string;
begin
  try
    result := false;
    processLevel := Piece(thisBrokerResults,'^',13);
    if strToInt(processLevel) > TAR_SOME_ACTION_TAKEN then
      result := true;
      except
    on E: Exception do
      MessageDlg('An exception has occurred in function TfrmTARNotification.TARIsComplete()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.FormShow(Sender: TObject);
var
  i: integer;
  tmpAlertData: TAlertRec;
  newItem: TListItem;
  thisStatus: string;
  thisPtDFN: string;
  temp: string;
  ptName: string;
  slProviderResults: TStringList;
  InitLast4: string;
begin
  try
    self.listIsLoaded := false;
    self.lstATRAlerts.Clear;
    self.SelectedATRs.Clear;

    //Load up the TCaptionListView ATR Notifications
    slProviderResults := TStringList.Create;
    FastAssign(self.RPCBroker.Results, slProviderResults);
    for i := 0 to slProviderResults.Count - 1 do
      begin
      //Add to the Notifications TCaptionListView ONLY if NOT already processed (ie. Completed)
      if not self.TARIsComplete(slProviderResults[i]) then
        begin
        tmpAlertData := TAlertRec.Create;
        tmpAlertData.AlertData := slProviderResults[i];
        newItem := lstATRAlerts.Items.Add;

        //First column: Patient name + First Initial + Last Four ssn
        thisPtDFN := Piece(Piece(slProviderResults[i],'^',8),',',2);
        temp := sCallV('ORWPT ID INFO',[thisPtDFN]);
        ptName := Piece(temp,'^',8);
        InitLast4 := ' '+ Piece(Piece(slProviderResults[i],'^',2),' ',2);
        newItem.Caption := ptName + InitLast4;

        thisStatus := Piece(slProviderResults[i],'^',13);
        case strToInt(thisStatus) of
          0:  newItem.SubItems.Add('Unprocessed');
          1:  newItem.SubItems.Add('Incomplete');
        end;

        newItem.SubItems.AddObject(Piece(slProviderResults[i],'^',4),tmpAlertData); //criticality
        newItem.SubItems.Add(Piece(slProviderResults[i],'^',6)); //type of abnormal
        newItem.SubItems.Add(Piece(slProviderResults[i],'^',5)); //last followup dt
        newItem.SubItems.Add(Piece(slProviderResults[i],'^',7)); //source

        ///// Debug columns ////////////////////////////////////////////////////////////////
        // Add these items to the TCaptionListView for debugging.
        // Leave this code as is for future, but shorten the width of the TCaptionListView
        // so that these columns do not show at runtime.
        newItem.SubItems.Add(Piece(Piece(slProviderResults[i],'^',8),';',7)); //ATR ien - debug
        newItem.SubItems.Add(Piece(slProviderResults[i],'^',13)); //Processing Level - debug
        newItem.SubItems.Add(Piece(Piece(slProviderResults[i],'^',8),';',8)); //TIU ien - debug
        ////////////////////////////////////////////////////////////////////////////////////      
        end;
      end;

    self.listIsLoaded := true;

    if slProviderResults <> nil then
      FreeAndNil(slProviderResults);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.FormShow()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.ListBox1DblClick(Sender: TObject);
begin
  buOk.Click;
end;

procedure TfrmTARNotification.lstATRAlertsColumnClick(Sender: TObject; Column: TListColumn);
begin
  try
    TListView(Sender).SortType := stNone;

    if Column.Index <> SortedColumn then
      begin
      sortedColumn := Column.Index;
      descending := False;
      end
    else
      descending := not descending;

    TListView(Sender).SortType := stText;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.lstATRAlertsColumnClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.lstATRAlertsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  try
    if self.ListIsLoaded then
      begin
      if SortedColumn = 0 then
        Compare := CompareText(Item1.Caption, Item2.Caption)
      else
        if SortedColumn <> 0 then
          Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);

      if descending then
        Compare := -Compare;
      end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.lstATRAlertsCompare()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARNotification.lstATRAlertsDblClick(Sender: TObject);
begin
  buOkClick(buOK);
end;

procedure TfrmTARNotification.lstATRAlertsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  listItem: TListItem;
begin
  try
    listItem := lstATRAlerts.GetItemAt(X, Y);
    if (listItem <> nil) and (lstATRAlerts.Selected <> listItem) then
      lstATRAlerts.Selected := listItem;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARNotification.lstATRAlertsMouseDown()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

end.
