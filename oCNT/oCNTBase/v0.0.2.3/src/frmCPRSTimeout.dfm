object CPRSTimeOut: TCPRSTimeOut
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Warning'
  ClientHeight = 183
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Image1: TImage
    Left = 2
    Top = 16
    Width = 60
    Height = 60
  end
  object OKBtn: TButton
    Left = 316
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Exit to CPRS'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 397
    Top = 151
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Continue'
    ModalResult = 2
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 70
    Top = 16
    Width = 400
    Height = 129
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'CPRS has entered its timeout countdown! '#13#10' '#13#10'You must go to CPRS' +
      ' and click the "Don'#8217't Close CPRS" button, '#13#10'then return here and' +
      ' click on "Continue" '#13#10'to resume working in this template.  '#13#10#13#10 +
      'Clicking on "Exit to CPRS" will save and close this template.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
