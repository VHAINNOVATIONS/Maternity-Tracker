object dlgOBExamHx: TdlgOBExamHx
  Left = 193
  Top = 174
  BorderStyle = bsDialog
  ClientHeight = 454
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 21
    Top = 156
    Width = 652
    Height = 253
    AutoSize = False
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
  end
  object Label9: TLabel
    Left = 21
    Top = 56
    Width = 31
    Height = 14
    Caption = 'Vulva:'
  end
  object Label10: TLabel
    Left = 21
    Top = 76
    Width = 287
    Height = 17
    AutoSize = False
    Caption = 'Vagina:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label11: TLabel
    Left = 21
    Top = 96
    Width = 34
    Height = 14
    Caption = 'Cervix:'
  end
  object Label12: TLabel
    Left = 21
    Top = 116
    Width = 316
    Height = 17
    AutoSize = False
    Caption = 'Fibroids:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label13: TLabel
    Left = 357
    Top = 56
    Width = 41
    Height = 14
    Caption = 'Adnexa:'
  end
  object Label14: TLabel
    Left = 357
    Top = 76
    Width = 316
    Height = 17
    AutoSize = False
    Caption = 'Rectum:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 357
    Top = 96
    Width = 35
    Height = 14
    Caption = 'Uterus:'
  end
  object Label16: TLabel
    Left = 34
    Top = 164
    Width = 33
    Height = 14
    Caption = 'Pelvis'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label2: TLabel
    Left = 34
    Top = 191
    Width = 55
    Height = 14
    Caption = 'Dimensions'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label3: TLabel
    Left = 34
    Top = 249
    Width = 144
    Height = 14
    Caption = 'Diagonal Conjugate Reached?'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label4: TLabel
    Left = 357
    Top = 191
    Width = 33
    Height = 14
    Caption = 'Spines'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label5: TLabel
    Left = 34
    Top = 300
    Width = 37
    Height = 14
    Caption = 'Sacrum'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label6: TLabel
    Left = 357
    Top = 300
    Width = 71
    Height = 14
    Caption = 'Subpubic Arch'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label7: TLabel
    Left = 34
    Top = 220
    Width = 23
    Height = 14
    Caption = 'Type'
    Color = clMoneyGreen
    ParentColor = False
  end
  object cbUterNorm: TCheckBox
    Tag = 11
    Left = 410
    Top = 96
    Width = 55
    Height = 17
    Caption = 'Normal'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 16
    OnClick = cbSwitch
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 75
      Height = 20
      Caption = 'OB Exam'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 425
    Width = 694
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 38
    object bbtnOK: TBitBtn
      Left = 535
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 616
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object cbVulvNorm: TCheckBox
    Tag = 1
    Left = 74
    Top = 56
    Width = 66
    Height = 17
    Caption = 'Normal'
    TabOrder = 1
    OnClick = cbSwitch
  end
  object cbVulvCond: TCheckBox
    Tag = 2
    Left = 147
    Top = 56
    Width = 77
    Height = 17
    Caption = 'Condyloma'
    TabOrder = 2
    OnClick = cbSwitch
  end
  object cbVulvLes: TCheckBox
    Tag = 3
    Left = 235
    Top = 56
    Width = 63
    Height = 17
    Caption = 'Lesions'
    TabOrder = 3
    OnClick = cbSwitch
  end
  object cbVagNorm: TCheckBox
    Tag = 40
    Left = 74
    Top = 76
    Width = 67
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    OnClick = cbSwitch
  end
  object cbVagInflam: TCheckBox
    Tag = 41
    Left = 147
    Top = 76
    Width = 82
    Height = 17
    Caption = 'Inflammation'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 5
    OnClick = cbSwitch
  end
  object cbVagDisc: TCheckBox
    Tag = 42
    Left = 235
    Top = 76
    Width = 102
    Height = 17
    Caption = 'Discharge'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 6
    OnClick = cbSwitch
  end
  object cbCervNorm: TCheckBox
    Tag = 43
    Left = 74
    Top = 96
    Width = 66
    Height = 17
    Caption = 'Normal'
    TabOrder = 7
    OnClick = cbSwitch
  end
  object cbCervInflam: TCheckBox
    Tag = 44
    Left = 147
    Top = 96
    Width = 82
    Height = 17
    Caption = 'Inflammation'
    TabOrder = 8
    OnClick = cbSwitch
  end
  object cbCervLes: TCheckBox
    Tag = 45
    Left = 235
    Top = 96
    Width = 62
    Height = 17
    Caption = 'Lesions'
    TabOrder = 9
    OnClick = cbSwitch
  end
  object cbFibrY: TCheckBox
    Tag = 5
    Left = 74
    Top = 116
    Width = 44
    Height = 17
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 10
    OnClick = cbSwitch
  end
  object cbFibrN: TCheckBox
    Tag = 6
    Left = 147
    Top = 116
    Width = 38
    Height = 17
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = cbSwitch
  end
  object cbAdnNorm: TCheckBox
    Tag = 7
    Left = 410
    Top = 56
    Width = 66
    Height = 17
    Caption = 'Normal'
    TabOrder = 12
    OnClick = cbSwitch
  end
  object cbAdnMas: TCheckBox
    Tag = 8
    Left = 483
    Top = 56
    Width = 55
    Height = 17
    Caption = 'Mass'
    TabOrder = 13
    OnClick = cbSwitch
  end
  object cbRectNorm: TCheckBox
    Tag = 9
    Left = 410
    Top = 76
    Width = 67
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 14
    OnClick = cbSwitch
  end
  object cbRectAbn: TCheckBox
    Tag = 10
    Left = 483
    Top = 76
    Width = 72
    Height = 17
    Caption = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 15
    OnClick = cbSwitch
  end
  object cbUterAbn: TCheckBox
    Tag = 12
    Left = 483
    Top = 96
    Width = 72
    Height = 17
    Caption = 'Abnormal'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 17
    OnClick = cbSwitch
  end
  object cbPelDimAde: TCheckBox
    Tag = 19
    Left = 100
    Top = 191
    Width = 82
    Height = 17
    Caption = 'Adequate'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 19
    OnClick = cbSwitch
  end
  object cbPelDimBor: TCheckBox
    Tag = 20
    Left = 175
    Top = 191
    Width = 97
    Height = 17
    Caption = 'Borderline'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 20
    OnClick = cbSwitch
  end
  object cbPelDimCon: TCheckBox
    Tag = 21
    Left = 250
    Top = 191
    Width = 75
    Height = 17
    Caption = 'Contracted'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 21
    OnClick = cbSwitch
  end
  object cbPelDCRYes: TCheckBox
    Tag = 23
    Left = 34
    Top = 272
    Width = 40
    Height = 17
    Caption = 'Yes'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 23
    OnClick = cbSwitch
  end
  object cbPelDCRNo: TCheckBox
    Tag = 24
    Left = 79
    Top = 272
    Width = 37
    Height = 17
    Caption = 'No'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 24
    OnClick = cbSwitch
  end
  object edPelDCR: TEdit
    Left = 121
    Top = 269
    Width = 204
    Height = 22
    TabOrder = 25
  end
  object edUterSize: TLabeledEdit
    Left = 410
    Top = 116
    Width = 102
    Height = 22
    EditLabel.Width = 24
    EditLabel.Height = 14
    EditLabel.Caption = 'Size:'
    LabelPosition = lpLeft
    TabOrder = 18
  end
  object cobPelTyp: TComboBox
    Left = 100
    Top = 217
    Width = 225
    Height = 22
    Style = csDropDownList
    TabOrder = 22
  end
  object cbPelSpiAve: TCheckBox
    Tag = 30
    Left = 357
    Top = 214
    Width = 65
    Height = 17
    Caption = 'Average'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 30
    OnClick = cbSwitch
  end
  object cbPelSpiPro: TCheckBox
    Tag = 31
    Left = 428
    Top = 214
    Width = 97
    Height = 17
    Caption = 'Prominent'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 31
    OnClick = cbSwitch
  end
  object cbPelSpiBlu: TCheckBox
    Tag = 32
    Left = 504
    Top = 214
    Width = 97
    Height = 17
    Caption = 'Blunt'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 32
    OnClick = cbSwitch
  end
  object cblstPelSpi: TCheckListBox
    Left = 357
    Top = 237
    Width = 300
    Height = 54
    ItemHeight = 14
    TabOrder = 33
  end
  object cblstPelSac: TCheckListBox
    Left = 34
    Top = 341
    Width = 291
    Height = 54
    ItemHeight = 14
    TabOrder = 29
  end
  object cblstPelSub: TCheckListBox
    Left = 357
    Top = 341
    Width = 300
    Height = 54
    ItemHeight = 14
    TabOrder = 37
  end
  object cbPelSacCon: TCheckBox
    Tag = 26
    Left = 34
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Concave'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 26
    OnClick = cbSwitch
  end
  object cbPelSacStr: TCheckBox
    Tag = 27
    Left = 112
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Straight'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 27
    OnClick = cbSwitch
  end
  object cbPelSacAnt: TCheckBox
    Tag = 28
    Left = 181
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Anterior'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 28
    OnClick = cbSwitch
  end
  object cbPelSubNor: TCheckBox
    Tag = 34
    Left = 357
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 34
    OnClick = cbSwitch
  end
  object cbPelSubWid: TCheckBox
    Tag = 35
    Left = 428
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Wide'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 35
    OnClick = cbSwitch
  end
  object cbPelSubNar: TCheckBox
    Tag = 36
    Left = 504
    Top = 320
    Width = 97
    Height = 17
    Caption = 'Narrow'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 36
    OnClick = cbSwitch
  end
end
