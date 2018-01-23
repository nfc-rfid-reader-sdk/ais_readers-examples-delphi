unit main;

{
 ver 1.0.6;
}


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,System.Types, System.StrUtils,
  System.IniFiles,
  constants,
  libcoder,
  functions;

type
   DEV_HND = TDevice_S;

type
  TfrmMain = class(TForm)
    grpBaseCommands: TGroupBox;
    stbStatus: TStatusBar;
    txtOutput: TMemo;
    btnLibVersion: TButton;
    btnGetRun: TButton;
    btnExit: TButton;
    btnGetTime: TButton;
    lblDevices: TLabel;
    cboDevices: TComboBox;
    btnSetTime: TButton;
    btnRTE: TButton;
    procedure btnLibVersionClick(Sender: TObject);
    procedure btnGetRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnGetTimeClick(Sender: TObject);
    procedure btnSetTimeClick(Sender: TObject);
    procedure btnRTEClick(Sender: TObject);

  private
    dev:DEV_HND;
    HND_LIST:array of integer;
    procedure prepare_list_for_check;
    function list_for_check_print: string;
    function load_list_from_file:boolean;
    function list_device():integer;    //dev:TDevice_S
    function add_device(devType, devId:integer):boolean;
    function GetListInformation:string;
    procedure PrintRTE(dev:DEV_HND);
    procedure PrintLog(dev:DEV_HND);
  public
    function AISGetTime(out res:string; dev:DEV_HND):int64;
    function AISSetTime(dev:DEV_HND):string;
    function MainLoop(dev:DEV_HND):Boolean;
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

function TfrmMain.AISGetTime(out res:string;dev:DEV_HND): int64;
var
  currTime : Int64;
  timezone,
  DST,
  offset   : integer;
  additional :Byte;
begin
  dev.status_:=AIS_GetTime(dev.hnd, currTime, timezone, DST, offset, additional);
  res:=format('AIS_GetTime(dev[%d] hnd=%x)> status=%d (tz= %d | DST= %d | offset= %d | additional= %d | %d | %s)' , [dev.idx + 1, dev.hnd, dev.status,timezone, DST, offset, additional, currTime, DateTimeToStr(UnixToDateTime(currTime))]);
  Result:=currTime
end;

function TfrmMain.AISSetTime(dev: DEV_HND):string;
var
    timez,
    DST,
    offset : integer;
    currTime:Int64;
    additional:byte;
begin
    timez := sys_get_timezone;
    DST   := sys_get_daylight;
    offset := sys_get_dstbias;
    currTime := DateTimeToUnix(Now);
    dev.status_:=AIS_SetTime(dev.hnd, PASS, currTime, timez, DST, offset, additional);
    Result:=(Format('AIS_SetTime(dev[%d] : pass:%s)> timezone=%d | DST=%d | offset=%d | additional=%d | status=%d | ts=%d | %s )',
             [dev.idx + 1, PASS, timez, DST, offset, additional, dev.status_, currTime, DateTimeToStr(UnixToDateTime(currTime))]));
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



procedure TfrmMain.btnSetTimeClick(Sender: TObject);
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  txtOutput.Lines.Add(AISSetTime(dev));
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
             dev.idx:=i+1;
             dev.hnd:=devHnd;
             dev.SN:=devSerial;
             dev.dev_Type:=devType;
             dev.ID:=devID;
             dev.open:=devOpened;
             AIS_Open(devHnd);
             txtOutput.Lines.Add(Format(list_info, [i+1, devHnd, devSerial, devType, devID, devFW_VER, devCommSpeed, devFTDI_Serial, devOpened,devStatus, systemStatus]));
             cboDevices.Items.Append(IntToStr(dev.idx));
          end;
        finally
          txtOutput.Lines.Add(res_1);
          cboDevices.ItemIndex:=0;
        end;

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

procedure TfrmMain.PrintLog(dev: DEV_HND);
var
        logIndex,
        logAction,
        logReaderId,
        logCardId,
        logSystemId:integer;
        lognfcUid:array [0..NFC_UID_MAX_LEN] of Byte;
        lognfcUidLen:integer;
        timeStamp :int64;
        nfc_uid,
        uid_uid_len :ShortString;
        rteCount :integer;
        i:integer;
begin
        while True do
        begin
           dev.status_ :=  AIS_ReadLog(dev.hnd,
                                        logIndex,
                                        logAction,
                                        logReaderId,
                                        logCardId,
                                        logSystemId,
                                        @lognfcUid,
                                        lognfcUidLen,
                                        timeStamp);

            if  dev.status_ <> DL_OK then begin
              txtOutput.Lines.Add(dl_status2str(dev.status_));
              break;
            end;
        end;
end;

procedure TfrmMain.PrintRTE(dev: DEV_HND);
var
        logIndex,
        logAction,
        logReaderId,
        logCardId,
        logSystemId:integer;
        nfcUid:array [0..NFC_UID_MAX_LEN] of Byte;
        nfcUidLen:integer;
        timeStamp :int64;
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

function TfrmMain.MainLoop(dev: DEV_HND): Boolean;
var
        b_print : Boolean;
        p_print : string;
        real_time_events,
        log_available,
        unreadLog,
        cmd_responses,
        cmd_percent,
        device_status,
        time_out_occurred,
        _status : integer;
begin
        dev.status_ :=AIS_MainLoop(dev.hnd, real_time_events, log_available, unreadLog, cmd_responses,
                                    cmd_percent, device_status, time_out_occurred, _status);

        dev.RealTimeEvents:=real_time_events;
        dev.LogAvailable := log_available;
        dev.UnreadLog := unreadLog;
        dev.cmdResponses := cmd_responses;
        dev.cmdPercent := cmd_percent;
        dev.DeviceStatus := device_status;
        dev.TimeoutOccurred := time_out_occurred;
        dev.Status := _status;

        if dev.status_<> DL_OK then begin
           if dev.status_last <> dev.status_ then
           begin
             txtOutput.Lines.Add(Format('MainLoop() status: %d', [dev.status_]));
             dev.status_last:=dev.status_;
           end;
        Result:=False;
        end;

        if dev.RealTimeEvents > 0 then begin
          txtOutput.Lines.Add(Format('RTE dev[0x%x]', [dev.hnd]));
          PrintRTE(dev);
        end;

        if dev.LogAvailable > 0 then begin
            txtOutput.Lines.Add(Format('LOG= %d',[dev.LogAvailable]));
            PrintLog(dev);
        end;

//        if dev.UnreadLog > 0 then begin
//          if dev.UnreadLog_last <> dev.UnreadLog then
//             dev.UnreadLog_last := dev.UnreadLog;
//             txtOutput.Lines.Add(Format('dev[%d]:LOG unread (incremental) = %d %s' , [dev.idx, dev.UnreadLog, dl_status2str(dev.status_)]));
//        end;

        if dev.TimeoutOccurred > 0 then
           txtOutput.Lines.Add(Format('TimeoutOccurred= %d',[dev.TimeoutOccurred]));


        if dev.Status <> 0 then begin
           txtOutput.Lines.Add(Format('[%d] local_status= %s' , [dev.idx, dl_status2str(dev.Status)]));
        end;

//        if dev.cmdPercent:
//           print_percent(dev.cmdPercent)



        if dev.cmdResponses <> 0 then begin
            txtOutput.Lines.Add('-- COMMAND FINISH !--');
            dev.cmd_finish := True;
        end;


        Result:=True;
end;

procedure TfrmMain.btnRTEClick(Sender: TObject);
var
    hnd,i:integer;
    maxSec:integer;
    stopTime:int64;
begin
    maxsec:=20;
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
