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
  object Label3: TLabel
    Left = 16
    Top = 12
    Width = 143
    Height = 14
    Caption = 'Fetal movement present?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbContractions: TLabel
    Left = 16
    Top = 236
    Width = 78
    Height = 14
    Caption = 'Contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 144
    Width = 97
    Height = 14
    Caption = 'Vaginal bleeding?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 171
    Width = 95
    Height = 14
    Caption = 'Leakage of fluid?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText1: TLabel
    Left = 16
    Top = 39
    Width = 240
    Height = 14
    Caption = 'Date and time of last perceived movement?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText2: TLabel
    Left = 16
    Top = 89
    Width = 172
    Height = 14
    Caption = 'Character of fetal movements?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText3: TLabel
    Left = 16
    Top = 201
    Width = 33
    Height = 14
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbFreq: TLabel
    Left = 16
    Top = 271
    Width = 58
    Height = 14
    Caption = 'Frequency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbDur: TLabel
    Left = 16
    Top = 299
    Width = 46
    Height = 14
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbOnset1: TLabel
    Left = 16
    Top = 327
    Width = 33
    Height = 14
    Caption = 'Onset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 355
    Width = 285
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 14
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
  object leOnset: TEdit
    Left = 58
    Top = 198
    Width = 211
    Height = 22
    TabOrder = 8
  end
  object cbFetMovY: TCheckBox
    Tag = 1
    Left = 184
    Top = 12
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 0
    OnClick = checkboxClick
  end
  object cbFetMovN: TCheckBox
    Tag = 2
    Left = 233
    Top = 12
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 1
    OnClick = checkboxClick
  end
  object cbContY: TCheckBox
    Tag = 7
    Left = 184
    Top = 236
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 9
    OnClick = checkboxClick
  end
  object cbContN: TCheckBox
    Tag = 8
    Left = 233
    Top = 236
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 10
    OnClick = checkboxClick
  end
  object cbVagBleY: TCheckBox
    Tag = 3
    Left = 184
    Top = 144
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object cbVagBleN: TCheckBox
    Tag = 4
    Left = 233
    Top = 144
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = checkboxClick
  end
  object cbLeakY: TCheckBox
    Tag = 5
    Left = 184
    Top = 171
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = checkboxClick
  end
  object cbLeakN: TCheckBox
    Tag = 6
    Left = 233
    Top = 171
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = checkboxClick
  end
  object leLastMov: TORDateBox
    Left = 16
    Top = 58
    Width = 253
    Height = 22
    TabOrder = 2
    DateOnly = False
    RequireTime = False
    Caption = 'Date and time of last perceived movement'
  end
  object leCharFetal: TEdit
    Left = 16
    Top = 108
    Width = 253
    Height = 22
    TabOrder = 3
  end
  object leFreq: TEdit
    Left = 84
    Top = 268
    Width = 185
    Height = 22
    TabOrder = 11
    Visible = False
  end
  object leDur: TEdit
    Left = 84
    Top = 296
    Width = 185
    Height = 22
    TabOrder = 12
    Visible = False
  end
  object leOnset1: TEdit
    Left = 84
    Top = 324
    Width = 185
    Height = 22
    TabOrder = 13
    Visible = False
  end
end
