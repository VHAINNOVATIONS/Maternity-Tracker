unit uReportItems;

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
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Contnrs, ComCtrls, ExtCtrls, Spin, uExtndComBroker;

type
  TNoteItem = class(TCollectionItem)
    private
      FConfig: TStringList;
      FOrder: Integer;
      FLabel: string;
      FTitle: string;
      FPrefix: string;
      FSuffix: string;
      FHide: Boolean;
      FSave: Boolean;
      FObject: TWinControl;
      FRequired: Boolean;
      FReturn: TWinControl;
    protected
      function GetDisplayName: string; override;
      procedure SetObject(Value: TWinControl);
      procedure SetDialogReturn(Value: TWinControl);
    public
      constructor Create(Collection: TCollection); override;
      destructor Destroy; override;
      procedure Assign(Source: TPersistent); override;
      procedure SetIndex(Value: Integer); override;
      property Configuration: TStringList read FConfig write FConfig;
    published
      property Order: Integer read FOrder write FOrder;
      property VistALabel: string read FLabel write FLabel;
      property Title: string read FTitle write FTitle;
      property Prefix: string read FPrefix write FPrefix;
      property Suffix: string read FSuffix write FSuffix;
      property HideFromNote: Boolean read FHide write FHide;
      property DoNotSave: Boolean read FSave write FSave;
      property OwningObject: TWinControl read  FObject write SetObject;
      property Required: Boolean read FRequired write FRequired;
      property DialogReturn: TWinControl read FReturn write SetDialogReturn;
  end;

  TNoteCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TNoteItem; overload;
    procedure SetItem(Index: Integer; Value: TNoteItem);
  protected
  public
    function GetNoteItem(Value: TWinControl): TNoteItem;
    function AddNoteItem(Value: TWinControl): TNoteItem; overload;
    function Add: TNoteItem; overload;
    function Insert(Index: Integer): TNoteItem;
    procedure ReIndex;
    procedure DeleteNoteItem(Value: TWinControl);
    property Items[Index: Integer]: TNoteItem read GetItem write SetItem;
  end;
  PCollection = ^TNoteCollection;

var
  RCollection: PCollection;

implementation

{ TNoteItem }
constructor TNoteItem.Create(Collection: TCollection);
begin
  inherited;
  FConfig := TStringList.Create;
end;

destructor TNoteItem.Destroy;
begin
  FConfig.Free;
  inherited;
end;

procedure TNoteItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
end;

function TNoteItem.GetDisplayName: string;
begin
  if FObject = nil then
  Result := '<Owning Object Missing>'
  else
  Result := FObject.Name;
end;

procedure TNoteItem.SetObject(Value: TWinControl);
begin
  if (Assigned(FObject) and (FObject <> Value)) then
  FObject := FObject
  else FObject := Value;
end;

procedure TNoteItem.SetDialogReturn(Value: TWinControl);
begin
  if Value is TMemo or (Value is TRichEdit) then
  FReturn := Value
  else FReturn := nil;
end;

procedure TNoteItem.Assign(Source: TPersistent);
begin
  if Source is TNoteItem then
  begin
    Order := TNoteItem(Source).Order;
    VistALabel := TNoteItem(Source).VistALabel;
    Title := TNoteItem(Source).Title;
    Prefix := TNoteItem(Source).Prefix;
    Suffix := TNoteItem(Source).Suffix;
    HideFromNote := TNoteItem(Source).HideFromNote;
    DoNotSave := TNoteItem(Source).DoNotSave;
    OwningObject := TNoteItem(Source).OwningObject;
    Required := TNoteItem(Source).Required;
    DialogReturn := TNoteItem(Source).DialogReturn;
  end else inherited;
end;

{ TNoteCollection }
function TNoteCollection.Add: TNoteItem;
begin
  Result := TNoteItem(inherited Add);
end;

function TNoteCollection.AddNoteItem(Value: TWinControl): TNoteItem;
begin
  Result := GetNoteItem(Value);
  if Result = nil then
  begin
    Result := TNoteItem(inherited Add);
    Result.FObject := Value;
  end;
end;

function TNoteCollection.GetItem(Index: Integer): TNoteItem;
begin
  Result := TNoteItem(inherited Items[Index]);
end;

function TNoteCollection.GetNoteItem(Value: TWinControl): TNoteItem;
var
  I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
  begin
    if Items[I].FObject = Value then
    begin
      Result := TNoteItem(Items[I]);
      Exit;
    end;
  end;
end;

function TNoteCollection.Insert(Index: Integer): TNoteItem;
begin
  Result := TNoteItem(inherited Insert(Index));
end;

procedure TNoteCollection.ReIndex;
var
  I: Integer;
begin
  // Everything will be at 0 so 1 and greater is meaningful
  // Another thought is to have it SetIndex when the order is set but that
  // opens up problems if you set in VistA and then pull the list and get
  // numbers larger then the collection count (at that time)
  // So the component will call ReIndex once VistA configuration is complete
  for I := 0 to Count - 1 do
  begin
    if Items[I].Order > 0 then
    begin
      if Items[I].Order <= Count then
      Items[I].SetIndex(Items[I].Order - 1)
      else Items[I].SetIndex(Count - 1);
    end;
  end;
end;

procedure TNoteCollection.DeleteNoteItem(Value: TWinControl);
var
  Note: TNoteItem;
begin
  Note := GetNoteItem(Value);
  if Note <> nil then
  Delete(Note.Index);
end;

procedure TNoteCollection.SetItem(Index: Integer; Value: TNoteItem);
begin
  inherited SetItem(Index, Value);
end;

end.
