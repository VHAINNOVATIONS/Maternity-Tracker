object fPregInfo: TfPregInfo
  Left = 0
  Top = 0
  Width = 507
  Height = 293
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 443
  DesignSize = (
    507
    293)
  object lbOutcome: TLabel
    Left = 172
    Top = 56
    Width = 51
    Height = 13
    Caption = 'Outcome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbPlaceDelivery: TLabel
    Left = 7
    Top = 176
    Width = 94
    Height = 13
    Caption = 'Place of Delivery'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLengthLabor: TLabel
    Left = 283
    Top = 107
    Width = 136
    Height = 13
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Length of Labor in hours'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 293
  end
  object lbGestationalAge: TLabel
    Left = 7
    Top = 130
    Width = 90
    Height = 13
    Caption = 'Gestational Age'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbGAWeeks: TLabel
    Left = 52
    Top = 151
    Width = 32
    Height = 13
    Caption = 'Weeks'
  end
  object lbGADays: TLabel
    Left = 136
    Top = 151
    Width = 24
    Height = 13
    Caption = 'Days'
  end
  object lbDateDelivery: TLabel
    Left = 7
    Top = 56
    Width = 91
    Height = 13
    Caption = 'Date of Delivery'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComments: TLabel
    Left = 7
    Top = 221
    Width = 82
    Height = 13
    Caption = 'Delivery Notes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbAnesthesia: TLabel
    Left = 172
    Top = 151
    Width = 63
    Height = 13
    Caption = 'Anesthesia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbDaysHospital: TLabel
    Left = 7
    Top = 107
    Width = 193
    Height = 13
    Caption = 'Days in Hospital following Delivery'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbOutcome: TComboBox
    Left = 173
    Top = 75
    Width = 184
    Height = 21
    Align = alCustom
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ExplicitWidth = 120
  end
  object spnGAWeeks: TSpinEdit
    Left = 7
    Top = 148
    Width = 40
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
    OnChange = SpinCheck
  end
  object spnGADays: TSpinEdit
    Left = 90
    Top = 148
    Width = 40
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
    OnChange = spnGADaysChange
  end
  object spnLaborLength: TSpinEdit
    Left = 425
    Top = 104
    Width = 77
    Height = 22
    Anchors = [akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
    OnChange = SpinCheck
    ExplicitLeft = 361
  end
  object meDeliveryNotes: TCaptionMemo
    Left = 7
    Top = 239
    Width = 495
    Height = 45
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 11
    Caption = 'Comments'
    ExplicitWidth = 431
  end
  object dtDelivery: TORDateBox
    Left = 7
    Top = 75
    Width = 160
    Height = 21
    TabOrder = 2
    DateOnly = True
    RequireTime = False
    Caption = 'Date of Delivery'
  end
  object cbAnesthesia: TComboBox
    Left = 241
    Top = 148
    Width = 261
    Height = 21
    Align = alCustom
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 9
    ExplicitWidth = 197
  end
  object cbDeliveryPlace: TComboBox
    Left = 7
    Top = 194
    Width = 495
    Height = 21
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 10
    ExplicitWidth = 431
  end
  object lbStatus: TStaticText
    Left = 213
    Top = 5
    Width = 248
    Height = 23
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = sbsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    TabStop = True
  end
  object pnlBirthCount: TPanel
    Left = 7
    Top = 5
    Width = 196
    Height = 40
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
    ExplicitWidth = 132
    object lbBirthCount: TLabel
      Left = 9
      Top = 10
      Width = 126
      Height = 13
      Caption = 'Total Number of Births'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spnBirthCount: TSpinEdit
      Left = 141
      Top = 7
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = spnBabyCountChange
    end
  end
  object rgPretermDelivery: TRadioGroup
    Left = 363
    Top = 51
    Width = 139
    Height = 45
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Preterm Delivery'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'No'
      'Yes')
    ParentFont = False
    TabOrder = 4
    TabStop = True
    OnClick = rgPretermDeliveryClick
    ExplicitLeft = 299
  end
  object edtDeliveryAt: TSpinEdit
    Left = 206
    Top = 104
    Width = 50
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
    OnChange = SpinCheck
  end
end
