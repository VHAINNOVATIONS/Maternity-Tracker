object dlgFetalMov: TdlgFetalMov
  Left = 197
  Top = 176
  BorderStyle = bsDialog
  ClientHeight = 300
  ClientWidth = 506
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
  object Label3: TLabel
    Left = 16
    Top = 52
    Width = 121
    Height = 14
    Caption = 'Fetal movement present?'
  end
  object Label1: TLabel
    Left = 291
    Top = 52
    Width = 67
    Height = 14
    Caption = 'Contractions?'
  end
  object Label2: TLabel
    Left = 16
    Top = 179
    Width = 84
    Height = 14
    Caption = 'Vaginal bleeding?'
  end
  object Label4: TLabel
    Left = 16
    Top = 202
    Width = 83
    Height = 14
    Caption = 'Leakage of fluid?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 506
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
      Width = 210
      Height = 20
      Caption = 'Change in fetal movement'
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
    Top = 271
    Width = 506
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 15
    object bbtnOK: TBitBtn
      Left = 347
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 428
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 51
    Top = 227
    Width = 186
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 9
  end
  object leCharFetal: TLabeledEdit
    Left = 16
    Top = 142
    Width = 222
    Height = 22
    EditLabel.Width = 146
    EditLabel.Height = 14
    EditLabel.Caption = 'Character of fetal movements:'
    TabOrder = 4
  end
  object leLastMov: TLabeledEdit
    Left = 16
    Top = 95
    Width = 222
    Height = 22
    EditLabel.Width = 183
    EditLabel.Height = 14
    EditLabel.Caption = 'Date/time of last perceived movement:'
    TabOrder = 3
  end
  object leFreq: TLabeledEdit
    Left = 332
    Top = 75
    Width = 148
    Height = 22
    EditLabel.Width = 55
    EditLabel.Height = 14
    EditLabel.Caption = 'Frequency:'
    LabelPosition = lpLeft
    TabOrder = 12
    Visible = False
  end
  object leOnset1: TLabeledEdit
    Left = 332
    Top = 131
    Width = 148
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 14
    Visible = False
  end
  object cbFetMovY: TCheckBox
    Tag = 1
    Left = 149
    Top = 52
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = cbFetMovYClick
  end
  object cbFetMovN: TCheckBox
    Tag = 2
    Left = 201
    Top = 52
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = cbFetMovYClick
  end
  object cbContY: TCheckBox
    Tag = 7
    Left = 375
    Top = 52
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = cbFetMovYClick
  end
  object cbContN: TCheckBox
    Tag = 8
    Left = 444
    Top = 52
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = cbFetMovYClick
  end
  object cbVagBleY: TCheckBox
    Tag = 3
    Left = 138
    Top = 178
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = cbFetMovYClick
  end
  object cbVagBleN: TCheckBox
    Tag = 4
    Left = 191
    Top = 178
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = cbFetMovYClick
  end
  object cbLeakY: TCheckBox
    Tag = 5
    Left = 138
    Top = 201
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 7
    OnClick = cbFetMovYClick
  end
  object cbLeakN: TCheckBox
    Tag = 6
    Left = 191
    Top = 201
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 8
    OnClick = cbFetMovYClick
  end
  object leDur: TLabeledEdit
    Left = 332
    Top = 103
    Width = 148
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 13
    Visible = False
  end
end
