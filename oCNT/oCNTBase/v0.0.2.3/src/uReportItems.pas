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
  Dialogs, StdCtrls, Buttons, Contnrs, ComCtrls, uExtndComBroker;

type

  TNoteItem = class(TCollectionItem)
    private
      FLabel: string;
      FTitle: string;
      FBValue: string;
      FAVaule: string;
      FHide: Boolean;
      FSave: Boolean;
      FObject: TWinControl;
      FRequired: Boolean;
      FReturn: TWinControl;
      FVistAConfig: TStringList;
    protected
      function GetDisplayName: string; override;
      procedure SetObject(Value: TWinControl);
      procedure SetDialogReturn(Value: TWinControl);
    public
      constructor Create(Collection: TCollection); override;
      destructor Destroy; override;
      procedure Assign(Source: TPersistent); override;
      procedure SetIndex(Value: Integer); override;
      property VistAConfig: TStringList read FVistAConfig write FVistAConfig;
    published
      property VistALabel: string read FLabel write FLabel;
      property Title: string read FTitle write FTitle;
      property BeforeValue: string read FBValue write FBValue;
      property AfterValue: string read FAVaule write FAVaule;
      property HideFromNote: Boolean read FHide write FHide;
      property DoNotSave: Boolean read FSave write FSave;
      property OwningObject: TWinControl read  FObject write SetObject;
      property Required: Boolean read FRequired write FRequired;
      property DialogReturn: TWinControl read FReturn write SetDialogReturn;
  end;

  TNoteCollection = class(TOwnedCollection)
    private
    protected
      procedure SetItem(Index: Integer; const Value: TNoteItem);
    public
      constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
      destructor Destroy; override;
      procedure Assign(Source: TPersistent); override;
      procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
      procedure DeleteItem(Item: TNoteItem);
      function GetItem(Index: Integer): TNoteItem; overload;
      function GetItem(Value: TWinControl): TNoteItem; overload;
      function GetItem(Value: string): TNoteItem; overload;
//      function Add: TNoteItem; overload;
      function Add(Value: TWinControl): TNoteItem;
      property Items[Index: Integer]: TNoteItem read GetItem write SetItem;
  end;
  PCollection = ^TNoteCollection;

var
  RCollection: PCollection;

implementation

uses
  oCNTBase;

{ TNoteItem }
constructor TNoteItem.Create(Collection: TCollection);
begin
  inherited;
  FVistAConfig := TStringList.Create;
end;

destructor TNoteItem.Destroy;
begin
  FVistAConfig.Free;
  inherited;
end;

procedure TNoteItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
end;

function TNoteItem.GetDisplayName: string;
begin
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
  with TNoteItem(Source) do
  begin
    FLabel := TNoteItem(Source).FLabel;
    FTitle := TNoteItem(Source).FTitle;
    FBValue := TNoteItem(Source).FBValue;
    FAVaule := TNoteItem(Source).FAVaule;
    FHide := TNoteItem(Source).FHide;
    FObject := TNoteItem(Source).FObject;
    FRequired := TNoteItem(Source).FRequired;
    FReturn := TNoteItem(Source).FReturn;

    //This actually assigns
    Self.VistALabel := VistALabel;
    Self.Title := Title;
    Self.BeforeValue := BeforeValue;
    Self.AfterValue := AfterValue;
    Self.HideFromNote := HideFromNote;
    Self.DoNotSave := DoNotSave;
    Self.OwningObject := OwningObject;
    Self.Required := Required;
    Self.DialogReturn := DialogReturn;
  end else inherited;
end;

{ TNoteCollection }
constructor TNoteCollection.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited;
end;

destructor TNoteCollection.Destroy;
begin
  inherited;
end;

//function TNoteCollection.Add: TNoteItem;
//begin
//  Result := TNoteItem(inherited Add);
//end;

function TNoteCollection.Add(Value: TWinControl): TNoteItem;
begin
  Result := GetItem(Value);
  if Result = nil then
  begin
    Result := TNoteItem(inherited Add);
    Result.FObject := Value;
  end;
end;

procedure TNoteCollection.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TNoteCollection then
  begin
    Clear;
    for I := 0 to TNoteCollection(Source).Count - 1 do
    Add(TNoteCollection(Source).Items[I].OwningObject);
  end else inherited;
end;

procedure TNoteCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  case Action of
    cnAdded: Added(Item);
    cnExtracting: DeleteItem(TNoteItem(Item));
    cnDeleting: Deleting(Item);
  end;
end;

function TNoteCollection.GetItem(Index: Integer): TNoteItem;
begin
  Result := TNoteItem(inherited Items[Index]);
end;

function TNoteCollection.GetItem(Value: TWinControl): TNoteItem;
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

function TNoteCollection.GetItem(Value: string): TNoteItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    if TWinControl(Items[I].FObject).Name = Value then
    begin
      Result := TNoteItem(Items[I]);
      Exit;
    end;
  end;
end;

procedure TNoteCollection.SetItem(Index: Integer; const Value: TNoteItem);
begin
  inherited SetItem(Index, Value)
end;

procedure TNoteCollection.DeleteItem(Item: TNoteItem);
begin
  if Item.OwningObject = nil then
  Item.Free;
end;

end.
