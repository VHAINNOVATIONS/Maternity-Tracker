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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object lbassociated: TLabel
    Left = 241
    Top = 14
    Width = 258
    Height = 14
    Caption = 'Associated wth cramping and or contractions?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbleakage: TLabel
    Left = 241
    Top = 60
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
  object lbamount: TLabel
    Left = 17
    Top = 79
    Width = 44
    Height = 14
    Caption = 'Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbdur: TLabel
    Left = 17
    Top = 48
    Width = 46
    Height = 14
    Caption = 'Duration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbonset: TLabel
    Left = 17
    Top = 17
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 109
    Width = 513
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
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
  object leOnset: TEdit
    Left = 73
    Top = 14
    Width = 145
    Height = 22
    TabOrder = 0
  end
  object leAmt: TEdit
    Left = 73
    Top = 76
    Width = 145
    Height = 22
    TabOrder = 2
  end
  object leDur: TEdit
    Left = 73
    Top = 45
    Width = 145
    Height = 22
    TabOrder = 1
  end
  object cbCrampY: TCheckBox
    Tag = 1
    Left = 241
    Top = 33
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = checkboxClick
  end
  object cbCrampN: TCheckBox
    Tag = 2
    Left = 290
    Top = 33
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = checkboxClick
  end
  object cbLeakY: TCheckBox
    Tag = 3
    Left = 241
    Top = 79
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = checkboxClick
  end
  object cbLeakN: TCheckBox
    Tag = 4
    Left = 290
    Top = 79
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = checkboxClick
  end
end
