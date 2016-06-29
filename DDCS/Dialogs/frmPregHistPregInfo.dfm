object fPregInfo: TfPregInfo
  Left = 0
  Top = 0
  Width = 443
  Height = 293
  Align = alClient
  TabOrder = 0
  DesignSize = (
    443
    293)
  object lbOutcome: TLabel
    Left = 161
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
    Left = 209
    Top = 191
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
    Left = 346
    Top = 44
    Width = 91
    Height = 26
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Length of Labor in hours'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lbGestationalAge: TLabel
    Left = 7
    Top = 162
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
    Left = 156
    Top = 162
    Width = 32
    Height = 13
    Caption = 'Weeks'
  end
  object lbGADays: TLabel
    Left = 240
    Top = 162
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
    Top = 236
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
    Left = 7
    Top = 191
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
    Left = 294
    Top = 155
    Width = 100
    Height = 26
    Caption = 'Days in Hospital following Delivery'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object cbOutcome: TComboBox
    Left = 161
    Top = 75
    Width = 179
    Height = 21
    Align = alCustom
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object spnLaborLength: TSpinEdit
    Left = 346
    Top = 74
    Width = 91
    Height = 22
    Anchors = [akTop, akRight]
    AutoSelect = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
    OnChange = SpinCheck
  end
  object meDeliveryNotes: TCaptionMemo
    Left = 7
    Top = 254
    Width = 430
    Height = 32
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 12
    Caption = 'Delivery Notes'
  end
  object dtDelivery: TORDateBox
    Left = 7
    Top = 75
    Width = 148
    Height = 21
    TabOrder = 2
    DateOnly = True
    RequireTime = False
    Caption = 'Date of Delivery'
  end
  object cbAnesthesia: TComboBox
    Left = 7
    Top = 209
    Width = 196
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 10
  end
  object cbDeliveryPlace: TComboBox
    Left = 209
    Top = 209
    Width = 228
    Height = 21
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 11
  end
  object lbStatus: TStaticText
    Left = 213
    Top = 5
    Width = 191
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
    Width = 195
    Height = 40
    Align = alCustom
    BorderStyle = bsSingle
    TabOrder = 0
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
    Left = 208
    Top = 102
    Width = 132
    Height = 45
    Align = alCustom
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
    TabOrder = 6
    TabStop = True
    OnClick = rgPretermDeliveryClick
  end
  object rgTypeDelivery: TRadioGroup
    Left = 7
    Top = 102
    Width = 195
    Height = 45
    Align = alCustom
    Caption = 'Type of Delivery'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'Vaginal'
      'Cesarean')
    ParentFont = False
    TabOrder = 5
    TabStop = True
  end
  object Panel1: TPanel
    Left = 400
    Top = 157
    Width = 37
    Height = 23
    BevelOuter = bvNone
    TabOrder = 9
    object edtDeliveryAt: TSpinEdit
      Left = 1
      Top = 1
      Width = 36
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = SpinCheck
    end
  end
  object Panel2: TPanel
    Left = 100
    Top = 158
    Width = 51
    Height = 23
    BevelOuter = bvNone
    TabOrder = 7
    object spnGAWeeks: TSpinEdit
      Left = 1
      Top = 1
      Width = 50
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = SpinCheck
    end
  end
  object Panel3: TPanel
    Left = 193
    Top = 158
    Width = 41
    Height = 23
    BevelOuter = bvNone
    TabOrder = 8
    object spnGADays: TSpinEdit
      Left = 1
      Top = 1
      Width = 40
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = spnGADaysChange
    end
  end
end
