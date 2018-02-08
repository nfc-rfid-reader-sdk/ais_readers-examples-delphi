object frmMain: TfrmMain
  Left = 549
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BaseHD'
  ClientHeight = 690
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
    object btnUnreadLogCount: TButton
      Left = 42
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG COUNT'
      TabOrder = 5
      OnClick = btnUnreadLogCountClick
    end
    object btnUnreadLogGet: TButton
      Left = 169
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG GET'
      TabOrder = 6
      OnClick = btnUnreadLogGetClick
    end
    object btnUnreadLogAck: TButton
      Left = 296
      Top = 147
      Width = 121
      Height = 40
      Cursor = crHandPoint
      Caption = 'UNREAD LOG ACK'
      TabOrder = 7
      OnClick = btnUnreadLogAckClick
    end
    object rgrpLights: TRadioGroup
      Left = 42
      Top = 193
      Width = 248
      Height = 74
      Caption = ' Lights '
      Columns = 2
      Items.Strings = (
        'GREEN MASTER'
        'RED MASTER'
        'GREEN SLAVE'
        'RED SLAVE')
      TabOrder = 8
    end
    object btnLightChoise: TButton
      Left = 296
      Top = 198
      Width = 121
      Height = 69
      Cursor = crHandPoint
      Caption = 'LIGHT CHOISE'
      TabOrder = 9
      OnClick = btnLightChoiseClick
    end
    object pgMain: TPageControl
      Left = 429
      Top = 12
      Width = 454
      Height = 255
      ActivePage = tabLogs
      TabOrder = 10
      object tabLogs: TTabSheet
        Caption = 'LOGS'
        ExplicitWidth = 425
        ExplicitHeight = 213
        object grpLogs: TGroupBox
          Left = -3
          Top = 3
          Width = 449
          Height = 224
          TabOrder = 0
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
      end
      object tabBWLists: TTabSheet
        Caption = 'BLACK/WHITE LISTS'
        ImageIndex = 1
        object pgWhiteL: TPageControl
          Left = 8
          Top = 8
          Width = 427
          Height = 209
          ActivePage = tabWhiteL
          TabOrder = 0
          object tabWhiteL: TTabSheet
            Caption = 'White List '
            ExplicitTop = 23
            ExplicitWidth = 417
            ExplicitHeight = 173
            object btnReadWhiteList: TButton
              Left = 8
              Top = 130
              Width = 401
              Height = 46
              Cursor = crHandPoint
              Caption = 'WHITE LIST READ'
              TabOrder = 0
              OnClick = btnReadWhiteListClick
            end
            object grpWhiteW: TGroupBox
              Left = 8
              Top = 2
              Width = 401
              Height = 123
              Caption = ' White List Write '
              TabOrder = 1
              object txtWhiteWLabel: TMemo
                Left = 13
                Top = 18
                Width = 376
                Height = 30
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsItalic]
                Lines.Strings = (
                  
                    'Enter white-list UIDs (in HEX format delimited with '#39'.'#39' or '#39':'#39' o' +
                    'r not)'
                  
                    'Each UID separate by '#39','#39' or space eg. 37:0C:96:69,C2.66.EF.95 01' +
                    '234567')
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
              end
              object txtWhiteW: TMemo
                Left = 14
                Top = 54
                Width = 284
                Height = 58
                Lines.Strings = (
                  '')
                TabOrder = 1
              end
              object btnWhiteListWrite: TButton
                Left = 304
                Top = 54
                Width = 89
                Height = 58
                Cursor = crHandPoint
                Caption = 'WRITE'
                TabOrder = 2
                OnClick = btnWhiteListWriteClick
              end
            end
          end
          object TabSheet1: TTabSheet
            Caption = 'Black List'
            ImageIndex = 1
            object GroupBox1: TGroupBox
              Left = 8
              Top = 2
              Width = 401
              Height = 123
              Caption = ' Black List Write '
              TabOrder = 0
              object txtBlackWriteLabel: TMemo
                Left = 13
                Top = 15
                Width = 376
                Height = 32
                Alignment = taCenter
                BorderStyle = bsNone
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsItalic]
                Lines.Strings = (
                  
                    'Try to write black-list decimal numbers (delimited with anything' +
                    ')'
                  'eg. 2, 102 250;11')
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
              end
              object txtWriteB: TMemo
                Left = 14
                Top = 53
                Width = 284
                Height = 58
                Lines.Strings = (
                  '')
                TabOrder = 1
              end
              object btnBlackListWrite: TButton
                Left = 304
                Top = 53
                Width = 89
                Height = 58
                Cursor = crHandPoint
                Caption = 'WRITE'
                TabOrder = 2
                OnClick = btnBlackListWriteClick
              end
            end
            object btnReadBlackList: TButton
              Left = 8
              Top = 131
              Width = 401
              Height = 46
              Cursor = crHandPoint
              Caption = 'BLACK LIST READ'
              TabOrder = 1
              OnClick = btnReadBlackListClick
            end
          end
        end
      end
    end
  end
  object stbStatus: TStatusBar
    Left = 0
    Top = 665
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
    ExplicitTop = 662
  end
  object txtOutput: TMemo
    Left = 8
    Top = 288
    Width = 889
    Height = 330
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
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
