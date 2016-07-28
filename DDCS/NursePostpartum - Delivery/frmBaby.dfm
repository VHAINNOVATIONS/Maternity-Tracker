object frmInner: TfrmInner
  Left = 0
  Top = 0
  Width = 614
  Height = 327
  TabOrder = 0
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
  object lbComplications: TLabel
    Left = 17
    Top = 135
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
  object edAPGARone: TEdit
    Left = 66
    Top = 77
    Width = 53
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object meComplications: TCaptionMemo
    Left = 17
    Top = 152
    Width = 580
    Height = 160
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 5
    Caption = 'Complications and or Anomalies'
  end
  object ckNICU: TCheckBox
    Left = 17
    Top = 109
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
  object edAPGARfive: TEdit
    Left = 125
    Top = 77
    Width = 53
    Height = 21
    NumbersOnly = True
    TabOrder = 2
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
    ItemIndex = 2
    Items.Strings = (
      'Male'
      'Female'
      'Unknown')
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object Panel1: TPanel
    Left = 206
    Top = 75
    Width = 197
    Height = 23
    BevelOuter = bvNone
    TabOrder = 3
    object lbOz: TLabel
      Left = 172
      Top = 60
      Width = 20
      Height = 13
      Caption = 'ozs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbLbs: TLabel
      Left = 172
      Top = 32
      Width = 17
      Height = 13
      Caption = 'lbs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbTotalWeight: TLabel
      Left = 3
      Top = 4
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
      Left = 170
      Top = 4
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
    object spnLb: TSpinEdit
      Left = 85
      Top = 29
      Width = 81
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      Visible = False
      OnChange = spnLbChange
    end
    object spnOz: TSpinEdit
      Left = 85
      Top = 57
      Width = 81
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      Visible = False
      OnChange = spnOzChange
    end
    object spnG: TSpinEdit
      Left = 83
      Top = 1
      Width = 81
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = UpdateLbOz
    end
  end
end
