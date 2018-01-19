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


implementation

  function AIS_GetLibraryVersionStr; external DLL_NAME;
  function AIS_List_EraseAllDevicesForCheck; external DLL_NAME;
  function AIS_List_AddDeviceForCheck; external DLL_NAME;
  function AIS_List_GetDevicesForCheck; external DLL_NAME;

end.
