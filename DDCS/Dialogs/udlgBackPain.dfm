object dlgBackPain: TdlgBackPain
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Back Pain'
  ClientHeight = 172
  ClientWidth = 500
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
    Left = 286
    Top = 64
    Width = 52
    Height = 18
    Caption = 'Dysuria?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
  end
  object Label1: TStaticText
    Left = 286
    Top = 89
    Width = 112
    Height = 18
    Caption = 'Fever and or chills?'
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
    Top = 143
    Width = 500
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 16
    object bbtnOK: TBitBtn
      Left = 343
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 424
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
    Left = 76
    Top = 11
    Width = 190
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leChar: TCaptionEdit
    Left = 76
    Top = 110
    Width = 190
    Height = 22
    TabOrder = 7
    Caption = 'Character'
  end
  object leLocat: TCaptionEdit
    Left = 76
    Top = 77
    Width = 190
    Height = 22
    TabOrder = 5
    Caption = 'Location'
  end
  object leDur: TCaptionEdit
    Left = 76
    Top = 44
    Width = 190
    Height = 22
    TabOrder = 3
    Caption = 'Duration'
  end
  object leUrin: TCaptionEdit
    Left = 286
    Top = 30
    Width = 200
    Height = 22
    TabOrder = 9
    Caption = 'Urinary Frequency and or Urgency'
  end
  object cbDysY: TCheckBox
    Tag = 1
    Left = 401
    Top = 64
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = checkboxClick
  end
  object cbDysN: TCheckBox
    Tag = 2
    Left = 450
    Top = 64
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = checkboxClick
  end
  object cbFeverY: TCheckBox
    Tag = 3
    Left = 401
    Top = 89
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 14
    OnClick = checkboxClick
  end
  object cbFeverN: TCheckBox
    Tag = 4
    Left = 450
    Top = 89
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 15
    OnClick = checkboxClick
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 114
    Width = 58
    Height = 18
    Caption = 'Character'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 81
    Width = 51
    Height = 18
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object StaticText3: TStaticText
    Left = 16
    Top = 48
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object StaticText4: TStaticText
    Left = 16
    Top = 15
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
  object StaticText5: TStaticText
    Left = 286
    Top = 11
    Width = 190
    Height = 18
    Caption = 'Urinary Frequency and or Urgency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
end
