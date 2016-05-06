object dlgModTotPregs: TdlgModTotPregs
  Left = 227
  Top = 108
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Potential Pregnancy Data Deletion'
  ClientHeight = 213
  ClientWidth = 281
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 265
    Height = 113
    Shape = bsFrame
  end
  object OKBtn: TBitBtn
    Left = 8
    Top = 127
    Width = 97
    Height = 34
    Caption = 'Delete Data'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TBitBtn
    Left = 176
    Top = 127
    Width = 97
    Height = 34
    Cancel = True
    Caption = 'Cancel Action'
    ModalResult = 2
    TabOrder = 1
    WordWrap = True
  end
  object StaticText1: TStaticText
    Left = 19
    Top = 16
    Width = 241
    Height = 97
    AutoSize = False
    Caption = 
      'The current selections for Total Pregnancies, Ab. Induced, Ab. S' +
      'pontaneous, and Ectopic Pregnancies may result in the deletion o' +
      'f past pregnancy data. Do you wish to continue and lose this dat' +
      'a or would you prefer to increase the Total Number of Pregnancie' +
      's such that no data would be lost?'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 167
    Width = 281
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 281
      Height = 46
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 2
      ExplicitWidth = 260
      ExplicitHeight = 44
    end
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 187
      Height = 13
      Caption = 'Select the Page # you wish to DELETE:'
    end
    object SpinEdit1: TSpinEdit
      Left = 198
      Top = 13
      Width = 75
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = SpinEdit1Change
    end
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgModTotPregs'
        'Status = stsDefault'))
  end
end
