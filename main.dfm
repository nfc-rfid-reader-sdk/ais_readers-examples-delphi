object frmMain: TfrmMain
  Left = 549
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BaseHD'
  ClientHeight = 687
  ClientWidth = 905
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
    Top = 3
    Width = 889
    Height = 279
    Caption = ' Base Commands '
    TabOrder = 0
    object lblDevices: TLabel
      Left = 169
      Top = 23
      Width = 46
      Height = 13
      Caption = 'DEVICES:'
    end
    object Shape3: TShape
      Left = 40
      Top = 85
      Width = 377
      Height = 3
    end
    object btnLibVersion: TButton
      Left = 296
      Top = 100
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'LIB VERSION'
      TabOrder = 1
      OnClick = btnLibVersionClick
    end
    object btnGetRun: TButton
      Left = 42
      Top = 23
      Width = 121
      Height = 50
      Cursor = crHandPoint
      Caption = 'LOAD DEVICES'
      TabOrder = 0
      OnClick = btnGetRunClick
    end
    object btnGetTime: TButton
      Left = 42
      Top = 100
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'GET TIME'
      TabOrder = 2
      OnClick = btnGetTimeClick
    end
    object cboDevices: TComboBox
      Left = 169
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
      TabOrder = 3
    end
    object btnSetTime: TButton
      Left = 169
      Top = 100
      Width = 121
      Height = 41
      Cursor = crHandPoint
      Caption = 'SET TIME'
      TabOrder = 4
      OnClick = btnSetTimeClick
    end
    object grpLogs: TGroupBox
      Left = 428
      Top = 23
      Width = 449
      Height = 224
      TabOrder = 5
      object lblTimeDuration: TLabel
        Left = 32
        Top = 14
        Width = 70
        Height = 13
        Caption = 'Time Duration:'
      end
      object lblLogStartIndex: TLabel
        Left = 33
        Top = 95
        Width = 55
        Height = 13
        Caption = 'Start Index'
      end
      object lblLogEndIndex: TLabel
        Left = 173
        Top = 95
        Width = 49
        Height = 13
        Caption = 'End Index'
      end
      object lblLogStartTime: TLabel
        Left = 33
        Top = 148
        Width = 49
        Height = 13
        Caption = 'Start Time'
      end
      object lblLogEndTime: TLabel
        Left = 33
        Top = 185
        Width = 43
        Height = 13
        Caption = 'End Time'
      end
      object Bevel1: TBevel
        Left = 33
        Top = 72
        Width = 400
        Height = 3
      end
      object Bevel2: TBevel
        Left = 33
        Top = 132
        Width = 400
        Height = 3
      end
      object btnRTE: TButton
        Left = 120
        Top = 19
        Width = 121
        Height = 44
        Cursor = crHandPoint
        Caption = 'RTE'
        TabOrder = 0
        OnClick = btnRTEClick
      end
      object txtRteDuration: TEdit
        Left = 32
        Top = 33
        Width = 70
        Height = 29
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
      end
      object btnAllLogs: TButton
        Left = 247
        Top = 19
        Width = 186
        Height = 44
        Cursor = crHandPoint
        Caption = 'ALL LOGS'
        TabOrder = 2
        OnClick = btnAllLogsClick
      end
      object txtLogStartIndex: TEdit
        Left = 94
        Top = 88
        Width = 70
        Height = 29
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        TabOrder = 3
      end
      object txtLogEndIndex: TEdit
        Left = 228
        Top = 88
        Width = 70
        Height = 29
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        TabOrder = 4
      end
      object btnLogByIndex: TButton
        Left = 304
        Top = 81
        Width = 129
        Height = 40
        Cursor = crHandPoint
        Caption = 'LOG BY INDEX'
        TabOrder = 5
        OnClick = btnLogByIndexClick
      end
      object txtLogStartTime: TEdit
        Left = 94
        Top = 143
        Width = 136
        Height = 29
        Hint = 'Enter timestamp'
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object txtLogEndTime: TEdit
        Left = 94
        Top = 178
        Width = 136
        Height = 29
        Hint = 'Enter timestamp'
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object btnLogByTime: TButton
        Left = 256
        Top = 143
        Width = 177
        Height = 64
        Cursor = crHandPoint
        Caption = 'LOG BY TIME'
        TabOrder = 8
        OnClick = btnLogByTimeClick
      end
    end
    object btnUnreadLogCount: TButton
      Left = 42
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG COUNT'
      TabOrder = 6
      OnClick = btnUnreadLogCountClick
    end
    object btnUnreadLogGet: TButton
      Left = 169
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG GET'
      TabOrder = 7
      OnClick = btnUnreadLogGetClick
    end
    object btnUnreadLogAck: TButton
      Left = 296
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG ACK'
      TabOrder = 8
      OnClick = btnUnreadLogAckClick
    end
  end
  object stbStatus: TStatusBar
    Left = 0
    Top = 662
    Width = 905
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
    ExplicitWidth = 839
  end
  object txtOutput: TMemo
    Left = 8
    Top = 288
    Width = 889
    Height = 330
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btnExit: TButton
    Left = 752
    Top = 620
    Width = 145
    Height = 39
    Cursor = crHandPoint
    Caption = 'EXIT'
    TabOrder = 3
    OnClick = btnExitClick
  end
  object btnClearEditBox: TButton
    Left = 8
    Top = 620
    Width = 145
    Height = 39
    Cursor = crHandPoint
    Caption = 'CLEAR'
    TabOrder = 4
    OnClick = btnClearEditBoxClick
  end
  object pBar: TProgressBar
    Left = 170
    Top = 624
    Width = 565
    Height = 32
    Smooth = True
    TabOrder = 5
    Visible = False
  end
end
