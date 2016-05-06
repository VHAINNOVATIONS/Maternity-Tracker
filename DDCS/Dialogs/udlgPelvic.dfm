object dlgPelvic: TdlgPelvic
  Left = 193
  Top = 174
  BorderStyle = bsDialog
  ClientHeight = 454
  ClientWidth = 420
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
  object Label9: TLabel
    Left = 21
    Top = 49
    Width = 378
    Height = 21
    AutoSize = False
    Caption = 'Vulva:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label11: TLabel
    Left = 21
    Top = 100
    Width = 378
    Height = 21
    AutoSize = False
    Caption = 'Cervix:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label13: TLabel
    Left = 21
    Top = 127
    Width = 41
    Height = 14
    Caption = 'Adnexa:'
  end
  object Label15: TLabel
    Left = 21
    Top = 150
    Width = 378
    Height = 21
    AutoSize = False
    Caption = 'Uterus:'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label16: TLabel
    Left = 21
    Top = 290
    Width = 176
    Height = 14
    Caption = 'Clinical Pelvimetry Assessment'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label1: TLabel
    Left = 352
    Top = 152
    Width = 33
    Height = 14
    Caption = 'Weeks'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label2: TLabel
    Left = 21
    Top = 183
    Width = 53
    Height = 14
    Caption = 'Comments:'
  end
  object Label3: TLabel
    Left = 21
    Top = 76
    Width = 33
    Height = 14
    Caption = 'Vagina'
  end
  object cbUterNorm: TCheckBox
    Tag = 12
    Left = 74
    Top = 152
    Width = 55
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = cbSwitch
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 420
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 96
      Height = 20
      Caption = 'Pelvic Exam'
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
    Width = 420
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 20
    DesignSize = (
      420
      29)
    object bbtnOK: TBitBtn
      Left = 261
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 342
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object cbVulvNorm: TCheckBox
    Tag = 1
    Left = 74
    Top = 51
    Width = 66
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 0
    OnClick = cbSwitch
  end
  object cbVulvCond: TCheckBox
    Tag = 2
    Left = 156
    Top = 51
    Width = 77
    Height = 17
    Caption = 'Condyloma'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 1
    OnClick = cbSwitch
  end
  object cbVulvLes: TCheckBox
    Tag = 3
    Left = 269
    Top = 51
    Width = 63
    Height = 17
    Caption = 'Lesions'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 2
    OnClick = cbSwitch
  end
  object cbVagNorm: TCheckBox
    Tag = 4
    Left = 74
    Top = 76
    Width = 67
    Height = 17
    Caption = 'Normal'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
    OnClick = cbSwitch
  end
  object cbVagInflam: TCheckBox
    Tag = 5
    Left = 156
    Top = 76
    Width = 82
    Height = 17
    Caption = 'Inflammation'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
    OnClick = cbSwitch
  end
  object cbVagDisc: TCheckBox
    Tag = 6
    Left = 269
    Top = 76
    Width = 102
    Height = 17
    Caption = 'Discharge'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 5
    OnClick = cbSwitch
  end
  object cbCervNorm: TCheckBox
    Tag = 7
    Left = 74
    Top = 102
    Width = 66
    Height = 17
    Caption = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 6
    OnClick = cbSwitch
  end
  object cbCervInflam: TCheckBox
    Tag = 8
    Left = 156
    Top = 102
    Width = 82
    Height = 17
    Caption = 'Inflammation'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 7
    OnClick = cbSwitch
  end
  object cbCervLes: TCheckBox
    Tag = 9
    Left = 269
    Top = 102
    Width = 62
    Height = 17
    Caption = 'Lesions'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 8
    OnClick = cbSwitch
  end
  object cbAdnNorm: TCheckBox
    Tag = 10
    Left = 74
    Top = 127
    Width = 66
    Height = 17
    Caption = 'Normal'
    TabOrder = 9
    OnClick = cbSwitch
  end
  object cbAdnMas: TCheckBox
    Tag = 11
    Left = 156
    Top = 127
    Width = 55
    Height = 17
    Caption = 'Mass'
    TabOrder = 10
    OnClick = cbSwitch
  end
  object cbUterAbn: TCheckBox
    Tag = 13
    Left = 156
    Top = 152
    Width = 72
    Height = 17
    Caption = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 12
    OnClick = cbSwitch
  end
  object cbPelDimAde: TCheckBox
    Tag = 14
    Left = 34
    Top = 310
    Width = 82
    Height = 17
    Caption = 'Adequate'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 15
    OnClick = cbSwitch
  end
  object cbPelDimBor: TCheckBox
    Tag = 15
    Left = 156
    Top = 310
    Width = 97
    Height = 17
    Caption = 'Borderline'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 16
    OnClick = cbSwitch
  end
  object cbPelDimCon: TCheckBox
    Tag = 16
    Left = 280
    Top = 310
    Width = 75
    Height = 17
    Caption = 'Inadequate'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 17
    OnClick = cbSwitch
  end
  object edUterSize: TLabeledEdit
    Left = 269
    Top = 149
    Width = 78
    Height = 22
    Color = clWhite
    EditLabel.Width = 24
    EditLabel.Height = 14
    EditLabel.Caption = 'Size:'
    EditLabel.Color = clMoneyGreen
    EditLabel.ParentColor = False
    LabelPosition = lpLeft
    TabOrder = 13
  end
  object memPelvimetry: TMemo
    Left = 21
    Top = 334
    Width = 378
    Height = 85
    ScrollBars = ssVertical
    TabOrder = 18
  end
  object memComments: TMemo
    Left = 21
    Top = 200
    Width = 378
    Height = 76
    ScrollBars = ssVertical
    TabOrder = 14
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgPelvic'
        'Status = stsDefault'))
  end
end
