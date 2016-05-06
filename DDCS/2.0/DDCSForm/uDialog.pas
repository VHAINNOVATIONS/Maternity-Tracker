unit uDialog;

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

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uReportItems,
  uExtndComBroker;

Type
  TGetTmpStrList = function: TStringList of object;

  TDDCSDialog = class(TForm)
  private
    FReportCollection: TDDCSNoteCollection;
    FReturnList: TStringList;
    FConfiguration: TStringList;
    FDebugMode: Boolean;
    FIEN: string;
    FOnGetTmpStrList: TGetTmpStrList;
    procedure SetNoteCollection(const Value: TDDCSNoteCollection);
    procedure cbAutoWidth(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent; Broker: PCPRSComBroker; DebugMode: Boolean; iIEN: string); overload;
    destructor Destroy; override;
    procedure Save;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property DebugMode: Boolean read FDebugMode write FDebugMode;
    property IEN: string read FIEN write FIEN;
    property Configuration: TStringList read FConfiguration write FConfiguration;
  published
    property ReportCollection: TDDCSNoteCollection read FReportCollection write SetNoteCollection;
    property OnGetTmpStrList: TGetTmpStrList read FOnGetTmpStrList write FOnGetTmpStrList;
  end;

  TDialogClass = class of TDDCSDialog;

implementation

uses
  VAUtils, uCommon;

// Private ---------------------------------------------------------------------

procedure TDDCSDialog.SetNoteCollection(const Value: TDDCSNoteCollection);
begin
  FReportCollection.Assign(Value);
end;

procedure TDDCSDialog.cbAutoWidth(Sender: TObject);
var
  cb: TCustomComboBox;
  cbLength,I: Integer;
begin
  if not Sender.InheritsFrom(TCustomComboBox) then
    Exit;

  cb := TCustomComboBox(Sender);

  cbLength := cb.Width;
  for I := 0 to cb.Items.Count - 1 do
    if cb.Canvas.TextWidth(cb.Items[I]) > cbLength then
      cbLength := cb.Canvas.TextWidth(cb.Items[I]) + GetSystemMetrics(SM_CXVSCROLL);

  SendMessage(cb.Handle, CB_SETDROPPEDWIDTH, (cblength + 7), 0);
end;

// Protected -------------------------------------------------------------------

procedure TDDCSDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (FReportCollection = nil) or not (AComponent is TWinControl) or
    (AComponent = Self) then
    Exit;
  if AComponent is TStaticText then
    Exit;

  if ((csDesigning in ComponentState) and not (csLoading in ComponentState)) then
  begin
    if Operation = opInsert then
      FReportCollection.GetNoteItemAddifNil(TWinControl(AComponent))
    else if Operation = opRemove then
      FReportCollection.DeleteNoteItem(TWinControl(AComponent));
  end;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSDialog.Create(AOwner: TComponent; Broker: PCPRSComBroker; DebugMode: Boolean; iIEN: string);
var
  sl,dl: TStringList;
  I: Integer;
  wControl: TWinControl;

  procedure SetUpControl(wControl: TWinControl);
  var
    I: Integer;
    wComboBox: TComboBox;
  begin
    if wControl is TStaticText then
      Exit;

    if wControl.ControlCount > 0 then
    begin
      for I := 0 to wControl.ControlCount - 1 do
        if wControl.Controls[I] is TWinControl then
          SetUpControl(TWinControl(wControl.Controls[I]));
    end else
    begin
      if wControl is TComboBox then
      begin
        wComboBox := TComboBox(wControl);
        if not Assigned(wComboBox.OnDropDown) then
          wComboBox.OnDropDown := cbAutoWidth;
      end;

      FReportCollection.GetNoteItemAddifNil(wControl);
    end;
  end;

begin
  inherited Create(AOwner);

  RPCBrokerV := Broker^;
  FDebugMode := DebugMode;
  FIEN := iIEN;

  FReturnList := TStringList.Create;
  FConfiguration := TStringList.Create;

  FReportCollection := TDDCSNoteCollection.Create(Self, TDDCSNoteItem);

  for I := 0 to ComponentCount - 1 do
    if Components[I] is TWinControl then
      SetUpControl(TWinControl(Components[I]));

  if RPCBrokerV = nil then
    Exit;

  sl := TStringList.Create;
  dl := TStringList.Create;
  try
    try
      if FIEN = '' then
      begin
        if UpdateContext(MENU_CONTEXT) then
          FIEN := sCallV('DSIO DDCS DIALOG LOOKUP', [ClassName]);
      end;

      if StrToIntDef(FIEN, 0) < 1 then
        Exit;

      dl.Add(IEN + ';DSIO(19641.49,');

      if UpdateContext(MENU_CONTEXT) then
        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN]);

      for I := 0 to sl.Count - 1 do
      begin
        // Control Value --------------------------------------------------
        //               CV^NAME^F^(INDEXED^VALUE)
        if Piece(sl[I],U,1) = 'CV' then
        begin
          wControl := FReportCollection.GetAControl(Piece(sl[I],U,2));

          if ((wControl <> nil) and (Piece(sl[I],U,3) = 'F')) then
            Fill(wControl, Piece(sl[I],U,4), Pieces(sl[I],U,5,9999));
        end;
      end;
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    sl.Free;
    dl.Free;
  end;
end;

destructor TDDCSDialog.Destroy;
begin
  if ModalResult <> mrCancel then
    if not DebugMode then
      Save;

  FReturnList.Free;
  FConfiguration.Free;
  FReportCollection.Free;

  inherited;
end;

procedure TDDCSDialog.Save;
var
  sl: TStringList;
  I: Integer;
  nItem: TDDCSNoteItem;
begin
  if (StrToIntDef(IEN, 0) < 1) or (RPCBrokerV = nil) then
    Exit;

  sl := TStringList.Create;
  try
    for I := 0 to ReportCollection.Count - 1 do
    begin
      nItem := ReportCollection.Items[I];

      // Data format -----------------------------------------------------------
      //   CONTROL^(INDEXED^VALUE)

      if not nItem.DoNotSave then
        sl.AddStrings(nItem.GetValueSave);
    end;

    if sl.Count > 0 then
    try
      if UpdateContext(MENU_CONTEXT) then
        CallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, FIEN + ';DSIO(19641.49,', sl]);
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    sl.Free;
  end;
end;

end.
