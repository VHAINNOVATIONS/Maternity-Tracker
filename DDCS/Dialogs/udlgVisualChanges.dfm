object dlgVisualChanges: TdlgVisualChanges
  Left = 217
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Visual Changes'
  ClientHeight = 147
  ClientWidth = 528
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
  object lbchar: TLabel
    Left = 16
    Top = 55
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
    Left = 16
    Top = 90
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
  object lbonset: TLabel
    Left = 16
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
  object lbdur: TLabel
    Left = 260
    Top = 17
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
    Top = 118
    Width = 528
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 115
    object bbtnOK: TBitBtn
      Left = 371
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
      Left = 452
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
    Left = 77
    Top = 14
    Width = 164
    Height = 22
    TabOrder = 0
  end
  object cmbChar: TComboBox
    Left = 77
    Top = 52
    Width = 164
    Height = 22
    Style = csDropDownList
    TabOrder = 1
  end
  object cmbLoc: TComboBox
    Left = 77
    Top = 87
    Width = 164
    Height = 22
    Style = csDropDownList
    TabOrder = 2
  end
  object leDur: TEdit
    Left = 313
    Top = 14
    Width = 198
    Height = 22
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 252
    Top = 48
    Width = 269
    Height = 61
    BevelOuter = bvNone
    TabOrder = 4
    object lbsymptoms: TLabel
      Left = 8
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
    object leAssociatedSymp: TEdit
      Left = 8
      Top = 28
      Width = 251
      Height = 22
      TabOrder = 0
    end
  end
end
