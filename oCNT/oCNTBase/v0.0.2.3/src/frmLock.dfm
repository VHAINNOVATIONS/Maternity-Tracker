object CNTLock: TCNTLock
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Confirm VISTA Verify Code...'
  ClientHeight = 119
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 22
    Width = 192
    Height = 13
    Caption = 'Enter VISTA verify code below to unlock'
  end
  object lblApplicationName: TLabel
    Left = 8
    Top = 39
    Width = 75
    Height = 13
    Caption = 'the Application:'
  end
  object lblUserName: TLabel
    Left = 8
    Top = 5
    Width = 56
    Height = 13
    Caption = 'User Name:'
  end
  object btnOK: TButton
    Left = 165
    Top = 87
    Width = 89
    Height = 23
    Caption = '&OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object edtVC: TEdit
    Left = 134
    Top = 58
    Width = 120
    Height = 21
    CharCase = ecUpperCase
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = edtVCKeyPress
  end
  object edtAC: TEdit
    Left = 8
    Top = 58
    Width = 120
    Height = 21
    CharCase = ecUpperCase
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = edtVCKeyPress
  end
end
