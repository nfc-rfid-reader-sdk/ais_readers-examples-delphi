unit main;

{
 ver 1.0.4;
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
    procedure btnLibVersionClick(Sender: TObject);
    procedure btnGetRunClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnGetTimeClick(Sender: TObject);
    procedure btnSetTimeClick(Sender: TObject);
  private
    dev:DEV_HND;
    HND_LIST:array of integer;
    procedure prepare_list_for_check;
    function list_for_check_print: string;
    function load_list_from_file:boolean;
    function list_device():integer;    //dev:TDevice_S
    function add_device(devType, devId:integer):boolean;
    function GetListInformation:string;

  public
    function AISGetTime(dev:DEV_HND):integer;
    function AISSetTime(dev:DEV_HND):string;
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

function TfrmMain.AISGetTime(dev:DEV_HND): integer;
var
  currTime : Int64;
  timezone,
  DST,
  offset   : integer;
  additional :Byte;
begin
//  dev.idx :=cboDevices.ItemIndex;
//  dev.hnd:=HND_LIST[dev.idx];
  dev.status_:=AIS_GetTime(dev.hnd, currTime, timezone, DST, offset, additional);
  txtOutput.Lines.Add(format('AIS_GetTime(dev[%d] hnd=%x)> status=%d (tz= %d | DST= %d | offset= %d | additional= %d | %d | %s)' , [dev.idx + 1, dev.hnd, dev.status,timezone, DST, offset, additional, currTime, DateTimeToStr(UnixToDateTime(currTime))]));

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
begin
  dev.idx :=cboDevices.ItemIndex;
  dev.hnd:=HND_LIST[dev.idx];
  AISGetTime(dev);
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
             txtOutput.Lines.Add(format('| %3d | %.16X | %s | %7d  | %2d  | %d  | %7d | %s | %5d  | %8d  | %9d | ', [i+1, devHnd, devSerial, devType, devID, devFW_VER, devCommSpeed, devFTDI_Serial, devOpened,devStatus, systemStatus]));
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

end.
