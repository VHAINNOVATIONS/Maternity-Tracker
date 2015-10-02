object dlgWheezing: TdlgWheezing
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 228
  ClientWidth = 284
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
    Left = 10
    Top = 81
    Width = 103
    Height = 14
    Caption = 'Shortness of breath?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 284
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
      Width = 80
      Height = 20
      Caption = 'Wheezing'
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
    Top = 199
    Width = 284
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object bbtnOK: TBitBtn
      Left = 126
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 207
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 75
    Top = 50
    Width = 187
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leAssocSym: TLabeledEdit
    Left = 16
    Top = 160
    Width = 246
    Height = 22
    EditLabel.Width = 111
    EditLabel.Height = 14
    EditLabel.Caption = 'Associated Symptoms:'
    TabOrder = 5
  end
  object leDur: TLabeledEdit
    Left = 75
    Top = 110
    Width = 187
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 4
    Visible = False
  end
  object cbSOBY: TCheckBox
    Tag = 1
    Left = 126
    Top = 81
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 2
    OnClick = cbSOBYClick
  end
  object cbSOBN: TCheckBox
    Tag = 2
    Left = 178
    Top = 81
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 3
    OnClick = cbSOBYClick
  end
end
