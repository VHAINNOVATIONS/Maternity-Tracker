object dlgVagDischarge: TdlgVagDischarge
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Vaginal Discharge'
  ClientHeight = 107
  ClientWidth = 369
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
  object lbodor: TLabel
    Left = 225
    Top = 14
    Width = 34
    Height = 14
    Caption = 'Odor?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbitching: TLabel
    Left = 225
    Top = 45
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
    Left = 14
    Top = 14
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
  object lbcolor: TLabel
    Left = 14
    Top = 45
    Width = 30
    Height = 14
    Caption = 'Color'
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
    Top = 78
    Width = 369
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object bbtnOK: TBitBtn
      Left = 212
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
      Left = 293
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
    Left = 53
    Top = 11
    Width = 155
    Height = 22
    TabOrder = 0
  end
  object leColor: TEdit
    Left = 53
    Top = 42
    Width = 155
    Height = 22
    TabOrder = 1
  end
  object ckOdorY: TCheckBox
    Tag = 1
    Left = 276
    Top = 14
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 2
    OnClick = CheckBoxClick
  end
  object ckOdorN: TCheckBox
    Tag = 2
    Left = 324
    Top = 14
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 3
    OnClick = CheckBoxClick
  end
  object ckItchingY: TCheckBox
    Tag = 3
    Left = 276
    Top = 45
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object ckItchingN: TCheckBox
    Tag = 4
    Left = 323
    Top = 45
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
end
