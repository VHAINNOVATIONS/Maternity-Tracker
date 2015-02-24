unit udlgOBEXAMHX;

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

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, oCNTBase, uExtndComBroker, Vcl.CheckLst;

type
  TdlgOBExamHx = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    Label9: TLabel;
    cbVulvNorm: TCheckBox;
    cbVulvCond: TCheckBox;
    cbVulvLes: TCheckBox;
    Label10: TLabel;
    cbVagNorm: TCheckBox;
    cbVagInflam: TCheckBox;
    cbVagDisc: TCheckBox;
    Label11: TLabel;
    cbCervNorm: TCheckBox;
    cbCervInflam: TCheckBox;
    cbCervLes: TCheckBox;
    Label12: TLabel;
    cbFibrY: TCheckBox;
    cbFibrN: TCheckBox;
    Label13: TLabel;
    cbAdnNorm: TCheckBox;
    cbAdnMas: TCheckBox;
    Label14: TLabel;
    cbRectNorm: TCheckBox;
    cbRectAbn: TCheckBox;
    edUterSize: TLabeledEdit;
    cbUterAbn: TCheckBox;
    cbUterNorm: TCheckBox;
    Label15: TLabel;
    Label16: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbPelDimAde: TCheckBox;
    cbPelDimBor: TCheckBox;
    cbPelDimCon: TCheckBox;
    cbPelDCRYes: TCheckBox;
    cbPelDCRNo: TCheckBox;
    edPelDCR: TEdit;
    cobPelTyp: TComboBox;
    cbPelSpiAve: TCheckBox;
    cbPelSpiPro: TCheckBox;
    cbPelSpiBlu: TCheckBox;
    cblstPelSpi: TCheckListBox;
    cblstPelSac: TCheckListBox;
    cblstPelSub: TCheckListBox;
    cbPelSacCon: TCheckBox;
    cbPelSacStr: TCheckBox;
    cbPelSacAnt: TCheckBox;
    cbPelSubNor: TCheckBox;
    cbPelSubWid: TCheckBox;
    cbPelSubNar: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbSwitch(Sender: TObject);
  private
    procedure ToggleCB(cb1: TCheckBox; cb2: TCheckBox);
    procedure ClickNil(cb1,cb2,cb3: TCheckBox);
    procedure ClickSet(cb1,cb2,cb3: TCheckBox);
  public
  end;

var
  dlgOBExamHx: TdlgOBExamHx;

implementation

{$R *.dfm}

procedure TdlgOBExamHx.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  TmpStr: string;
  I: Integer;
  flg: Boolean;
begin
  if (cbVulvNorm.Checked = FALSE) and (cbVulvCond.Checked = FALSE) and
     (cbVulvLes.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for VULVA.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbVagNorm.Checked = FALSE) and (cbVagInflam.Checked = FALSE) and
     (cbVagDisc.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for VAGINA.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbCervNorm.Checked = FALSE) and (cbCervInflam.Checked = FALSE) and
     (cbCervLes.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for CERVIX.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbFibrY.Checked = FALSE) and (cbFibrN.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for FIBROIDS.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbAdnNorm.Checked = FALSE) and (cbAdnMas.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for ADNEXA.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbRectNorm.Checked = FALSE) and (cbRectAbn.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for RECTUM.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbUterNorm.Checked = FALSE) and (cbUterAbn.Checked = FALSE) then
  begin
    MessageDlg('You did not check anything for UTERUS.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if (cbUterAbn.Checked = TRUE) and (edUterSize.Text = '') then
  begin
    MessageDlg('You did not enter anything for UTERUS Size.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if ((not cbPelDimAde.Checked) and (not cbPelDimBor.Checked) and (not cbPelDimCon.Checked)) then
  begin
    MessageDlg('You did not enter anything for Pelvis DIMENSIONS.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if cobPelTyp.Text = '' then
  begin
    MessageDlg('You did not enter anything for Pelvis TYPE.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if ((not cbPelDCRYes.Checked) and (not cbPelDCRNo.Checked)) then
  begin
    MessageDlg('You did not enter anything for Pelvis "Diagonal Conjugate Reached?".', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if ((not cbPelSacCon.Checked) and (not cbPelSacStr.Checked) and (not cbPelSacAnt.Checked)) then
  begin
    MessageDlg('You did not enter anything for Pelvis SACRUM.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if ((not cbPelSpiAve.Checked) and (not cbPelSpiPro.Checked) and (not cbPelSpiBlu.Checked)) then
  begin
    MessageDlg('You did not enter anything for Pelvis SPINES.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;
  if ((not cbPelSubNor.Checked) and (not cbPelSubNar.Checked) and (not cbPelSubWid.Checked)) then
  begin
    MessageDlg('You did not enter anything for Pelvis SUBPUBIC ARCH.', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end;

  if (cbVulvNorm.Checked) or (cbVulvCond.Checked) or (cbVulvLes.Checked) then
  begin
    TmpStr := '';
    TmpStr := '  Vulva: ';
    if cbVulvNorm.Checked = True then TmpStr := TmpStr + 'Normal';
    if cbVulvCond.Checked = True then TmpStr := TmpStr  + 'Condyloma';
    if cbVulvLes.Checked = True then
    begin
      if cbVulvCond.Checked = True then
      TmpStr := TmpStr + ', Lesions'
      else
      TmpStr := TmpStr + 'Lesions';
    end;
    TmpStrList.Add(TmpStr);
  end;

 if (cbVagNorm.Checked) or (cbVagInflam.Checked) or (cbVagDisc.Checked) then
  begin
    TmpStr := '';
    TmpStr := '  Vagina: ';
    if cbVagNorm.Checked = True then TmpStr := TmpStr + 'Normal';
    if cbVagInflam.Checked = True then TmpStr := TmpStr  + 'Inflammation';
    if cbVagDisc.Checked = True then
    begin
      if cbVagInflam.Checked = True then
      TmpStr := TmpStr + ', Discharge'
      else
      TmpStr := TmpStr + 'Discharge';
    end;
    TmpStrList.Add(TmpStr);
  end;

 if (cbCervNorm.Checked) or (cbCervInflam.Checked) or (cbCervLes.Checked) then
  begin
    TmpStr := '';
    TmpStr := '  Cervix: ';
    if cbCervNorm.Checked = True then TmpStr := TmpStr + 'Normal';
    if cbCervInflam.Checked = True then TmpStr := TmpStr  + 'Inflammation';
    if cbCervLes.Checked = True then
    begin
      if cbCervInflam.Checked = True then
      TmpStr := TmpStr + ', Lesions'
      else
      TmpStr := TmpStr + 'Lesions';
    end;
    TmpStrList.Add(TmpStr);
  end;

  if cbFibrY.Checked = True then TmpStrList.Add('  Fibroids: Yes');
  if cbFibrN.Checked = True then TmpStrList.Add('  Fibroids: No');
  if cbAdnNorm.Checked = True then TmpStrList.Add('  Adnexa: Normal');
  if cbAdnMas.Checked = True then TmpStrList.Add('  Adnexa: Mass');
  if cbRectNorm.Checked = True then TmpStrList.Add('  Rectum: Normal');
  if cbRectAbn.Checked = True then TmpStrList.Add('  Rectum: Abnormal');

  if cbUterNorm.Checked = True then
  begin
    TmpStrList.Add('  Uterus: Normal');
    if edUterSize.Text <> '' then
    TmpStrList.Add('    Size: ' + edUterSize.Text);
  end else if cbUterAbn.Checked = True then
  begin
    TmpStrList.Add('  Uterus: Abnormal');
    if edUterSize.Text <> '' then
    TmpStrList.Add('    Size: ' + edUterSize.Text);
  end;

  if cbPelDimAde.Checked then
  TmpStrList.Add('  Pelvis Dimensions: Adequate')
  else if cbPelDimBor.Checked then
  TmpStrList.Add('  Pelvis Dimensions: Borderline')
  else if cbPelDimCon.Checked then
  TmpStrList.Add('  Pelvis Dimensions: Contracted');

  TmpStrList.Add('  Pelvis Type: ' + cobPelTyp.Text);

  if cbPelDCRYes.Checked then
  TmpStrList.Add('  Diagonal Conjugate Reached.')
  else if cbPelDCRNo.Checked then
  TmpStrList.Add('  Diagonal Conjugate NOT Reached.');
  if edPelDCR.Text <> '' then TmpStrList.Add('    ' + edPelDCR.Text);

  if cbPelSacCon.Checked then
  TmpStrList.Add('  Pelvis Sacrum: Concave')
  else if cbPelSacStr.Checked then
  TmpStrList.Add('  Pelvis Sacrum: Straight')
  else if cbPelSacAnt.Checked then
  TmpStrList.Add('  Pelvis Sacrum: Anterior');
  for I := 0 to cblstPelSac.Count - 1 do
  begin
    if cblstPelSac.Checked[I] then
    begin
      if not flg then
      begin
        TmpStrList.Add('   Abnormalities:');
        flg := True;
      end;
      TmpStrList.Add('    ' + cblstPelSac.Items[I]);
    end;
  end;
  flg := False;

  if cbPelSpiAve.Checked then
  TmpStrList.Add('  Pelvis Spines: Average')
  else if cbPelSpiPro.Checked then
  TmpStrList.Add('  Pelvis Spines: Prominent')
  else if cbPelSpiBlu.Checked then
  TmpStrList.Add('  Pelvis Spines: Blunt');
  for I := 0 to cblstPelSpi.Count - 1 do
  begin
    if cblstPelSpi.Checked[I] then
    begin
      if not flg then
      begin
        TmpStrList.Add('   Abnormalities:');
        flg := True;
      end;
      TmpStrList.Add('    ' + cblstPelSpi.Items[I]);
    end;
  end;
  flg := False;

  if cbPelSubNor.Checked then
  TmpStrList.Add('  Pelvis Subpubic Arch: Normal')
  else if cbPelSubWid.Checked then
  TmpStrList.Add('  Pelvis Subpubic Arch: Wide')
  else if cbPelSubNar.Checked then
  TmpStrList.Add('  Pelvis Subpubic Arch: Narrow');
  for I := 0 to cblstPelSub.Count - 1 do
  begin
    if cblstPelSub.Checked[I] then
    begin
      if not flg then
      begin
        TmpStrList.Add('   Abnormalities:');
        flg := True;
      end;
      TmpStrList.Add('    ' + cblstPelSub.Items[I]);
    end;
  end;
  flg := False;

  if TmpStrList.Count > 0 then
  TmpStrList.Insert(0,'OB Exam:');
end;

procedure TdlgOBExamHx.cbSwitch(Sender: TObject);
begin
  if not (Sender is TCheckBox) then Exit;

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
    40: begin
          ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
          cbVagInflam.Checked := False;
          cbVagDisc.Checked := False;
          ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
        end;
    41: begin
          ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
          cbVagNorm.Checked := False;
          ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
        end;
    42: begin
          ClickNil(cbVagNorm, cbVagInflam, cbVagDisc);
          cbVagNorm.Checked := False;
          ClickSet(cbVagNorm, cbVagInflam, cbVagDisc);
        end;
    43: begin
          ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
          cbCervInflam.Checked := False;
          cbCervLes.Checked := False;
          ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
        end;
    44: begin
          ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
          cbCervNorm.Checked := False;
          ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
        end;
    45: begin
          ClickNil(cbCervNorm, cbCervInflam, cbCervLes);
          cbCervNorm.Checked := False;
          ClickSet(cbCervNorm, cbCervInflam, cbCervLes)
        end;
    5: ToggleCB(cbFibrY, cbFibrN);
    6: ToggleCB(cbFibrN, cbFibrY);
    7: ToggleCB(cbAdnNorm, cbAdnMas);
    8: ToggleCB(cbAdnMas, cbAdnNorm);
    9: ToggleCB(cbRectNorm, cbRectAbn);
    10: ToggleCB(cbRectAbn, cbRectNorm);
    11: ToggleCB(cbUterNorm, cbUterAbn);
    12: ToggleCB(cbUterAbn, cbUterNorm);
    19: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimBor.Checked := False;
          cbPelDimCon.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
    20: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimAde.Checked := False;
          cbPelDimCon.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
    21: begin
          ClickNil(cbPelDimAde, cbPelDimBor, cbPelDimCon);
          cbPelDimAde.Checked := False;
          cbPelDimBor.Checked := False;
          ClickSet(cbPelDimAde, cbPelDimBor, cbPelDimCon);
        end;
    23: ToggleCB(cbPelDCRYes, cbPelDCRNo);
    24: ToggleCB(cbPelDCRNo, cbPelDCRYes);
    26: begin
          ClickNil(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
          cbPelSacStr.Checked := False;
          cbPelSacAnt.Checked := False;
          ClickSet(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
        end;
    27: begin
          ClickNil(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
          cbPelSacCon.Checked := False;
          cbPelSacAnt.Checked := False;
          ClickSet(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
        end;
    28: begin
          ClickNil(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
          cbPelSacCon.Checked := False;
          cbPelSacStr.Checked := False;
          ClickSet(cbPelSacCon, cbPelSacStr, cbPelSacAnt);
        end;
    30: begin
          ClickNil(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
          cbPelSpiPro.Checked := False;
          cbPelSpiBlu.Checked := False;
          ClickSet(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
        end;
    31: begin
          ClickNil(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
          cbPelSpiAve.Checked := False;
          cbPelSpiBlu.Checked := False;
          ClickSet(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
        end;
    32: begin
          ClickNil(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
          cbPelSpiAve.Checked := False;
          cbPelSpiPro.Checked := False;
          ClickSet(cbPelSpiAve, cbPelSpiPro, cbPelSpiBlu);
        end;
    34: begin
          ClickNil(cbPelSubNor, cbPelSubWid, cbPelSubNar);
          cbPelSubWid.Checked := False;
          cbPelSubNar.Checked := False;
          ClickSet(cbPelSubNor, cbPelSubWid, cbPelSubNar);
        end;
    35: begin
          ClickNil(cbPelSubNor, cbPelSubWid, cbPelSubNar);
          cbPelSubNor.Checked := False;
          cbPelSubNar.Checked := False;
          ClickSet(cbPelSubNor, cbPelSubWid, cbPelSubNar);
        end;
    36: begin
          ClickNil(cbPelSubNor, cbPelSubWid, cbPelSubNar);
          cbPelSubNor.Checked := False;
          cbPelSubWid.Checked := False;
          ClickSet(cbPelSubNor, cbPelSubWid, cbPelSubNar);
        end;
  end;
end;

procedure TdlgOBExamHx.ToggleCB(cb1: TCheckBox; cb2: TCheckBox);
begin
  if cb1.Checked = True then
  cb2.Checked := False;
end;

procedure TdlgOBExamHx.ClickNil(cb1: TCheckBox; cb2: TCheckBox; cb3: TCheckBox);
begin
  cb1.OnClick := nil;
  cb2.OnClick := nil;
  cb3.OnClick := nil;
end;

procedure TdlgOBExamHx.ClickSet(cb1: TCheckBox; cb2: TCheckBox; cb3: TCheckBox);
begin
  cb1.OnClick := cbSwitch;
  cb2.OnClick := cbSwitch;
  cb3.OnClick := cbSwitch;
end;

end.
