object dlgFetalMov: TdlgFetalMov
  Left = 197
  Top = 176
  BorderStyle = bsDialog
  Caption = 'Change in Fetal Movement'
  ClientHeight = 384
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TStaticText
    Left = 16
    Top = 12
    Width = 147
    Height = 18
    Caption = 'Fetal movement present?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object lbContractions: TStaticText
    Left = 16
    Top = 235
    Width = 82
    Height = 18
    Caption = 'Contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    TabStop = True
  end
  object Label2: TStaticText
    Left = 16
    Top = 144
    Width = 102
    Height = 18
    Caption = 'Vaginal bleeding?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = True
  end
  object Label4: TStaticText
    Left = 16
    Top = 171
    Width = 99
    Height = 18
    Caption = 'Leakage of fluid?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 355
    Width = 285
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 23
    object bbtnOK: TBitBtn
      Left = 128
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
      Left = 209
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
    Left = 58
    Top = 198
    Width = 211
    Height = 22
    TabOrder = 13
    Caption = 'Onset'
  end
  object cbFetMovY: TCheckBox
    Tag = 1
    Left = 184
    Top = 12
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = checkboxClick
  end
  object cbFetMovN: TCheckBox
    Tag = 2
    Left = 233
    Top = 12
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = checkboxClick
  end
  object cbContY: TCheckBox
    Tag = 7
    Left = 184
    Top = 236
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 15
    OnClick = checkboxClick
  end
  object cbContN: TCheckBox
    Tag = 8
    Left = 233
    Top = 236
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 16
    OnClick = checkboxClick
  end
  object cbVagBleY: TCheckBox
    Tag = 3
    Left = 184
    Top = 144
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = checkboxClick
  end
  object cbVagBleN: TCheckBox
    Tag = 4
    Left = 233
    Top = 144
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = checkboxClick
  end
  object cbLeakY: TCheckBox
    Tag = 5
    Left = 184
    Top = 171
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = checkboxClick
  end
  object cbLeakN: TCheckBox
    Tag = 6
    Left = 233
    Top = 171
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = checkboxClick
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 39
    Width = 244
    Height = 18
    Caption = 'Date and time of last perceived movement?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object leLastMov: TORDateBox
    Left = 16
    Top = 58
    Width = 211
    Height = 22
    TabOrder = 4
    DateOnly = False
    RequireTime = False
    Caption = 'Date/time of last perceived movement'
  end
  object leCharFetal: TCaptionEdit
    Left = 16
    Top = 109
    Width = 211
    Height = 22
    TabOrder = 6
    Caption = 'Character of fetal movements'
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 89
    Width = 176
    Height = 18
    Caption = 'Character of fetal movements?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object StaticText3: TStaticText
    Left = 16
    Top = 202
    Width = 37
    Height = 18
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 27
  end
  object leFreq: TCaptionEdit
    Left = 109
    Top = 268
    Width = 121
    Height = 22
    TabOrder = 18
    Visible = False
    Caption = 'Frequency'
  end
  object leDur: TCaptionEdit
    Left = 109
    Top = 296
    Width = 121
    Height = 22
    TabOrder = 20
    Visible = False
    Caption = 'Duration'
  end
  object leOnset1: TCaptionEdit
    Left = 109
    Top = 324
    Width = 121
    Height = 22
    TabOrder = 22
    Visible = False
    Caption = 'Onset'
  end
  object lbFreq: TStaticText
    Left = 41
    Top = 272
    Width = 62
    Height = 18
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    Visible = False
  end
  object lbDur: TStaticText
    Left = 53
    Top = 300
    Width = 50
    Height = 18
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    Visible = False
  end
  object lbOnset1: TStaticText
    Left = 66
    Top = 328
    Width = 37
    Height = 18
    Caption = 'Onset'
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
