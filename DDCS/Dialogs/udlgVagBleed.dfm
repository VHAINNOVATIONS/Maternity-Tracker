object dlgVagBleed: TdlgVagBleed
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Vaginal Bleeding'
  ClientHeight = 138
  ClientWidth = 513
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
    Left = 241
    Top = 14
    Width = 262
    Height = 18
    Caption = 'Associated wth cramping and or contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    TabStop = True
  end
  object Label1: TStaticText
    Left = 241
    Top = 62
    Width = 99
    Height = 18
    Caption = 'Leakage of fluid?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 109
    Width = 513
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 12
    object bbtnOK: TBitBtn
      Left = 356
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
      Left = 437
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
    Left = 73
    Top = 14
    Width = 145
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leAmt: TCaptionEdit
    Left = 73
    Top = 76
    Width = 145
    Height = 22
    TabOrder = 5
    Caption = 'Amount'
  end
  object leDur: TCaptionEdit
    Left = 73
    Top = 45
    Width = 145
    Height = 22
    TabOrder = 3
    Caption = 'Duration'
  end
  object cbCrampY: TCheckBox
    Tag = 1
    Left = 241
    Top = 30
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 7
    OnClick = checkboxClick
  end
  object cbCrampN: TCheckBox
    Tag = 2
    Left = 290
    Top = 30
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 8
    OnClick = checkboxClick
  end
  object cbLeakY: TCheckBox
    Tag = 3
    Left = 241
    Top = 77
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 10
    OnClick = checkboxClick
  end
  object cbLeakN: TCheckBox
    Tag = 4
    Left = 290
    Top = 77
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 11
    OnClick = checkboxClick
  end
  object StaticText1: TStaticText
    Left = 17
    Top = 80
    Width = 48
    Height = 18
    Caption = 'Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object StaticText2: TStaticText
    Left = 17
    Top = 49
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
  object StaticText3: TStaticText
    Left = 17
    Top = 18
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
end
