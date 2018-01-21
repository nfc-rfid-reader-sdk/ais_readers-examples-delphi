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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpBaseCommands: TGroupBox
    Left = 8
    Top = 16
    Width = 823
    Height = 201
    Caption = ' Base Commands '
    TabOrder = 0
    object btnLibVersion: TButton
      Left = 160
      Top = 32
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'LIB VERSION'
      TabOrder = 0
      OnClick = btnLibVersionClick
    end
    object btnGetRun: TButton
      Left = 24
      Top = 32
      Width = 121
      Height = 41
      Caption = 'LOAD DEVICES'
      TabOrder = 1
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
    ExplicitLeft = 8
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
