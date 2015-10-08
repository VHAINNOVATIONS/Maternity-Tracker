object dlgRTClinic: TdlgRTClinic
  Left = 368
  Top = 174
  BorderStyle = bsDialog
  ClientHeight = 144
  ClientWidth = 307
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
  object Label3: TLabel
    Left = 40
    Top = 72
    Width = 76
    Height = 13
    Caption = 'Return To Clinic'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 307
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 215
      Height = 20
      Caption = 'Return to Clinic Time Span'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 115
    Width = 307
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object bbtnOK: TBitBtn
      Left = 149
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 230
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object edtRTCWeeks: TSpinEdit
    Left = 125
    Top = 69
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = edtRTCWeeksChange
  end
  object cbTimeUnit: TComboBox
    Left = 180
    Top = 69
    Width = 82
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 2
    Text = 'Week(s)'
    Items.Strings = (
      'Day(s)'
      'Week(s)'
      'Month(s)'
      'Year(s)')
  end
end
