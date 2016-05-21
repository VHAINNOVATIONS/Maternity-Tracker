object dlgHeadache: TdlgHeadache
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Headaches'
  ClientHeight = 177
  ClientWidth = 549
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
  object lbonset: TLabel
    Left = 17
    Top = 15
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
  object lbchar: TLabel
    Left = 17
    Top = 48
    Width = 54
    Height = 14
    Caption = 'Character'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbloc: TLabel
    Left = 17
    Top = 82
    Width = 47
    Height = 14
    Caption = 'Location'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbdur: TLabel
    Left = 17
    Top = 118
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 148
    Width = 549
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object bbtnOK: TBitBtn
      Left = 391
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
      Left = 472
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
    Left = 76
    Top = 12
    Width = 137
    Height = 22
    TabOrder = 0
  end
  object leChar: TEdit
    Left = 76
    Top = 45
    Width = 137
    Height = 22
    TabOrder = 1
  end
  object leLocat: TEdit
    Left = 76
    Top = 79
    Width = 137
    Height = 22
    TabOrder = 2
  end
  object leDur: TEdit
    Left = 76
    Top = 115
    Width = 137
    Height = 22
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 221
    Top = 8
    Width = 326
    Height = 137
    BevelOuter = bvNone
    TabOrder = 4
    object lbtreatments: TLabel
      Left = 17
      Top = 59
      Width = 71
      Height = 14
      Caption = 'Treatments?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbsymptoms: TLabel
      Left = 17
      Top = 7
      Width = 125
      Height = 14
      Caption = 'Associated Symptoms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbWhat: TLabel
      Left = 17
      Top = 86
      Width = 254
      Height = 14
      Caption = 'What was used? What was the effectiveness?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object leWhat: TEdit
      Left = 17
      Top = 107
      Width = 293
      Height = 22
      TabOrder = 3
      Visible = False
    end
    object cbTreatNo: TCheckBox
      Tag = 2
      Left = 150
      Top = 59
      Width = 36
      Height = 17
      Caption = 'No'
      TabOrder = 2
      OnClick = cbTreatYesClick
    end
    object cbTreatYes: TCheckBox
      Tag = 1
      Left = 100
      Top = 59
      Width = 43
      Height = 17
      Caption = 'Yes'
      TabOrder = 1
      OnClick = cbTreatYesClick
    end
    object leAssoc: TEdit
      Left = 17
      Top = 26
      Width = 293
      Height = 22
      TabOrder = 0
    end
  end
end
