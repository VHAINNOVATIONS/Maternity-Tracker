object dlgRTClinic: TdlgRTClinic
  Left = 368
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Return to Clinic Time Span'
  ClientHeight = 78
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbrtc: TLabel
    Left = 16
    Top = 14
    Width = 89
    Height = 13
    Caption = 'Return to Clinic'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 49
    Width = 268
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bbtnOK: TBitBtn
      Left = 111
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
      Left = 192
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
  object edtRTCWeeks: TSpinEdit
    Left = 118
    Top = 11
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = edtRTCWeeksChange
  end
  object cbTimeUnit: TComboBox
    Left = 173
    Top = 11
    Width = 82
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 1
    Text = 'Week(s)'
    Items.Strings = (
      'Day(s)'
      'Week(s)'
      'Month(s)'
      'Year(s)')
  end
end
