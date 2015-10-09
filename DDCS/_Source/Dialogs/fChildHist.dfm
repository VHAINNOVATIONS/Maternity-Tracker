object frmChildHist: TfrmChildHist
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmChildHist'
  ClientHeight = 102
  ClientWidth = 178
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel40: TPanel
    Left = 0
    Top = 0
    Width = 178
    Height = 102
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label305: TLabel
      Left = 6
      Top = 47
      Width = 63
      Height = 13
      Caption = 'Birth Weight:'
    end
    object edtBirthWeight: TEdit
      Tag = 1
      Left = 6
      Top = 61
      Width = 165
      Height = 21
      TabOrder = 1
    end
    object rgbxChildGender: TRadioGroup
      Left = 6
      Top = 1
      Width = 165
      Height = 45
      Caption = 'Sex - Gender'
      Columns = 2
      Items.Strings = (
        'Male'
        'Female')
      TabOrder = 0
      TabStop = True
    end
    object cntcbxStillBorn: TCheckBox
      Tag = 27
      Left = 6
      Top = 83
      Width = 65
      Height = 17
      Caption = 'Stillborn'
      TabOrder = 2
      OnClick = cntcbxStillBornClick
    end
  end
end
