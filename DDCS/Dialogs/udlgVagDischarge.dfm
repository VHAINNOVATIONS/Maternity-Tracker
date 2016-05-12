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
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TStaticText
    Left = 225
    Top = 15
    Width = 38
    Height = 18
    Caption = 'Odor?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    TabStop = True
  end
  object Label1: TStaticText
    Left = 225
    Top = 46
    Width = 48
    Height = 18
    Caption = 'Itching?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = True
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 78
    Width = 369
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
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
  object leOnset: TCaptionEdit
    Left = 53
    Top = 11
    Width = 155
    Height = 22
    TabOrder = 1
    Caption = 'Onset'
  end
  object leColor: TCaptionEdit
    Left = 53
    Top = 42
    Width = 155
    Height = 22
    TabOrder = 3
    Caption = 'Color'
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 275
    Top = 15
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
  object CheckBox2: TCheckBox
    Tag = 2
    Left = 324
    Top = 15
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = CheckBoxClick
  end
  object CheckBox3: TCheckBox
    Tag = 3
    Left = 275
    Top = 46
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = CheckBoxClick
  end
  object CheckBox4: TCheckBox
    Tag = 4
    Left = 324
    Top = 46
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = CheckBoxClick
  end
  object StaticText1: TStaticText
    Left = 14
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
  object StaticText2: TStaticText
    Left = 14
    Top = 46
    Width = 34
    Height = 18
    Caption = 'Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
end
