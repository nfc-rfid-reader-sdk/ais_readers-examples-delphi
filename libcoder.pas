unit libcoder;

interface
uses
  constants;

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

function AIS_GetTime(hnd:integer;
                      var current_time:Int64;
                      var timezone:integer;
                      var DST:integer;
                      var offset:integer;
                      var additional:Byte):DL_STATUS stdcall;

function AIS_SetTime(hnd:integer;
                     password:PAnsiChar;
                     timeToSet:Int64;
                     timezone:integer;
                     DST:integer;
                     offset:integer;
                     additional:byte):DL_STATUS stdcall;

function AIS_MainLoop(hnd:integer;
                      var RealTimeEvents:integer;
                      var LogAvailable:integer;
                      var LogUnread:integer;
                      var cmdResponses:integer;
                      var cmdPercent:integer;
                      var DeviceStatus:integer;
                      var TimeoutOccurred:integer;
                      var Status:integer):DL_STATUS stdcall;

function AIS_ReadRTE(hnd:integer;
                     var log_index:Integer;
		                 var log_action:integer;
	                   var log_reader_id:integer;
                     var log_card_id:integer;
		                 var log_system_id:integer;
        		         nfc_uid:PByte;
                		 var nfc_uid_len:integer;
		                 var timestamp:Int64):DL_STATUS stdcall;

function AIS_ReadLog(hnd:integer;
                     var log_index:integer;
		                 var log_action:integer;
	                   var log_reader_id:integer;
                     var log_card_id:integer;
		                 var log_system_id:integer;
        		         nfc_uid:PByte;
                		 var nfc_uid_len:integer;
		                 var timestamp:Int64):DL_STATUS stdcall;


function AIS_ReadRTE_Count(hnd:integer):DL_STATUS stdcall;
function AIS_ReadLog_Count(hnd:integer):DL_STATUS stdcall;



function AIS_GetLog(hnd:integer; pass:PAnsiChar):DL_STATUS stdcall;
function AIS_GetLogByIndex(hnd:integer;
                           pass:PAnsiChar;
                           start_index:Int32;
                           end_index:Int32):DL_STATUS stdcall;

function AIS_GetLogByTime(hnd:integer;
                          pass:PAnsiChar;
                          start_time:Int64;
                          end_time:Int64):DL_STATUS stdcall;

function AIS_UnreadLOG_Get(hnd:integer;
                           var log_index:integer;
                           var log_action:integer;
                           var log_reader_id:integer;
                           var log_card_id:integer;
		                       var log_system_id:integer;
        		               nfc_uid:PByte;
                		       var nfc_uid_len:integer;
		                       var timestamp:Int64):DL_STATUS stdcall;

function AIS_UnreadLOG_Ack(hnd:integer; rec_to_ack:Int32):DL_STATUS stdcall;
function AIS_LightControl(hnd:integer;
                          green_master:int32;
                          red_master:int32;
                          green_slave:int32;
                          red_slave:int32):DL_STATUS stdcall;

{helper functions}
function device_type_str2enum(devTypeStr:ansistring; var devType:integer):DL_STATUS stdcall;
function device_type_enum2str(devType:integer; var devTypeStr:PAnsiChar):DL_STATUS stdcall;
function dl_status2str(status:DL_STATUS):PAnsiChar stdcall;
function sys_get_timezone_info:PAnsiChar stdcall;
function sys_get_timezone:LongInt stdcall;
function sys_get_daylight:integer stdcall;
function sys_get_dstbias:LongInt stdcall;
function dbg_action2str(actionValue:integer):PAnsiChar stdcall;

implementation

  function AIS_GetLibraryVersionStr; external DLL_NAME;
  function AIS_List_EraseAllDevicesForCheck; external DLL_NAME;
  function AIS_List_AddDeviceForCheck; external DLL_NAME;
  function AIS_List_GetDevicesForCheck; external DLL_NAME;
  function AIS_List_UpdateAndGetCount; external DLL_NAME;
  function AIS_List_GetInformation; external DLL_NAME;
  function AIS_Open; external DLL_NAME;
  function AIS_Close; external DLL_NAME;
  function AIS_GetTime; external DLL_NAME;
  function AIS_SetTime; external DLL_NAME;
  function AIS_MainLoop;external DLL_NAME;
  function AIS_ReadRTE;external DLL_NAME;
  function AIS_ReadRTE_Count;external DLL_NAME;
  function AIS_ReadLog_Count;external DLL_NAME;
  function AIS_ReadLog;external DLL_NAME;
  function AIS_GetLog;external DLL_NAME;
  function AIS_GetLogByIndex;external DLL_NAME;
  function AIS_GetLogByTime;external DLL_NAME;
  function AIS_UnreadLOG_Get;external DLL_NAME;
  function AIS_UnreadLOG_Ack;external DLL_NAME;
  function AIS_LightControl;external DLL_NAME;

  {helper functions}
  function device_type_str2enum;external DLL_NAME;
  function device_type_enum2str;external DLL_NAME;
  function dl_status2str;external DLL_NAME;
  function sys_get_timezone_info;external DLL_NAME;
  function sys_get_timezone;external DLL_NAME;
  function sys_get_daylight;external DLL_NAME;
  function sys_get_dstbias;external DLL_NAME;
  function dbg_action2str;external DLL_NAME;



end.
