object dlgVagBleed: TdlgVagBleed
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 176
  ClientWidth = 481
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
    Left = 251
    Top = 51
    Width = 193
    Height = 14
    Caption = 'Associated wth cramping/contractions?'
  end
  object Label1: TLabel
    Left = 251
    Top = 115
    Width = 83
    Height = 14
    Caption = 'Leakage of fluid?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 481
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
      Width = 136
      Height = 20
      Caption = 'Vaginal Bleeding'
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
    Top = 147
    Width = 481
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    object bbtnOK: TBitBtn
      Left = 323
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 404
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 56
    Top = 54
    Width = 145
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leAmt: TLabeledEdit
    Left = 56
    Top = 112
    Width = 145
    Height = 22
    EditLabel.Width = 40
    EditLabel.Height = 14
    EditLabel.Caption = 'Amount:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object leDur: TLabeledEdit
    Left = 56
    Top = 83
    Width = 145
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object cbCrampY: TCheckBox
    Tag = 1
    Left = 342
    Top = 69
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = cbCrampYClick
  end
  object cbCrampN: TCheckBox
    Tag = 2
    Left = 391
    Top = 69
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = cbCrampYClick
  end
  object cbLeakY: TCheckBox
    Tag = 3
    Left = 342
    Top = 115
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = cbCrampYClick
  end
  object cbLeakN: TCheckBox
    Tag = 4
    Left = 391
    Top = 115
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = cbCrampYClick
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgVagBleed'
        'Status = stsDefault'))
  end
end
