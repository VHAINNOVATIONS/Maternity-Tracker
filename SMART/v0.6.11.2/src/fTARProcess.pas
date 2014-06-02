unit fTARProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TRPCB, StdCtrls,ORNet, ORFn, ComCtrls, ORCtrls,
  fTARNotification;

type
  TfrmTARProcess = class(TForm)
    StaticText1: TStaticText;
    buProcessATR: TButton;
    buDeferProcessing: TButton;
    lstATRAlerts: TCaptionListView;
    Memo1: TMemo;
    procedure buProcessATRClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstATRAlertsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lstATRAlertsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lstATRAlertsClick(Sender: TObject);
    procedure buDeferProcessingClick(Sender: TObject);
    procedure lstATRAlertsDblClick(Sender: TObject);
    procedure lstATRAlertsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    descending: boolean;
    sortedColumn: integer;
    FRPCBroker: TRPCBroker;
    FslSelectedATRs: string;
    FslSelectedATRsMult: TStringList;
    listIsLoaded: boolean;
  public
    property SelectedATRs: string read FslSelectedATRs write FslSelectedATRs;
    property SelectedATRsMult: TStringList read FslSelectedATRsMult write FslSelectedATRsMult;
    procedure SetATRProcessingLevel(thisAlertIEN: string; thisProcessingLevel: integer);
  end;

var
  frmTARProcess: TfrmTARProcess;
  RPCBrokerV: TRPCBroker;
  columnToSort: integer;

implementation

{$R *.dfm}

uses
  //fTARNotification,
  fTARNoteSelect, UTARConst;

procedure TfrmTARProcess.SetATRProcessingLevel(thisAlertIEN: string; thisProcessingLevel: integer);
begin
  try
    CallV('ORATR SET ATR PROCESSING LEVEL',[thisAlertIEN, thisProcessingLevel]);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.SetATRProcessingLevel()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.buDeferProcessingClick(Sender: TObject);
//Unselect all TCaptionListView items, so that if user selects
// an item and then clicks 'Defer', CPRS won't choke on processing the Notification.
var
  i: integer;
begin
  try
    for i := 0 to self.lstATRAlerts.Items.Count - 1 do
      begin
      if lstATRAlerts.Items[i].Selected then
        lstATRAlerts.Items[i].Selected := false;
      end;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.buDeferProcessingClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.buProcessATRClick(Sender: TObject);
var
  thisAlertData: string;
  i: integer;
begin
  try
    if lstATRAlerts.SelCount < 1 then
      begin
      Close;
      Exit;
      end;

    //self.SelectedATRs.Clear;
    for i := 0 to self.lstATRAlerts.Items.Count - 1 do
      begin
      if self.lstATRAlerts.Items[i].Selected then
        begin
        //'^BHYHGDST  (B1022)^^HIGH^06/06/2012@10:15^Abnormal Test Result - BCCCR^^ATR,155,12;10000;155^^'
        thisAlertData := TAlertRec(self.lstATRAlerts.Items[i].SubItems.Objects[1]).AlertData;
        self.SelectedATRsMult.Add(thisAlertData);
        SetATRProcessingLevel(Piece(Piece(thisAlertData,';',7),'^',1), TAR_SOME_ACTION_TAKEN) //1
        end;
      end;

    Close;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.buProcessATRClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.FormCreate(Sender: TObject);
begin
  try
    self.SelectedATRsMult := TStringList.Create;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.FormCreate()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.FormDestroy(Sender: TObject);
begin
  try
    if self.FslSelectedATRsMult <> nil then
      FreeAndNil(self.FslSelectedATRsMult);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.FormDestroy()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;

  inherited;
end;

procedure TfrmTARProcess.FormShow(Sender: TObject);
var
  i: integer;
  j: integer;
  tmpAlertData: TAlertRec;
  newItem: TListItem;
  thisPatientDFN: string;
  slProviderATRs: TStringList;
  slPatientATRs: TStringList;
  thisProviderATRien: string;
  thisPatientATRien: string;
  thisStatus: string;
  thisPtDFN: string;
  temp: string;
  ptName: string;
  InitLast4: string;
begin
  try
      self.listIsLoaded := false;
      slProviderATRs := TStringList.Create;
      slPatientATRs := TStringList.Create;
      Memo1.Clear;
      Memo1.Lines.Add('Select an Alert below to see its details here . . .');
      CallV('ORATR PATIENT',[frmTARNotification.PatientDFN]);
      FastAssign(frmTARNotification.RPCBroker.Results, slPatientATRs);
      self.lstATRAlerts.Clear;

      //Load up the TCaptionListView ATR Notifications for the CURRENT PROVIDER and CURRENT PATIENT selection
      //Patient ATRs associated with OTHER Providers will not show up
      thisPatientDFN := '';

        for i := 0 to slPatientATRs.Count - 1 do
          begin
          thisPatientATRien := Piece(Piece(slPatientATRs[i],'^',8),';',7);
          thisPatientDFN := Piece(Piece(slPatientATRs[i],'^',8),',',2);
            //Add to the Notifications TCaptionListView ONLY if not already Completed
            if ((not frmTARNotification.TARIsComplete(slPatientATRs[i])) ) then
              begin
              tmpAlertData := TAlertRec.Create;
              tmpAlertData.AlertData := slPatientATRs[i];
              newItem := self.lstATRAlerts.Items.Add;
              thisPtDFN := Piece(Piece(slPatientATRs[i],'^',8),',',2);
              temp := sCallV('ORWPT ID INFO',[thisPtDFN]);
              ptName := Piece(temp,'^',8);
              InitLast4 := ' '+ Piece(Piece(slPatientATRs[j],'^',2),' ',2);
              newItem.Caption := ptName + InitLast4;

              thisStatus := Piece(slPatientATRs[i],'^',13);
              case strToInt(thisStatus) of
                0:  newItem.SubItems.Add('Unprocessed');  //status
                1:  newItem.SubItems.Add('Incomplete');   //status
              end;

              newItem.SubItems.AddObject(Piece(slPatientATRs[i],'^',4),tmpAlertData); //criticality
              newItem.SubItems.Add(Piece(slPatientATRs[i],'^',6)); //type of abnormal
              newItem.SubItems.Add(Piece(slPatientATRs[i],'^',5)); //last followup dt
              newItem.SubItems.Add(Piece(slPatientATRs[i],'^',7)); //source

              ///// Debug columns ////////////////////////////////////////////////////////////////
              // Add these items to the TCaptionListView for debugging.
              // Leave this code as is for future, but shorten the width of the TCaptionListView
              // so that these columns do not show at runtime.
              newItem.SubItems.Add(Piece(Piece(slPatientATRs[i],'^',8),';',7)); //ATR ien - debug
              newItem.SubItems.Add(Piece(slPatientATRs[i],'^',13)); //Processing Level - debug
              newItem.SubItems.Add(Piece(Piece(slPatientATRs[i],'^',8),';',8)); //TIU ien - debug
              ////////////////////////////////////////////////////////////////////////////////////
              end;
            //end;
          end; //i
        //end; //j

    self.listIsLoaded := true;

    if slProviderATRs <> nil then
      FreeAndNil(slProviderATRs);
    if slPatientATRs <> nil then
      FreeAndNil(slPatientATRs);

  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.FormShow()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.lstATRAlertsClick(Sender: TObject);
var
  i: integer;
  thisIEN: string;
  slParamArray: TStringList;
  patientName: string;
begin
  try
    if lstATRAlerts.SelCount < 1 then
      begin
      buProcessATR.Enabled := false;
      Exit;
      end;

    Memo1.Clear;
    buProcessATR.Enabled := true;
    slParamArray := TStringList.Create;
    thisIEN := lstATRAlerts.Selected.SubItems[5];  //ATR IEN for test results - Also see FormShow where the IEN gets loaded per ListView Item
    slParamArray.Add('ATR^' + thisIEN);

    CallV('ORATR GET TEST RESULTS',[slParamArray]);
    Memo1.Lines.BeginUpdate;
    for i := 0 to frmTARNotification.RPCBroker.Results.Count-1 do
      Memo1.Lines.Add(frmTARNotification.RPCBroker.Results[i]);
    Memo1.Lines.EndUpdate;

    if slParamArray <> nil then
      FreeAndNil(slParamArray);
  except
    on E: Exception do
      MessageDlg('An exception has occurred in TfrmTARProcess.lstATRAlertsClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.lstATRAlertsColumnClick(Sender: TObject; Column: TListColumn);
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
      MessageDlg('An exception has occurred in TfrmTARProcess.lstATRAlertsColumnClick()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.lstATRAlertsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  try
    if self.listIsLoaded then
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
      MessageDlg('An exception has occurred in procedure TfrmTARProcess.lstATRAlertsCompare()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmTARProcess.lstATRAlertsDblClick(Sender: TObject);
begin
  buProcessATRClick(buProcessATR);
end;

procedure TfrmTARProcess.lstATRAlertsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  listItem: TListItem;
begin
  try
    listItem := lstATRAlerts.GetItemAt(X, Y);
    if (listItem <> nil) and (lstATRAlerts.Selected <> listItem) then
      lstATRAlerts.Selected := listItem;
  except
    on E: Exception do
      MessageDlg('An exception has occurred in procedure TfrmTARProcess.lstATRAlertsMouseDown()' + CRLF + E.Message, mtError, [mbOk], 0);
  end;
end;

end.
