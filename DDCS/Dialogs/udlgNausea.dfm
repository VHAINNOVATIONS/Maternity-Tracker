object dlgNausea: TdlgNausea
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Nausea, Vomiting, and Diarrhea'
  ClientHeight = 203
  ClientWidth = 502
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
  object Label3: TStaticText
    Left = 16
    Top = 48
    Width = 115
    Height = 18
    Caption = 'Can tolerate solids?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object Label4: TStaticText
    Left = 16
    Top = 80
    Width = 118
    Height = 18
    Caption = 'Can tolerate liquids?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = True
  end
  object Label5: TStaticText
    Left = 16
    Top = 144
    Width = 114
    Height = 18
    Caption = 'Fever and or Chills?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
  end
  object Label6: TStaticText
    Left = 259
    Top = 48
    Width = 96
    Height = 18
    Caption = 'Abdominal pain?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    TabStop = True
  end
  object Label1: TStaticText
    Left = 259
    Top = 16
    Width = 82
    Height = 18
    Caption = 'Contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 174
    Width = 502
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 23
    object bbtnOK: TBitBtn
      Left = 345
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 426
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TCaptionEdit
    Left = 72
    Top = 12
    Width = 159
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leLocal: TCaptionEdit
    Left = 332
    Top = 78
    Width = 156
    Height = 22
    TabOrder = 20
    Visible = False
    Caption = 'Localization'
  end
  object leDur: TCaptionEdit
    Left = 72
    Top = 109
    Width = 159
    Height = 22
    TabOrder = 9
    Caption = 'Duration'
  end
  object leDur1: TCaptionEdit
    Left = 332
    Top = 109
    Width = 156
    Height = 22
    TabOrder = 22
    Visible = False
    Caption = 'Duration'
  end
  object cbSolidY: TCheckBox
    Tag = 1
    Left = 146
    Top = 48
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = checkboxClick
  end
  object cbSolidN: TCheckBox
    Tag = 2
    Left = 195
    Top = 48
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object cbLiquidY: TCheckBox
    Tag = 3
    Left = 146
    Top = 80
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = checkboxClick
  end
  object cbLiquidN: TCheckBox
    Tag = 4
    Left = 195
    Top = 80
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = checkboxClick
  end
  object cbFeverY: TCheckBox
    Tag = 5
    Left = 146
    Top = 144
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = checkboxClick
  end
  object cbFeverN: TCheckBox
    Tag = 6
    Left = 195
    Top = 144
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = checkboxClick
  end
  object cbAbdomY: TCheckBox
    Tag = 7
    Left = 403
    Top = 48
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 17
    OnClick = checkboxClick
  end
  object cbAbdomN: TCheckBox
    Tag = 8
    Left = 452
    Top = 48
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 18
    OnClick = checkboxClick
  end
  object cbContY: TCheckBox
    Tag = 9
    Left = 403
    Top = 16
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 14
    OnClick = checkboxClick
  end
  object cbContN: TCheckBox
    Tag = 10
    Left = 452
    Top = 16
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 15
    OnClick = checkboxClick
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 16
    Width = 37
    Height = 18
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 113
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object lbLocal: TStaticText
    Left = 259
    Top = 80
    Width = 69
    Height = 18
    Caption = 'Localization'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    Visible = False
  end
  object lbDur1: TStaticText
    Left = 259
    Top = 113
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 21
    Visible = False
  end
end
