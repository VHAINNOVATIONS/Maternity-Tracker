object frmInner: TfrmInner
  Left = 0
  Top = 0
  Width = 614
  Height = 327
  TabOrder = 0
  object lbOz: TLabel
    Left = 438
    Top = 136
    Width = 20
    Height = 13
    Caption = 'ozs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbAPGAR: TLabel
    Left = 17
    Top = 80
    Width = 43
    Height = 13
    Caption = 'APGAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbLbs: TLabel
    Left = 438
    Top = 108
    Width = 17
    Height = 13
    Caption = 'lbs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComplications: TLabel
    Left = 17
    Top = 157
    Width = 142
    Height = 13
    Caption = 'Complications/Anomalies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTotalWeight: TLabel
    Left = 272
    Top = 80
    Width = 74
    Height = 13
    Caption = 'Total Weight'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbG: TLabel
    Left = 438
    Top = 80
    Width = 8
    Height = 13
    Caption = 'g'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edAPGARone: TEdit
    Left = 66
    Top = 77
    Width = 54
    Height = 21
    NumbersOnly = True
    TabOrder = 2
  end
  object meComplications: TCaptionMemo
    Left = 17
    Top = 176
    Width = 580
    Height = 134
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 8
    Caption = 'Complications and or Anomalies'
  end
  object spnOz: TSpinEdit
    Left = 352
    Top = 133
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
    OnChange = spnOzChange
  end
  object ckNICU: TCheckBox
    Left = 17
    Top = 110
    Width = 244
    Height = 17
    Caption = 'Neonatal Intensive Care Unit Admission'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object rgLife: TRadioGroup
    Left = 272
    Top = 12
    Width = 173
    Height = 54
    Caption = 'Status'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Living'
      'Demise')
    ParentFont = False
    TabOrder = 1
    TabStop = True
  end
  object spnG: TSpinEdit
    Left = 352
    Top = 77
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
    OnChange = UpdateLbOz
  end
  object edAPGARfive: TEdit
    Left = 126
    Top = 77
    Width = 54
    Height = 21
    NumbersOnly = True
    TabOrder = 3
  end
  object spnLb: TSpinEdit
    Left = 352
    Top = 105
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
    OnChange = spnLbChange
  end
  object rgSex: TRadioGroup
    Left = 17
    Top = 12
    Width = 244
    Height = 54
    Caption = 'Gender'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Male'
      'Female'
      'Unknown')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
end
