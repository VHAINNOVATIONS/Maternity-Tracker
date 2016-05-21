object dlgRash: TdlgRash
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Rash and Itching'
  ClientHeight = 130
  ClientWidth = 292
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
  object lbitching: TLabel
    Left = 15
    Top = 72
    Width = 44
    Height = 14
    Caption = 'Itching?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbonset: TLabel
    Left = 15
    Top = 12
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
  object lbloc: TLabel
    Left = 15
    Top = 43
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 101
    Width = 292
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object bbtnOK: TBitBtn
      Left = 134
      Top = 2
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
      Left = 215
      Top = 2
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
    Left = 70
    Top = 9
    Width = 206
    Height = 22
    TabOrder = 0
  end
  object leLocat: TEdit
    Left = 70
    Top = 40
    Width = 206
    Height = 22
    TabOrder = 1
  end
  object cbItchY: TCheckBox
    Tag = 1
    Left = 70
    Top = 72
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 2
    OnClick = checkboxClick
  end
  object cbItchN: TCheckBox
    Tag = 2
    Left = 119
    Top = 72
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 3
    OnClick = checkboxClick
  end
end
