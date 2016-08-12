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
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.Win.ComObj, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Themes, Vcl.Styles,
  FSAPILib_TLB, uBase, uCommon, uReportItems, uExtndComBroker;

Type
  TDDCSDialog = class(TForm)
  private
    FConfiguration: TConfigCollection;
    FReportCollection: TDDCSNoteCollection;
    FReturnList: TStringList;
    FDebugMode: Boolean;
    FIEN: string;
    FScreenReader: IJawsApi;
    procedure SetConfigCollection(const Value: TConfigCollection);
    procedure SetNoteCollection(const Value: TDDCSNoteCollection);
    procedure cbAutoWidth(Sender: TObject);
    procedure RadioGroupEnter(Sender: TObject);
    procedure ActiveControlChanged(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeTheme(Style: string);
  public
    constructor Create; overload;
    constructor Create(Broker: PCPRSComBroker; sIEN: string; DebugMode: Boolean; sTheme: string); overload;
    destructor Destroy; override;
    procedure SayOnFocus(wControl: TWinControl; tSay: string);
    procedure BuildSaveList(var oText: TStringList);
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property DebugMode: Boolean read FDebugMode write FDebugMode;
    property IEN: string read FIEN write FIEN;
    property Configuration: TConfigCollection read FConfiguration write SetConfigCollection;
    property ScreenReader: IJawsApi read FScreenReader;
  published
    property ReportCollection: TDDCSNoteCollection read FReportCollection write SetNoteCollection;
  end;

  TDialogClass = class of TDDCSDialog;

  procedure Register;

implementation

procedure Register;
begin
  RegisterClass(TDDCSDialog);
end;

{$REGION 'TDDCSDialog'}

// Private ---------------------------------------------------------------------

procedure TDDCSDialog.SetConfigCollection(const Value: TConfigCollection);
begin
  FConfiguration.Assign(Value);
end;

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

procedure TDDCSDialog.RadioGroupEnter(Sender: TObject);
var
  rg: TRadioGroup;
  I: Integer;
begin
  if not Sender.InheritsFrom(TRadioGroup) then
    Exit;

  rg := TRadioGroup(Sender);
  if rg.ItemIndex = -1 then
    for I := 0 to rg.ControlCount - 1 do
      TWinControl(rg.Controls[0]).TabStop := True;
end;

procedure TDDCSDialog.ActiveControlChanged(Sender: TObject);
var
  nItem: TDDCSNoteItem;
begin
  nItem := FReportCollection.GetNoteItem(ActiveControl);
  if nItem <> nil then
    if nItem.SayOnFocus <> '' then
      if Assigned(ScreenReader) then
        ScreenReader.SayString(nItem.SayOnFocus, False);
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

procedure TDDCSDialog.ChangeTheme(Style: string);
begin
  if Assigned(TStyleManager.ActiveStyle) then
  try
    if Style = 'Default' then
      TStyleManager.TrySetStyle('Windows')
    else
      TStyleManager.TrySetStyle(Style);
  except
  end;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSDialog.Create;
begin
  inherited Create(nil);

  RPCBrokerV := nil;
  FDebugMode := True;
  FIEN := '';

  FReturnList := TStringList.Create;

  FConfiguration := TConfigCollection.Create(Self, TConfigItem);
  FReportCollection := TDDCSNoteCollection.Create(Self, TDDCSNoteItem);
end;

constructor TDDCSDialog.Create(Broker: PCPRSComBroker; sIEN: string; DebugMode: Boolean; sTheme: string);
var
  sl,dl: TStringList;
  I,cI,cII,cIII: Integer;
  wControl: TWinControl;
  p1,p2,p3,tmp: string;
  cD: Char;
  cItem: TConfigItem;

  procedure SetUpControl(wControl: TWinControl);
  var
    I: Integer;
    wComboBox: TComboBox;
    wRadioGroup: TRadioGroup;
  begin
    if (((wControl.InheritsFrom(TCustomPanel)) or (wControl.InheritsFrom(TCustomGroupBox)) or
         (wControl.InheritsFrom(TCustomTabControl))) and (not wControl.InheritsFrom(TRadioGroup)) and
       (wControl.ControlCount > 0)) then
    begin
      for I := 0 to wControl.ControlCount - 1 do
        if wControl.Controls[I] is TWinControl then
          SetUpControl(TWinControl(wControl.Controls[I]));
    end else
    begin
      if wControl is TStaticText then
        Exit;

      if wControl.InheritsFrom(TComboBox) then
      begin
        wComboBox := TComboBox(wControl);
        if not Assigned(wComboBox.OnDropDown) then
          wComboBox.OnDropDown := cbAutoWidth;
      end;

      if wControl.InheritsFrom(TRadioGroup) then
      begin
        wRadioGroup := TRadioGroup(wControl);
        if not Assigned(wRadioGroup.OnEnter) then
          wRadioGroup.OnEnter :=  RadioGroupEnter;
      end;

      FReportCollection.GetNoteItemAddifNil(wControl);
    end;
  end;

begin
  inherited Create(nil);

  ChangeTheme(sTheme);

  Screen.OnActiveControlChange := ActiveControlChanged;

  RPCBrokerV := Broker^;
  FDebugMode := DebugMode;
  FIEN := sIEN;

  FReturnList := TStringList.Create;

  FConfiguration := TConfigCollection.Create(Self, TConfigItem);
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
      if UpdateContext(MENU_CONTEXT) then
      begin
        dl.Add(IEN + ';DSIO(19641.49,');
        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.TIUNote.IEN]);

        for I := 0 to sl.Count - 1 do
        begin
          // Control Value --------------------------------------------------
          //               CV^NAME^F^(INDEXED^VALUE)
          if Piece(sl[I],U,1) = 'CV' then
          begin
            wControl := FReportCollection.GetAControl(Piece(sl[I],U,2));

            if ((wControl <> nil) and (Piece(sl[I],U,3) = 'F')) then
              Fill(wControl, Piece(sl[I],U,4), Pieces(sl[I],U,5,999));
          end;
        end;
        sl.Clear;

        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.TIUNote.IEN, '1']);
        if sl.Count > 1 then
        begin
          cI   := StrToIntDef(Piece(Piece(sl[0],':',1),',',1), 0);
          cII  := StrToIntDef(Piece(Piece(sl[0],':',1),',',2), 0);
          cIII := StrToIntDef(Piece(Piece(sl[0],':',1),',',3), 0);
          FConfiguration.Pieces[1] := cI;
          FConfiguration.Pieces[2] := cII;
          FConfiguration.Pieces[3] := cIII;

          tmp := Piece(sl[0],':',2);
          if tmp <> '' then
            cD := tmp[1]
          else cD := U;
          FConfiguration.Delimiter := cD;

          for I := 1 to sl.Count - 1 do
          begin
            if CI > 0 then
              p1 := Piece(sl[I],cD,cI)
            else p1 := '';
            if CII > 0 then
              p2 := Piece(sl[I],cD,cII)
            else p2 := '';
            if CIII > 0 then
              p3 := Piece(sl[I],cD,cIII)
            else p3 := '';

            cItem := FConfiguration.LookUp(p1, p2, p3);
            if cItem = nil then
            begin
              cItem := TConfigItem.Create(FConfiguration);
              cItem.ID[1] := p1;
              cItem.ID[2] := p2;
              cItem.ID[3] := p3;
            end;
            cItem.Data.Add(sl[I]);
          end;
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

  try
    FScreenReader := CreateComObject(CLASS_JawsApi) as IJawsApi;
  except
  end;
end;

destructor TDDCSDialog.Destroy;
begin
  Screen.OnActiveControlChange := nil;

  FreeAndNil(FReturnList);
  FreeAndNil(FConfiguration);
  FreeAndNil(FReportCollection);

  inherited;
end;

procedure TDDCSDialog.SayOnFocus(wControl: TWinControl; tSay: string);
var
  nItem: TDDCSNoteItem;
begin
  nItem := FReportCollection.GetNoteItemAddifNil(wControl);
  if nItem <> nil then
    nItem.SayOnFocus := tSay;
end;

procedure TDDCSDialog.BuildSaveList(var oText: TStringList);
var
  sl: TStringList;
  I: Integer;
  nItem: TDDCSNoteItem;
begin
  oText.Clear;

  sl := TStringList.Create;
  try
    try
      for I := 0 to FReportCollection.Count - 1 do
      begin
        nItem := FReportCollection.Items[I];

        // Data format ---------------------------------------------------------
        //   CONTROL^(INDEXED^VALUE)

        if not nItem.DoNotSave then
        begin
          nItem.GetValueSave(sl);
          if sl.Count > 0 then
            oText.AddStrings(sl);
          sl.Clear;
        end;
      end;
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    sl.Free;
  end;
end;

{$ENDREGION}

end.
