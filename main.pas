unit main;

{
 ver 1.0.10;
}


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,System.Types, System.StrUtils,
  System.IniFiles,
  constants,
  libcoder,
  functions, Vcl.ExtCtrls;

type
   DEV_HND = ^TDevice_S;
   PROGRESS = ^TS_PROGRESS;
type
  TfrmMain = class(TForm)
    grpBaseCommands: TGroupBox;
    stbStatus: TStatusBar;
    txtOutput: TMemo;
    btnLibVersion: TButton;
    btnGetRun: TButton;
    btnGetTime: TButton;
    lblDevices: TLabel;
    cboDevices: TComboBox;
    btnSetTime: TButton;
    btnExit: TButton;
    Shape3: TShape;
    btnUnreadLogCount: TButton;
    btnUnreadLogGet: TButton;
    btnUnreadLogAck: TButton;
    btnClearEditBox: TButton;
    pBar: TProgressBar;
    rgrpLights: TRadioGroup;
    btnLightChoise: TButton;
    pgMain: TPageControl;
    tabLogs: TTabSheet;
    grpLogs: TGroupBox;
    lblTimeDuration: TLabel;
    lblLogStartIndex: TLabel;
    lblLogEndIndex: TLabel;
    lblLogStartTime: TLabel;
    lblLogEndTime: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnRTE: TButton;
    txtRteDuration: TEdit;
    btnAllLogs: TButton;
    txtLogStartIndex: TEdit;
    txtLogEndIndex: TEdit;
    btnLogByIndex: TButton;
    txtLogStartTime: TEdit;
    txtLogEndTime: TEdit;
    btnLogByTime: TButton;
    tabBWLists: TTabSheet;
    pgWhiteL: TPageControl;
    tabWhiteL: TTabSheet;
    btnReadWhiteList: TButton;
    grpWhiteW: TGroupBox;
    txtWhiteWLabel: TMemo;
    txtWhiteW: TMemo;
    btnWhiteListWrite: TButton;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    txtBlackWriteLabel: TMemo;
    txtWriteB: TMemo;
    btnBlackListWrite: TButton;
    btnReadBlackList: TButton;
    procedure btnLibVersionClick(Sender: TObject);
    procedure btnGetRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnGetTimeClick(Sender: TObject);
    procedure btnSetTimeClick(Sender: TObject);
    procedure btnRTEClick(Sender: TObject);
    procedure btnAllLogsClick(Sender: TObject);
    procedure btnLogByIndexClick(Sender: TObject);
    procedure btnLogByTimeClick(Sender: TObject);
    procedure btnUnreadLogCountClick(Sender: TObject);
    procedure btnUnreadLogGetClick(Sender: TObject);
    procedure btnUnreadLogAckClick(Sender: TObject);
    procedure btnClearEditBoxClick(Sender: TObject);
    procedure btnLightChoiseClick(Sender: TObject);
    procedure btnReadWhiteListClick(Sender: TObject);
    procedure btnWhiteListWriteClick(Sender: TObject);
    procedure btnReadBlackListClick(Sender: TObject);
    procedure btnBlackListWriteClick(Sender: TObject);

  private
    dev:DEV_HND;
    progress_:PROGRESS;
    HND_LIST:array of integer;
    procedure prepare_list_for_check;
    function list_for_check_print: string;
    function load_list_from_file:boolean;
    function list_device():integer;    //dev:TDevice_S
    function add_device(devType, devId:integer):boolean;
    function GetListInformation:string;
    function MainLoop(dev:DEV_HND):Boolean;
    function print_log_unread(dev:DEV_HND):string;
    procedure PrintRTE(dev:DEV_HND);
    procedure PrintLog(dev:DEV_HND);
    procedure DoCmd(dev:DEV_HND);
    procedure print_percent(percent:integer);

  public
    function AISGetTime(out res:string; dev:DEV_HND):int64;
    function AISSetTime(dev:DEV_HND):string;
    procedure LogGet(dev:DEV_HND);
    procedure LogByIndex(startIndex,endIndex:integer; dev:DEV_HND);
    procedure LogByTime(startTime,endTime:integer; dev:DEV_HND);
    procedure UnreadLogGet(dev:DEV_HND);
    procedure UnreadLogAck(recToAck:Int32;dev:DEV_HND);
    procedure LightChoise(index:integer; dev:DEV_HND);
    procedure WhiteList_Read(dev:DEV_HND);
    procedure WhiteList_Write(dev:DEV_HND);
    procedure BlackList_Read(dev:DEV_HND);
    procedure BlackList_Write(dev:DEV_HND);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function TfrmMain.add_device(devType, devId: integer): boolean;
var
   status:DL_STATUS;
begin
   status:=AIS_List_AddDeviceForCheck(devType, devId);
   txtOutput.Lines.Add(format('AIS_List_AddDeviceForCheck(type: %d, id: %d)> { %s }',[devType, devId, dl_status2str(status)]));
   if status = 0 then Result:=True
   else Result:=False;
end;

function TfrmMain.AISGetTime(out res:string; dev:DEV_HND): int64;
var
  currTime : Int64;
  timezone,
  DST,
  offset   : integer;
  additional :Byte;
  devStatus:DL_STATUS;
begin
  devStatus:=AIS_GetTime(dev.hnd, currTime, timezone, DST, offset, additional);
  res:=Format('AIS_GetTime(dev[%d] hnd=%x)> status=%s (tz=%d | DST=%d | offset=%d | additional=%d | ts=%d | %s)' , [dev.idx + 1, dev.hnd, dl_status2str(devStatus),timezone, DST, offset, additional, currTime, DateTimeToStr(UnixToDateTime(currTime))]);
  Result:=currTime;
end;

function TfrmMain.AISSetTime(dev: DEV_HND):string;
var
    timez,
    DST,
    offset : integer;
    currTime:Int64;
    additional:Byte;
    devStatus:DL_STATUS;
begin
    timez := sys_get_timezone;
    DST   := sys_get_daylight;
    offset := sys_get_dstbias;
    currTime :=DateTimeToUnix(Now);
    devStatus:=AIS_SetTime(dev.hnd, PASS, currTime, timez, DST, offset, additional);
    Result:=Format('AIS_SetTime(dev[%d] hnd=%x  pass:%s)> status=%s (timezone=%d | DST=%d | offset=%d | additional=%d |  ts=%d | %s )',
             [dev.idx + 1, dev.hnd, PASS, dl_status2str(devStatus), timez, DST, offset, additional,  currTime, DateTimeToStr(UnixToDateTime(currTime))]);
end;

procedure TfrmMain.BlackList_Read(dev: DEV_HND);
var
    black_list_size :integer;
    black_list      :PAnsiChar;
begin
    dev.status_:= AIS_Blacklist_Read(dev.hnd, PASS, @black_list);
    if dev.status_= DL_OK then
       black_list_size:=Length(black_list)
    else
       black_list_size:=0;
    txtOutput.Lines.Add(#13#10 + '=- BLACK LIST READ -=');
    txtOutput.Lines.Add(Format('dev[%d]  AIS_Blacklist_Read(pass:%s): size= %d >%s > %s' , [dev.idx+1, PASS, black_list_size, black_list, dl_status2str(dev.status_)]));

end;

procedure TfrmMain.BlackList_Write(dev: DEV_HND);
var
    black_list_write:ansistring;
begin
    black_list_write:=txtWriteB.Text;
    dev.status_ := AIS_Blacklist_Write(dev.hnd, PASS, black_list_write);
    txtOutput.Lines.Add(#13#10 + '=- BLACK LIST WRITE -=');
    txtOutput.Lines.Add(Format('dev[%d]  AIS_Blacklist_Write(pass:%s):black_list= %s > %s' , [dev.idx+1, PASS, black_list_write, dl_status2str(dev.status_)]));
end;

procedure TfrmMain.btnAllLogsClick(Sender: TObject);
begin
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   pBar.Visible:=True;
   LogGet(dev);
   pBar.Visible:=False;
end;

procedure TfrmMain.btnBlackListWriteClick(Sender: TObject);
begin
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   BlackList_Write(dev);
end;

procedure TfrmMain.btnClearEditBoxClick(Sender: TObject);
begin
  txtOutput.Clear;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnGetRunClick(Sender: TObject);
begin
    txtOutput.Lines.Add(AIS_GetLibraryVersionStr);
    stbStatus.Panels[1].Text:=IntToStr(list_device);
end;

procedure TfrmMain.btnGetTimeClick(Sender: TObject);
var
  res:string;
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  AISGetTime(res, dev);
  txtOutput.Lines.Add(res);
end;

procedure TfrmMain.btnLibVersionClick(Sender: TObject);
begin
   txtOutput.Lines.Add(AIS_GetLibraryVersionStr);
end;



procedure TfrmMain.btnLightChoiseClick(Sender: TObject);
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  LightChoise(rgrpLights.ItemIndex, dev);
end;

procedure TfrmMain.btnLogByIndexClick(Sender: TObject);
var
   startIdx,
   endIdx:integer;
begin
   if Trim(txtLogStartIndex.Text) = EmptyStr then begin
      MessageDlg('You must enter start index !', mtWarning, [mbOK], 0);
      txtLogStartIndex.SetFocus;
      Exit;
   end;

   if Trim(txtLogEndIndex.Text) = EmptyStr then begin
      MessageDlg('You must enter end index !', mtWarning, [mbOK], 0);
      txtLogEndIndex.SetFocus;
      Exit;
   end;
   startIdx:=StrToInt(txtLogStartIndex.Text);
   endIdx:=StrToInt(txtLogEndIndex.Text);
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   pBar.Visible:=True;
   LogByIndex(startIdx, endIdx, dev);
   pBar.Visible:=False;
end;

procedure TfrmMain.btnLogByTimeClick(Sender: TObject);
var
   startT,
   endT:Int64;
begin
   if Trim(txtLogStartTime.Text) = EmptyStr then begin
      MessageDlg('You must enter start time !', mtWarning, [mbOK], 0);
      txtLogStartTime.SetFocus;
      Exit;
   end;

   if Trim(txtLogEndTime.Text) = EmptyStr then begin
      MessageDlg('You must enter end Time !', mtWarning, [mbOK], 0);
      txtLogEndTime.SetFocus;
      Exit;
   end;
   startT:=StrToInt(txtLogStartTime.Text);
   endT:=StrToInt(txtLogEndTime.Text);
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   pBar.Visible:=True;
   LogByTime(startT, endT, dev);
   pBar.Visible:=False;
end;

procedure TfrmMain.btnSetTimeClick(Sender: TObject);
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  txtOutput.Lines.Add(AISSetTime(dev));
end;



procedure TfrmMain.btnUnreadLogAckClick(Sender: TObject);
var
   recToAck:Int32;
begin
  recToAck:=RECORDS_TO_ACK;
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  UnreadLogAck(recToAck, dev);
end;

procedure TfrmMain.btnUnreadLogCountClick(Sender: TObject);
begin
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   MainLoop(dev);
   txtOutput.Lines.Add(print_log_unread(dev));
end;

procedure TfrmMain.btnUnreadLogGetClick(Sender: TObject);
begin
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   UnreadLogGet(dev);
end;

procedure TfrmMain.btnWhiteListWriteClick(Sender: TObject);
begin
   dev.idx :=cboDevices.ItemIndex;
   dev.hnd:=HND_LIST[dev.idx];
   WhiteList_Write(dev);
end;

procedure TfrmMain.DoCmd(dev: DEV_HND);
begin
   if dev.status_ <> DL_OK then Exit;
   dev.cmd_finish:=False;
   New(progress_);
   progress_.print_hdr:=True;
   while  dev.cmd_finish = false do begin
      if MainLoop(dev) = false then break;
   end;
   Dispose(progress_);
end;

function TfrmMain.GetListInformation: string;
var
        res_0,
        res_1,
        res:string;
        devIdx:integer;
        devHnd:integer;
        devSerial:PAnsiChar;
        devType,
        devID,
        devFW_VER,
        devCommSpeed:integer;
        devFTDI_Serial:PAnsiChar;
        devOpened,
        devStatus,
        systemStatus:integer;
        status:DL_STATUS;
        devCount:integer;
        i:integer;

begin
        res:= format_grid[0] + #13#10 + format_grid[1] + #13#10 + format_grid[2] + #10;
        res_1:= format_grid[0] + #13#10;
        status:=AIS_List_UpdateAndGetCount(devCount);
        if devCount = 0 then begin
          txtOutput.Lines.Add('NO DEVICES FOUND');
          Exit;
        end;
        try
          txtOutput.Lines.Add(res);
          SetLength(HND_LIST, devCount);
          cboDevices.Clear;
          for i := 0 to devCount do
          begin
             status:=AIS_List_GetInformation(devHnd, devSerial, devType, devID, devFW_VER, devCommSpeed, devFTDI_Serial,
                                                devOpened, devStatus, systemStatus);
             if status <> DL_OK then Exit;

             HND_LIST[i]:= devHnd;
             New(dev);
             dev^.idx:=i+1;
             dev^.hnd:=devHnd;
             dev^.SN:=devSerial;
             dev^.dev_Type:=devType;
             dev^.ID:=devID;
             dev^.open:=devOpened;
             AIS_Open(devHnd);
             txtOutput.Lines.Add(Format(list_info, [i+1, devHnd, devSerial, devType, devID, devFW_VER, devCommSpeed, devFTDI_Serial, devOpened,devStatus, systemStatus]));
             cboDevices.Items.Append(IntToStr(dev^.idx));
          end;
        finally
          txtOutput.Lines.Add(res_1);
          cboDevices.ItemIndex:=0;
          Dispose(dev);
        end;

end;

procedure TfrmMain.LightChoise(index: integer; dev: DEV_HND);
var
   i:Byte;
   lights:array[0..3] of int32;
begin
   for i := Low(lights) to High(lights) do lights[i]:=0;
   lights[index]:=1;
   dev.status_ := AIS_LightControl(dev.hnd, lights[0], lights[1], lights[2], lights[3]);
   txtOutput.Lines.Add(Format('dev[%d] AIS_LightControl(master:green= %d | master:red= %d || slave:green= %d | slave:red= %d) > %s' , [dev.idx + 1, lights[0], lights[1], lights[2], lights[3] , dbg_action2str(dev.status_)]));
end;

procedure TfrmMain.prepare_list_for_check;
begin
    txtOutput.Lines.Add('AIS_List_GetDevicesForCheck() BEFORE / DLL STARTUP');
    list_for_check_print;
    AIS_List_EraseAllDevicesForCheck;
    if not load_list_from_file then begin
      txtOutput.Lines.Add('Tester try to connect with a Base HD device on any/unkown ID');
      add_device(11,0);
    end;
    txtOutput.Lines.Add('AIS_List_GetDevicesForCheck() AFTER LIST UPDATE');
    list_for_check_print;

end;

procedure TfrmMain.PrintLog(dev:DEV_HND);
var
        nfc_uid,
        uid_uid_len :ShortString;
        rteCount :integer;
        i:integer;
begin
        rteCount :=  AIS_ReadLog_Count(dev.hnd);
        txtOutput.Lines.Add(Format('AIS_ReadLog_Count = %d ', [rteCount]));
        txtOutput.Lines.Add(rte_list_header[0]  + #13#10 + rte_list_header[1] + #13#10 + rte_list_header[2] + #10);
        while True do
        begin
           dev^.status_ :=  AIS_ReadLog(dev.hnd,
                                      dev.log.log_index,
                                      dev.log.log_action,
                                      dev.log.log_reader_id,
                                      dev.log.log_card_id,
                                      dev.log.log_system_id,
                                      @dev.log.log_nfc_uid,
                                      dev.log.log_nfc_uid_len,
                                      dev.log.log_timestamp);

            if dev.status_ <> DL_OK then begin
              txtOutput.Lines.Add(dl_status2str(dev.status_));
              break;
            end;

            nfc_uid := '';
            for i:=0 to dev.log.log_nfc_uid_len do
                nfc_uid := nfc_uid + format(':%02X' , [dev.log.log_nfc_uid[i]]);

            uid_uid_len := '[' + IntToStr(dev.log.log_nfc_uid_len) + '] | ' + nfc_uid;
            txtOutput.Lines.Add(Format(rte_format, [dev.log.log_index, dbg_action2str(dev.log.log_action), dev.log.log_reader_id, dev.log.log_card_id,
                                          dev.log.log_system_id, uid_uid_len,
                                          dev.log.log_timestamp, DateTimeToStr(UnixToDateTime(dev.log.log_timestamp))]) + rte_list_header[2]);

        end;
end;



procedure TfrmMain.PrintRTE(dev: DEV_HND);
var
        nfc_uid,
        uid_uid_len :ShortString;
        rteCount :integer;
        i:integer;
begin
        rteCount :=  AIS_ReadRTE_Count(dev.hnd);
        txtOutput.Lines.Add(Format('AIS_ReadRTE_Count = %d '+#13#10+' = RTE Real Time Events = ' , [rteCount]));
        txtOutput.Lines.Add(rte_list_header[0]  + #13#10 + rte_list_header[1] + #13#10 + rte_list_header[2] + #10);

        while True do
        begin
            dev.status_ :=  AIS_ReadRTE(dev.hnd,
                                        dev.log.log_index,
                                        dev.log.log_action,
                                        dev.log.log_reader_id,
                                        dev.log.log_card_id,
                                        dev.log.log_system_id,
                                        @dev.log.log_nfc_uid,
                                        dev.log.log_nfc_uid_len,
                                        dev.log.log_timestamp);

            if  dev.status_ <> DL_OK then begin
              txtOutput.Lines.Add(dl_status2str(dev.status_));
              break;
            end;

            nfc_uid := '';
            for i:=0 to dev.log.log_nfc_uid_len do
                nfc_uid := nfc_uid + format(':%02X' , [dev.log.log_nfc_uid[i]]);

            uid_uid_len := '[' + IntToStr(dev.log.log_nfc_uid_len) + '] | ' + nfc_uid;

            txtOutput.Lines.Add(Format(rte_format, [dev.log.log_index, dbg_action2str(dev.log.log_action), dev.log.log_reader_id, dev.log.log_card_id,
                                          dev.log.log_system_id, uid_uid_len,
                                          dev.log.log_timestamp, DateTimeToStr(UnixToDateTime(dev.log.log_timestamp))]) + rte_list_header[2]);

            txtOutput.Lines.Add(Format('LOG unread (incremental) = %d | AIS_ReadRTE()= %s ', [dev.UnreadLog, dbg_action2str(dev.status_)]));
        end;

end;

function TfrmMain.print_log_unread(dev: DEV_HND):string;
begin
  Result:=(Format('dev[%d]:LOG unread (incremental) = %d %s' , [dev.idx + 1, dev.UnreadLog, dbg_action2str(dev.status_)]));
end;

procedure TfrmMain.print_percent(percent: integer);
begin
   while (progress_.percent_old < percent) do begin
    if progress_.percent_old < 100 then pBar.Position:= progress_.percent_old;
    Inc(progress_.percent_old);
   end;
end;

procedure TfrmMain.UnreadLogAck(recToAck:Int32; dev:DEV_HND);
begin
   dev.status_ := AIS_UnreadLOG_Ack(dev.hnd, recToAck);
   txtOutput.Lines.Add(Format('dev[%d] : AIS_UnreadLOG_Ack() = %s',[dev.idx + 1, dbg_action2str(dev.status_)]));
end;

procedure TfrmMain.UnreadLogGet(dev: DEV_HND);
var
        nfc_uid,
        uid_uid_len :ShortString;
        i:integer;
begin
        txtOutput.Lines.Add(rte_list_header[0]  + #13#10 + rte_list_header[1] + #13#10 + rte_list_header[2] + #10);
        dev.status_ :=  AIS_UnreadLOG_Get(dev.hnd,
                                         dev.log.log_index,
                                         dev.log.log_action,
                                         dev.log.log_reader_id,
                                         dev.log.log_card_id,
                                         dev.log.log_system_id,
                                         @dev.log.log_nfc_uid,
                                         dev.log.log_nfc_uid_len,
                                         dev.log.log_timestamp);

            if dev.status_ <> DL_OK then begin
              txtOutput.Lines.Add(dl_status2str(dev.status_));
              Exit;
            end;

            nfc_uid := '';
            for i:=0 to dev.log.log_nfc_uid_len do
                nfc_uid := nfc_uid + format(':%02X' , [dev.log.log_nfc_uid[i]]);

            uid_uid_len := '[' + IntToStr(dev.log.log_nfc_uid_len) + '] | ' + nfc_uid;
            txtOutput.Lines.Add(Format(rte_format, [dev.log.log_index, dbg_action2str(dev.log.log_action), dev.log.log_reader_id, dev.log.log_card_id,
                                          dev.log.log_system_id, uid_uid_len,
                                          dev.log.log_timestamp, DateTimeToStr(UnixToDateTime(dev.log.log_timestamp))]) + rte_list_header[2]);



end;

procedure TfrmMain.WhiteList_Read(dev:DEV_HND);
var
    white_list_size :integer;
    white_list      :PAnsiChar;
begin
    dev.status_:= AIS_Whitelist_Read(dev.hnd, PASS, @white_list);
    if dev.status_= DL_OK then
       white_list_size:=Length(white_list)
    else
       white_list_size:=0;
    txtOutput.Lines.Add(#13#10 +'=- WHITE LIST READ -=');
    txtOutput.Lines.Add(Format('dev[%d]  AIS_Whitelist_Read(pass:%s): size= %d >%s > %s' , [dev.idx+1, PASS, white_list_size, white_list, dl_status2str(dev.status_)]));
end;

procedure TfrmMain.WhiteList_Write(dev: DEV_HND);
var
    white_list_write:ansistring;
begin
    white_list_write:=txtWhiteW.Text;
    dev.status_ := AIS_Whitelist_Write(dev.hnd, PASS, white_list_write);
    txtOutput.Lines.Add(#13#10 +'=- WHITE LIST WRITE -=');
    txtOutput.Lines.Add(Format('dev[%d]  AIS_Whitelist_Write(pass:%s):white_list= %s > %s' , [dev.idx+1,PASS, white_list_write, dl_status2str(dev.status_)]));
end;


function TfrmMain.list_device(): integer;
var
  status:DL_STATUS;
  devCount:integer;
begin
     Result:=0;
     prepare_list_for_check;
     txtOutput.Lines.Add('checking...please wait...');
     status:=AIS_List_UpdateAndGetCount(devCount);
     txtOutput.Lines.Add(format('AIS_List_UpdateAndGetCount() status: %d | dev count: %d', [status, devCount]));
     if devCount = 0 then begin
        txtOutput.Lines.Add('NO DEVICES FOUND');
        Exit;
     end;
     if devCount > 0 then GetListInformation;
     Result:=devCount;
end;

function TfrmMain.list_for_check_print:string;
  var
    rv : PAnsiChar;
    rvs:string;
    dev_type_str : PAnsiChar;
    dev_type,
    dev_id,a:integer;
    status:DL_STATUS;
    arrv,ll:TStringDynArray;
  begin
       rv := AIS_List_GetDevicesForCheck;
       if  Length(rv) = 0 then Exit;
       arrv:=SplitString(rv, ESCAPE_DELIMITER); //escape delimiter #10 .. '\n'
       for a:=Low(arrv) to High(arrv)-1 do begin
           ll:= SplitString(arrv[a], DEV_DELIMITER);
           dev_type:=StrToInt(Trim(ll[0]));
           dev_id:=StrToInt(Trim(ll[1]));
           status:= device_type_enum2str(dev_type, dev_type_str);
           if status <> 0 then Continue;
           txtOutput.Lines.Add(format('%2s(enum= %d) on ID %d', [dev_type_str,dev_type, dev_id]));
       end;

  end;

function TfrmMain.load_list_from_file: boolean;
var
   devIni:TMemIniFile;
   addedDevType,
   devTypeEnum,
   dev_id :integer;
   devValues:TStringList;
   arrv,ll:TStringDynArray;
   dev_type_str : ansistring;
   i:byte;
   status:DL_STATUS;
begin
   addedDevType:=0;
   GetCurrentDir;
   devValues:=TStringList.Create;
   devIni:=TMemIniFile.Create(INI_FILE_NAME);
   try
      devIni.ReadSectionValues(INI_DEVICE_SECT, devValues);
      arrv:=SplitString(devValues.Text, ESCAPE_DELIMITER);
      for i := 0 to devValues.Count-1 do begin
        ll:=SplitString(arrv[i], INI_DELIMITER);
        dev_type_str:=(Trim(ll[0]));
        dev_id:=StrToInt(Trim(ll[1]));
        status:=device_type_str2enum(dev_type_str, devTypeEnum);
        if status <> 0 then continue;
        if add_device(devTypeEnum, dev_id) = True then inc(addedDevType);
       end;
   finally
     devIni.Free;
     devValues.Free;
     if addedDevType > 0  then Result:=True else Result:=False;
   end;

end;

procedure TfrmMain.LogByIndex(startIndex,endIndex:integer; dev: DEV_HND);
begin
    dev.status_:=AIS_GetLogByIndex(dev.hnd, PASS, startIndex, endIndex);
    if dev.status_ <> DL_OK then begin
       txtOutput.Lines.Add(Format('dev[%d] AIS_GetLogByIndex() : %s | start index= %d  | end index= %d', [dev.idx + 1, dl_status2str(dev.status_), startIndex, endIndex]));
       Exit;
    end;
    DoCmd(dev);
    PrintLog(dev);
end;

procedure TfrmMain.LogByTime(startTime, endTime: integer; dev: DEV_HND);
begin
    dev.status_:=AIS_GetLogByTime(dev.hnd, PASS, startTime, endTime);
    if dev.status_ <> DL_OK then begin
       txtOutput.Lines.Add(Format('dev[%d] AIS_GetLogByTime() : %s | start time= %d  | end time= %d', [dev.idx + 1, dl_status2str(dev.status_), startTime, endTime]));
       Exit;
    end;
    DoCmd(dev);
    PrintLog(dev);

end;

procedure TfrmMain.LogGet(dev: DEV_HND);
begin
    dev.status_ := AIS_GetLog(dev.hnd, PASS);
    if dev.status_ <> DL_OK then begin
       txtOutput.Lines.Add(Format('dev[%d] AIS_GetLog() : %s ', [dev.idx + 1, dl_status2str(dev.status_)]));
       Exit;
    end;
    DoCmd(dev);
    PrintLog(dev);
end;

function TfrmMain.MainLoop(dev:DEV_HND): Boolean;
var
        real_time_events,
        log_available,
        unreadLog,
        cmd_responses,
        cmd_percent,
        device_status,
        time_out_occurred,
        _status : integer;
        devStatus:DL_STATUS;
begin
        devStatus :=AIS_MainLoop(dev.hnd, real_time_events, log_available, unreadLog, cmd_responses,
                                    cmd_percent, device_status, time_out_occurred, _status);

        dev.RealTimeEvents:=real_time_events;
        dev.LogAvailable := log_available;
        dev.UnreadLog := unreadLog;
        dev.cmdResponses := cmd_responses;
        dev.cmdPercent := cmd_percent;
        dev.DeviceStatus := device_status;
        dev.TimeoutOccurred := time_out_occurred;
        dev.Status := _status;

        if devStatus<> DL_OK then begin
           if dev.status_last <> devStatus then
           begin
             txtOutput.Lines.Add(Format('MainLoop() status: %d', [devStatus]));
             dev.status_last:=devStatus;
           end;
        Result:=False;
        end;

        if dev.RealTimeEvents > 0 then begin
          PrintRTE(dev);
        end;

        if dev.LogAvailable > 0 then begin
            txtOutput.Lines.Add(Format('LOG= %d',[dev.LogAvailable]));
            PrintLog(dev);

        end;

//        if dev.UnreadLog > 0 then begin
//          if dev.UnreadLog_last <> dev.UnreadLog then
//             dev.UnreadLog_last := dev.UnreadLog;
//             txtOutput.Lines.Add(print_log_unread(dev));
//        end;

        if dev.TimeoutOccurred > 0 then
           txtOutput.Lines.Add(Format('TimeoutOccurred= %d',[dev.TimeoutOccurred]));


        if dev.Status <> 0 then begin
           txtOutput.Lines.Add(Format('[%d] local_status= %s' , [dev.idx, dl_status2str(dev.Status)]));
        end;

        if dev.cmdPercent > 0 then print_percent(dev.cmdPercent);

        if dev.cmdResponses > 0 then begin
            txtOutput.Lines.Add('-- COMMAND FINISH !--');
            dev.cmd_finish := True;
//            Result:=False;
        end;
        Result:=True;
end;

procedure TfrmMain.btnReadBlackListClick(Sender: TObject);
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  BlackList_Read(dev);
end;

procedure TfrmMain.btnReadWhiteListClick(Sender: TObject);
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  WhiteList_Read(dev);
end;

procedure TfrmMain.btnRTEClick(Sender: TObject);
var
    hnd,i:integer;
    maxSec:integer;
    stopTime:int64;
begin
    if Trim(txtRteDuration.Text) = EmptyStr then begin
       MessageDlg('You must enter time duration for RTE !', mtWarning, [mbOK], 0);
       txtRteDuration.SetFocus;
       Exit;
    end;
    maxsec:=StrToInt(txtRteDuration.Text);
    stopTime:=DateTimeToUnix(Now) + maxSec;
    txtOutput.Lines.Add(Format('Wait for RTE for %d...', [maxsec]));

    while (DateTimeToUnix(Now)) < stopTime do begin
      for i:=Low(HND_LIST) to High(HND_LIST) do
      begin
          dev.idx:=i+1;
          dev.hnd:=HND_LIST[i];
          MainLoop(dev);
      end;
    end;
    txtOutput.Lines.Add('End RTE listen');
end;











end.
