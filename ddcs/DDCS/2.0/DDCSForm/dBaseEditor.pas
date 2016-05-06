unit dBaseEditor;

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
  System.Classes, Vcl.Dialogs, Vcl.ComCtrls, DesignIntf, DesignEditors,
  DesignMenus;

type
  TDDCSPageEditor = class(TComponentEditor)
  protected
    function GetPageControl: TPageControl;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
  end;

  procedure Register;

implementation

uses
  TreeIntf, uBase, frmVitals;

procedure Register;
begin
  RegisterComponentEditor(TDDCSForm, TDDCSPageEditor);
  RegisterComponentEditor(TTabSheet, TDDCSPageEditor);
  RegisterNoIcon([TDDCSVitals]);
  RegisterSprigType(TDDCSVitals, TComponentSprig);
end;

function TDDCSPageEditor.GetPageControl: TPageControl;
var
  nComponent: TComponent;
begin
  Result := nil;

  nComponent := GetComponent;
  if not Assigned(nComponent) then
    Exit;

  if nComponent is TPageControl then
    Result := TPageControl(nComponent)
  else
    if nComponent is TTabSheet then
      Result := TPageControl(TTabSheet(nComponent).PageControl);
end;

//Your actions from the popup menu of GetVerb
procedure TDDCSPageEditor.ExecuteVerb(Index: Integer);
var
  PageControl: TPageControl;
  TabSheet: TTabSheet;
begin
  PageControl := GetPageControl;

  if not Assigned(PageControl) then
    Exit;

  case Index of
    0: begin
         TabSheet := TTabSheet(GetDesigner.CreateComponent(TTabSheet, nil, 0, 0, 0, 0));
         TabSheet.PageControl := PageControl;
         PageControl.ActivePageIndex := TabSheet.TabIndex;

         if Assigned(PageControl.OnChange) then
           PageControl.OnChange(PageControl);
       end;
    1: begin
         if PageControl.ActivePageIndex < PageControl.PageCount - 1 then
         begin
           PageControl.ActivePageIndex := PageControl.ActivePageIndex + 1;

           if Assigned(PageControl.OnChange) then
             PageControl.OnChange(PageControl);
         end;
       end;
    2: begin
         if PageControl.ActivePageIndex > 0 then
         begin
           PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;

           if Assigned(PageControl.OnChange) then
             PageControl.OnChange(PageControl);
         end;
       end;
    3: begin
         TabSheet := TTabSheet(PageControl.ActivePage);
         if Assigned(TabSheet) then
         begin
           TabSheet.PageControl := nil;
           TabSheet.Free;

           if Assigned(PageControl.OnChange) then
             PageControl.OnChange(PageControl);
         end;
       end;
  else inherited ExecuteVerb(Index);
  end;
end;

// Called the number of times you've stated you need in GetVerbCount.
// This is where you add your pop-up menu items
function TDDCSPageEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'New Page';
    1: Result := 'Next Page';
    2: Result := 'Prev Page';
    3: Result := 'Delete Page';
  else
    Result := inherited GetVerb(Index);
  end;
end;

// Called when the IDE needs to populate the menu. Return the number
// of items you intend to add to the menu.
function TDDCSPageEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;



end.
