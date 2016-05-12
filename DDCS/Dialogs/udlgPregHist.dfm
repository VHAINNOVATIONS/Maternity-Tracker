object dlgPregHist: TdlgPregHist
  Left = 197
  Top = 155
  BorderStyle = bsDialog
  ClientHeight = 516
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 24
    Top = 55
    Width = 85
    Height = 14
    Caption = 'Total Pregnancies'
  end
  object Label2: TLabel
    Left = 24
    Top = 84
    Width = 42
    Height = 14
    Caption = 'Full Term'
  end
  object Label3: TLabel
    Left = 24
    Top = 112
    Width = 49
    Height = 14
    Caption = 'Premature'
  end
  object Label4: TLabel
    Left = 24
    Top = 140
    Width = 58
    Height = 14
    Caption = 'Ab. Induced'
  end
  object Label5: TLabel
    Left = 288
    Top = 55
    Width = 84
    Height = 14
    Caption = 'Ab. Spontaneous'
  end
  object Label6: TLabel
    Left = 288
    Top = 84
    Width = 41
    Height = 14
    Caption = 'Ectopics'
  end
  object Label7: TLabel
    Left = 288
    Top = 112
    Width = 66
    Height = 14
    Caption = 'Multiple Births'
  end
  object Label8: TLabel
    Left = 288
    Top = 140
    Width = 28
    Height = 14
    Caption = 'Living'
  end
  object PregListView: TListView
    Left = 80
    Top = 223
    Width = 452
    Height = 207
    Columns = <>
    TabOrder = 11
    ViewStyle = vsReport
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
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
      Width = 146
      Height = 20
      Caption = 'Pregnancy History'
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
    Top = 487
    Width = 633
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 10
    object bbtnOK: TBitBtn
      Left = 474
      Top = 2
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 555
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pgcPregnancy: TPageControl
    Left = 8
    Top = 184
    Width = 620
    Height = 297
    TabOrder = 9
    OnChange = pgcPregnancyChange
    OnChanging = pgcPregnancyChanging
  end
  object edtAbInduced: TSpinEdit
    Left = 122
    Top = 137
    Width = 85
    Height = 23
    Hint = 'AI'
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object edtAbSpont: TSpinEdit
    Left = 386
    Top = 52
    Width = 85
    Height = 23
    Hint = 'AS'
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object edtTotPreg: TSpinEdit
    Left = 122
    Top = 52
    Width = 85
    Height = 23
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object edtEctopic: TSpinEdit
    Left = 386
    Top = 81
    Width = 85
    Height = 23
    Hint = 'E'
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object edLiveBirths: TEdit
    Left = 386
    Top = 141
    Width = 85
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 8
  end
  object edMultipleBirths: TEdit
    Left = 386
    Top = 112
    Width = 85
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 7
  end
  object edPremature: TEdit
    Left = 122
    Top = 111
    Width = 85
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
  end
  object edFullTerm: TEdit
    Left = 122
    Top = 83
    Width = 85
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
end
