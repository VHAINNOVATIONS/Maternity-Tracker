object frmPregHist: TfrmPregHist
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmPregHist'
  ClientHeight = 266
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Pregnancy: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 266
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object L_DateMonthYearOfDelivery: TLabel
      Left = 7
      Top = 11
      Width = 142
      Height = 13
      Caption = 'Date/Month/Year of Delivery:'
    end
    object L_GestationalAgeAtDelivery: TLabel
      Left = 7
      Top = 50
      Width = 80
      Height = 13
      Caption = 'Gestational Age:'
    end
    object L_LengthofLabor: TLabel
      Left = 7
      Top = 90
      Width = 80
      Height = 13
      Caption = 'Length of Labor:'
    end
    object L_TypeofDelivery: TLabel
      Left = 7
      Top = 128
      Width = 83
      Height = 13
      Caption = 'Type of Delivery:'
    end
    object SpeedButton11: TSpeedButton
      Tag = 3
      Left = 140
      Top = 25
      Width = 25
      Height = 25
      Hint = 'Pick Date From Calendar'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton11Click
    end
    object Label287: TLabel
      Left = 89
      Top = 107
      Width = 15
      Height = 13
      Caption = 'hrs'
    end
    object Comments: TLabel
      Left = 7
      Top = 169
      Width = 50
      Height = 13
      Caption = 'Comments'
    end
    object Label1: TLabel
      Left = 58
      Top = 69
      Width = 20
      Height = 13
      Caption = 'Wks'
    end
    object Label2: TLabel
      Left = 134
      Top = 69
      Width = 24
      Height = 13
      Caption = 'Days'
    end
    object lblStatus: TLabel
      Left = 399
      Top = 11
      Width = 206
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 187
      Top = 11
      Width = 53
      Height = 13
      Caption = 'Anesthesia'
    end
    object Label7: TLabel
      Left = 187
      Top = 128
      Width = 80
      Height = 13
      Caption = 'Place of Delivery'
    end
    object edtDateOfDelivery: TEdit
      Left = 7
      Top = 26
      Width = 134
      Height = 21
      TabOrder = 0
    end
    object E_TypeofDelivery: TComboBox
      Left = 7
      Top = 143
      Width = 160
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
    object Panel43: TPanel
      Left = 399
      Top = 33
      Width = 206
      Height = 224
      BevelInner = bvLowered
      TabOrder = 9
      object Label290: TLabel
        Left = 10
        Top = 48
        Width = 34
        Height = 13
        Caption = 'Child #'
      end
      object Bevel12: TBevel
        Left = 7
        Top = 63
        Width = 186
        Height = 4
      end
      object Label289: TLabel
        Left = 158
        Top = 7
        Width = 37
        Height = 13
        Caption = 'Number'
      end
      object pgcChildNumber: TPageControl
        Left = 7
        Top = 73
        Width = 186
        Height = 143
        Style = tsButtons
        TabHeight = 18
        TabOrder = 2
        TabWidth = 20
        OnChange = pgcChildNumberChange
      end
      object cxRadioGroupBirthType: TRadioGroup
        Left = 7
        Top = 7
        Width = 142
        Height = 36
        Caption = 'Birth Type'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Singleton'
          'Multiple')
        TabOrder = 0
        TabStop = True
        OnClick = cxRadioGroupBirthTypeClick
      end
      object JvSpinEdit1: TJvSpinEdit
        Left = 158
        Top = 22
        Width = 35
        Height = 21
        MaxValue = 99.000000000000000000
        MinValue = 2.000000000000000000
        Value = 2.000000000000000000
        TabOrder = 1
        OnChange = JvSpinEdit1Change
      end
    end
    object cxRadioGroup_PretermLabor: TRadioGroup
      Left = 187
      Top = 65
      Width = 193
      Height = 45
      Caption = 'Preterm Delivery'
      Columns = 2
      Items.Strings = (
        'No'
        'Yes')
      TabOrder = 6
      TabStop = True
      OnClick = cxRadioGroup_PretermLaborClick
    end
    object MO_CommentComplication: TMemo
      Left = 7
      Top = 184
      Width = 373
      Height = 73
      ScrollBars = ssVertical
      TabOrder = 8
    end
    object SPN_GAWeeks: TSpinEdit
      Left = 7
      Top = 65
      Width = 50
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = gaWeekChange
    end
    object SPN_GADays: TSpinEdit
      Left = 83
      Top = 65
      Width = 50
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = gaDaysChange
    end
    object E_LengthofLabor: TJvSpinEdit
      Left = 7
      Top = 104
      Width = 80
      Height = 21
      ValueType = vtFloat
      TabOrder = 3
      OnChange = SpinMin
    end
    object cbAnesthesia: TComboBox
      Left = 187
      Top = 26
      Width = 193
      Height = 21
      Style = csDropDownList
      TabOrder = 5
    end
    object CB_PlaceofDelivery: TComboBox
      Left = 187
      Top = 143
      Width = 193
      Height = 21
      TabOrder = 7
    end
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = frmPregHist'
        'Status = stsDefault'))
  end
end
