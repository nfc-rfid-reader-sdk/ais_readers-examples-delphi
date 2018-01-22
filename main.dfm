object frmMain: TfrmMain
  Left = 549
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BaseHD'
  ClientHeight = 547
  ClientWidth = 839
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grpBaseCommands: TGroupBox
    Left = 8
    Top = 16
    Width = 823
    Height = 201
    Caption = ' Base Commands '
    TabOrder = 0
    object lblDevices: TLabel
      Left = 151
      Top = 23
      Width = 42
      Height = 13
      Caption = 'DEVICES'
    end
    object btnLibVersion: TButton
      Left = 24
      Top = 88
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'LIB VERSION'
      TabOrder = 1
      OnClick = btnLibVersionClick
    end
    object btnGetRun: TButton
      Left = 24
      Top = 23
      Width = 121
      Height = 50
      Cursor = crHandPoint
      Caption = 'LOAD DEVICES'
      TabOrder = 0
      OnClick = btnGetRunClick
    end
    object btnExit: TButton
      Left = 664
      Top = 152
      Width = 145
      Height = 41
      Cursor = crHandPoint
      Caption = 'EXIT'
      TabOrder = 2
      OnClick = btnExitClick
    end
    object btnGetTime: TButton
      Left = 151
      Top = 88
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'GET TIME'
      TabOrder = 3
      OnClick = btnGetTimeClick
    end
    object cboDevices: TComboBox
      Left = 151
      Top = 42
      Width = 82
      Height = 31
      Cursor = crHandPoint
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object btnSetTime: TButton
      Left = 278
      Top = 88
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'SET TIME'
      TabOrder = 5
      OnClick = btnSetTimeClick
    end
    object btnRTE: TButton
      Left = 405
      Top = 88
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'RTE'
      TabOrder = 6
      OnClick = btnRTEClick
    end
  end
  object stbStatus: TStatusBar
    Left = 0
    Top = 522
    Width = 839
    Height = 25
    Panels = <
      item
        Alignment = taCenter
        Text = 'DEVICES COUNT'
        Width = 120
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object txtOutput: TMemo
    Left = 8
    Top = 223
    Width = 823
    Height = 293
    ReadOnly = True
    TabOrder = 2
  end
end
