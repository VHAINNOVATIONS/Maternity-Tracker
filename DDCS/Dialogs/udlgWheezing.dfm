object dlgWheezing: TdlgWheezing
  Left = 217
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Wheezing'
  ClientHeight = 179
  ClientWidth = 265
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
  object lbbreath: TLabel
    Left = 13
    Top = 41
    Width = 118
    Height = 14
    Caption = 'Shortness of breath?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbDur: TLabel
    Left = 13
    Top = 70
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
  object lbAssociatedSymp: TLabel
    Left = 13
    Top = 102
    Width = 125
    Height = 14
    Align = alCustom
    Anchors = [akLeft, akBottom]
    Caption = 'Associated Symptoms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitTop = 99
  end
  object lbonset: TLabel
    Left = 13
    Top = 11
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
    Top = 150
    Width = 265
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 147
    object bbtnOK: TBitBtn
      Left = 108
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
      Left = 189
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
    Left = 66
    Top = 8
    Width = 187
    Height = 22
    TabOrder = 0
  end
  object leAssocSym: TEdit
    Left = 13
    Top = 121
    Width = 240
    Height = 22
    Align = alCustom
    Anchors = [akLeft, akBottom]
    TabOrder = 4
    ExplicitTop = 118
  end
  object leDur: TEdit
    Left = 66
    Top = 67
    Width = 187
    Height = 22
    TabOrder = 3
    Visible = False
  end
  object cbSOBY: TCheckBox
    Tag = 1
    Left = 158
    Top = 41
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 1
    OnClick = checkboxClick
  end
  object cbSOBN: TCheckBox
    Tag = 2
    Left = 207
    Top = 41
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 2
    OnClick = checkboxClick
  end
end
