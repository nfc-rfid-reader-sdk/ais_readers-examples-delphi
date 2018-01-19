unit constants;

interface

  type
    TDevice_S  = record
        idx               : integer;
        hnd               : ^Integer;
        open              : integer;
        status_           : LongInt;
        status_last       : LongInt;
        SN                : ^AnsiChar;
        ID                : integer;
        RealTimeEvents    : integer;
        LogAvailable      : integer;
        UnreadLog         : integer;
        UnreadLog_last    : integer;
        cmdResponses      : integer;
        cmdPercent        : integer;
        DeviceStatus      : integer;
        DeviceStatus_last : integer;
        TimeoutOccurred   : integer;
        Status            : integer;
        relay_state       : integer;
//        log               : S_LOG()
        cmd_finish        : boolean;
    end;


  const
     DEV_DELIMITER = ':';
     ESCAPE_DELIMITER = #10;
     INI_DEVICE_SECT  = 'DEVICES';



implementation

end.