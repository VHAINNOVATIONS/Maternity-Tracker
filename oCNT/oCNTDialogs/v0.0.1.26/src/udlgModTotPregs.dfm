object dlgModTotPregs: TdlgModTotPregs
  Left = 227
  Top = 108
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Potential Pregnancy Data Deletion'
  ClientHeight = 180
  ClientWidth = 281
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 265
    Height = 113
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 8
    Top = 135
    Width = 97
    Height = 34
    Caption = 'Delete Data'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 176
    Top = 135
    Width = 97
    Height = 34
    Cancel = True
    Caption = 'Increase Total Pregnancies'
    ModalResult = 2
    TabOrder = 1
    WordWrap = True
  end
  object StaticText1: TStaticText
    Left = 24
    Top = 16
    Width = 241
    Height = 97
    AutoSize = False
    Caption = 
      'The current selections for Total Pegnancies, Ab. '#13#10'Induced, Ab  ' +
      'Spontaneous, and Ectoptic '#13#10'Pregnancies may result in the deleti' +
      'on of Past '#13#10'Pregnancy Data. Do you wish to continue and '#13#10'lose ' +
      'this data or would you prefer to increase '#13#10'the Total Number of ' +
      'Pregnancies such that no '#13#10'data would be lost?'
    TabOrder = 2
  end
end
