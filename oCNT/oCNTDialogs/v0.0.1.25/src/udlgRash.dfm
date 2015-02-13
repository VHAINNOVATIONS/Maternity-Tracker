object dlgRash: TdlgRash
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 171
  ClientWidth = 306
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
    Left = 26
    Top = 112
    Width = 37
    Height = 14
    Caption = 'Itching?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 306
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
      Width = 103
      Height = 20
      Caption = 'Rash/Itching'
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
    Top = 142
    Width = 306
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object bbtnOK: TBitBtn
      Left = 148
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 229
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 67
    Top = 50
    Width = 206
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leLocat: TLabeledEdit
    Left = 67
    Top = 80
    Width = 206
    Height = 22
    EditLabel.Width = 44
    EditLabel.Height = 14
    EditLabel.Caption = 'Location:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object cbItchY: TCheckBox
    Tag = 1
    Left = 67
    Top = 112
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = cbItchYClick
  end
  object cbItchN: TCheckBox
    Tag = 2
    Left = 118
    Top = 112
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = cbItchYClick
  end
end
