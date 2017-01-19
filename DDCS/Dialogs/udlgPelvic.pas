unit udlgPelvic;

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

   v2.0.0.0
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, ORCtrls, uDialog, uCommon,
  DDCSUtils, DDCSComBroker;

type
  TdlgPelvic = class(TDDCSDialog)
    lbvulva: TLabel;
    lbadnexa: TLabel;
    lbuterus: TLabel;
    lbclinical: TLabel;
    lbcervix: TLabel;
    lbsize: TLabel;
    lbcomments: TLabel;
    lbvagina: TLabel;
    cbVulvNorm: TCheckBox;
    cbVulvCond: TCheckBox;
    cbVulvLes: TCheckBox;
    cbVagNorm: TCheckBox;
    cbVagInflam: TCheckBox;
    cbVagDisc: TCheckBox;
    cbCervNorm: TCheckBox;
    cbCervInflam: TCheckBox;
    cbCervLes: TCheckBox;
    cbAdnNorm: TCheckBox;
    cbAdnMas: TCheckBox;
    cbUterAbn: TCheckBox;
    cbUterNorm: TCheckBox;
    cbPelDimAde: TCheckBox;
    cbPelDimBor: TCheckBox;
    cbPelDimCon: TCheckBox;
    edUterSize: TEdit;
    memPelvimetry: TCaptionMemo;
    memComments: TCaptionMemo;
    pnlfooter: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure cbSwitch(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgPelvic: TdlgPelvic;

implementation

{$R *.dfm}

procedure TdlgPelvic.FormCreate(Sender: TObject);
begin
  SayOnFocus(  cbVulvNorm, 'Vulva');
  SayOnFocus(  cbVulvCond, 'Vulva');
  SayOnFocus(   cbVulvLes, 'Vulva');
  SayOnFocus(   cbVagNorm, 'Vagina');
  SayOnFocus( cbVagInflam, 'Vagina');
  SayOnFocus(   cbVagDisc, 'Vagina');
  SayOnFocus(  cbCervNorm, 'Cervix');
  SayOnFocus(cbCervInflam, 'Cervix');
  SayOnFocus(   cbCervLes, 'Cervix');
  SayOnFocus(   cbAdnNorm, 'Adnexa');
  SayOnFocus(    cbAdnMas, 'Adnexa');
  SayOnFocus(  cbUterNorm, 'Uterus');
  SayOnFocus(   cbUterAbn, 'Uterus');
  SayOnFocus(  edUterSize, 'Uterus size in weeks');
  SayOnFocus( cbPelDimAde, 'Clinical Pelvimetry Assessment');
  SayOnFocus( cbPelDimBor, 'Clinical Pelvimetry Assessment');
  SayOnFocus( cbPelDimCon, 'Clinical Pelvimetry Assessment');
end;

procedure TdlgPelvic.cbSwitch(Sender: TObject);

  procedure ClickNil(cb1,cb2,cb3: TCheckBox);
  begin
    cb1.OnClick := nil;
    cb2.OnClick := nil;
    cb3.OnClick := nil;
  end;

  procedure ClickSet(cb1,cb2,cb3: TCheckBox);
  begin
    cb1.OnClick := cbSwitch;
    cb2.OnClick := cbSwitch;
    cb3.OnClick := cbSwitch;
  end;

  procedure ToggleCB(cb1,cb2: TCheckBox);
  begin
    if cb1.Checked = True then
      cb2.Checked := False;
  end;

begin
  case TCheckBox(Sender).Tag of
    1: begin
         ClickNil(cbVulvNorm, cbVulvCond, cbVulvLes);
         cbVulvCond.Checked := False;
         cbVulvLes.Checked := False;
         ClickSet(cbVulvNorm, cbVulvCond, cbVulvLes);
       end;
    2: begin
         ClickNil(cbVulvNorm, cbVulvCond, cbVulvLes);
         cbVulvNorm.Checked := False;
         ClickSet(cbVulvNorm, cbVulvCond, cbVulvLes);
       end;
    3: begin
         ClickNil(cbVulvNorm, cbVulvCond, cbVulvLes);
         cbVulvNorm.Checked := False;
         ClickSet(cbVulvNorm, cbVulvCond, cbVulvLes);
       end;
    4: begin
         ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
         cbVagInflam.Checked := False;
         cbVagDisc.Checked := False;
         ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
       end;
    5: begin
         ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
         cbVagNorm.Checked := False;
         ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
       end;
    6: begin
         ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
         cbVagNorm.Checked := False;
         ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
       end;
    7: begin
         ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
         cbCervInflam.Checked := False;
         cbCervLes.Checked := False;
         ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
       end;
    8: begin
         ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
         cbCervNorm.Checked := False;
         ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
       end;
    9: begin
         ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
         cbCervNorm.Checked := False;
         ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
       end;
    10: ToggleCB(cbAdnNorm, cbAdnMas);
    11: ToggleCB(cbAdnMas, cbAdnNorm);
    12: ToggleCB(cbUterNorm, cbUterAbn);
    13: ToggleCB(cbUterAbn, cbUterNorm);

    14: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimBor.Checked := False;
          cbPelDimCon.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
    15: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimAde.Checked := False;
          cbPelDimCon.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
    16: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimAde.Checked := False;
          cbPelDimBor.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
  end;
end;

procedure TdlgPelvic.btnOKClick(Sender: TObject);
var
  TmpStr: string;
  I: Integer;
begin
  if (cbVulvNorm.Checked) or (cbVulvCond.Checked) or (cbVulvLes.Checked) then
  begin
    TmpStr := '  Vulva: ';
    if cbVulvNorm.Checked then
      TmpStr := TmpStr + 'Normal';

    if cbVulvCond.Checked then
      TmpStr := TmpStr  + 'Condyloma';

    if cbVulvLes.Checked then
    begin
      if cbVulvCond.Checked then
        TmpStr := TmpStr + ', Lesions'
      else
        TmpStr := TmpStr + 'Lesions';
    end;

    TmpStrList.Add(TmpStr);
  end;

  if (cbVagNorm.Checked) or (cbVagInflam.Checked) or (cbVagDisc.Checked) then
  begin
    TmpStr := '  Vagina: ';
    if cbVagNorm.Checked then
      TmpStr := TmpStr + 'Normal';

    if cbVagInflam.Checked then
      TmpStr := TmpStr  + 'Inflammation';

    if cbVagDisc.Checked then
    begin
      if cbVagInflam.Checked then
        TmpStr := TmpStr + ', Discharge'
      else
        TmpStr := TmpStr + 'Discharge';
    end;

    TmpStrList.Add(TmpStr);
  end;

  if (cbCervNorm.Checked) or (cbCervInflam.Checked) or (cbCervLes.Checked) then
  begin
    TmpStr := '  Cervix: ';
    if cbCervNorm.Checked then
      TmpStr := TmpStr + 'Normal';

    if cbCervInflam.Checked then
      TmpStr := TmpStr  + 'Inflammation';

    if cbCervLes.Checked then
    begin
      if cbCervInflam.Checked then
        TmpStr := TmpStr + ', Lesions'
      else
        TmpStr := TmpStr + 'Lesions';
    end;

    TmpStrList.Add(TmpStr);
  end;

  if cbAdnNorm.Checked then
    TmpStrList.Add('  Adnexa: Normal');
  if cbAdnMas.Checked then
    TmpStrList.Add('  Adnexa: Mass');

  if cbUterNorm.Checked then
  begin
    TmpStrList.Add('  Uterus: Normal');
    if edUterSize.Text <> '' then
      TmpStrList.Add('   Size: ' + edUterSize.Text + ' Weeks');
  end else if cbUterAbn.Checked then
  begin
    TmpStrList.Add('  Uterus: Abnormal');
    if edUterSize.Text <> '' then
      TmpStrList.Add('   Size: ' + edUterSize.Text + ' Weeks');
  end;

  if memComments.Lines.Count > 0 then
  begin
    TmpStrList.Add('  Comments:');
    for I := 0 to memComments.Lines.Count - 1 do
      TmpStrList.Add('   ' + memComments.Lines[I]);
  end;

  if (cbPelDimAde.Checked) or (cbPelDimBor.Checked) or (cbPelDimCon.Checked) then
  begin
    TmpStrList.Add('Clinical Pelvimetry Assessment');

    if cbPelDimAde.Checked then
      TmpStrList.Add('  Pelvis Dimensions: Adequate')
    else if cbPelDimBor.Checked then
      TmpStrList.Add('  Pelvis Dimensions: Borderline')
    else if cbPelDimCon.Checked then
      TmpStrList.Add('  Pelvis Dimensions: Inadequate');

    if memPelvimetry.Lines.Count > 0 then
    begin
      TmpStrList.Add('  Comments:');
      for I := 0 to memPelvimetry.Lines.Count - 1 do
        TmpStrList.Add('   ' + memPelvimetry.Lines[I]);
    end;
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Pelvic Exam: ');
end;

end.
