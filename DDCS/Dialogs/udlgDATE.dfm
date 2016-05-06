object dlgDate: TdlgDate
  Left = 360
  Top = 111
  BorderStyle = bsDialog
  ClientHeight = 274
  ClientWidth = 476
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
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
      Width = 96
      Height = 20
      Caption = 'Select Date'
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
    Top = 245
    Width = 476
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bbtnOK: TBitBtn
      Left = 320
      Top = 1
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object bbtnCancel: TBitBtn
      Left = 399
      Top = 1
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object calMonth: TMonthCalendar
    Left = 0
    Top = 33
    Width = 476
    Height = 212
    Align = alClient
    Date = 0.516186701388505700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = True
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 448
    Top = 40
    Data = (
      (
        'Component = dlgDate'
        'Status = stsDefault'))
  end
end
