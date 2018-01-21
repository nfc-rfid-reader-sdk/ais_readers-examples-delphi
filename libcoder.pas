unit libcoder;

interface


type
  DL_STATUS = LongInt;

const
     {$IfDef win32}
        DLL_NAME = '.\\lib\\windows\\x86\\ais_readers-x86.dll';
     {$Else}
        DLL_NAME = '.\\lib\\windows\\x86_64\\ais_readers-x86_64.dll';
     {$EndIf}


function AIS_GetLibraryVersionStr:PAnsiChar stdcall;
function AIS_List_EraseAllDevicesForCheck:DL_STATUS stdcall;
function AIS_List_AddDeviceForCheck(devType, devId:integer):DL_STATUS stdcall;
function AIS_List_GetDevicesForCheck:PAnsiChar stdcall;
function AIS_List_UpdateAndGetCount(var devCount:integer):DL_STATUS stdcall;
function AIS_List_GetInformation(var devHnd:integer;
                                 var devSerial:PAnsiChar;
                                 var devType:integer;
                                 var devID:integer;
                                 var devFW_VER:integer;
                                 var devComSpeed:integer;
                                 var devFTDI_Serial:PAnsiChar;
                                 var devOpened:integer;
                                 var devStatus:integer;
                                 var sysStatus:integer):DL_STATUS stdcall;
function AIS_Open(hnd:integer):DL_STATUS stdcall;
function AIS_Close(hnd:integer):DL_STATUS stdcall;


{helper functions}
function device_type_str2enum(devTypeStr:ansistring; var devType:integer):DL_STATUS stdcall;
function device_type_enum2str(devType:integer; var devTypeStr:PAnsiChar):DL_STATUS stdcall;
function dl_status2str(status:DL_STATUS):PAnsiChar stdcall;

implementation

  function AIS_GetLibraryVersionStr; external DLL_NAME;
  function AIS_List_EraseAllDevicesForCheck; external DLL_NAME;
  function AIS_List_AddDeviceForCheck; external DLL_NAME;
  function AIS_List_GetDevicesForCheck; external DLL_NAME;
  function AIS_List_UpdateAndGetCount; external DLL_NAME;
  function AIS_List_GetInformation; external DLL_NAME;
  function AIS_Open; external DLL_NAME;
  function AIS_Close; external DLL_NAME;

  {helper functions}
  function device_type_str2enum;external DLL_NAME;
  function device_type_enum2str;external DLL_NAME;
  function dl_status2str;external DLL_NAME;


end.
