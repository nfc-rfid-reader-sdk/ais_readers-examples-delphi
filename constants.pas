unit constants;

interface

  type
    TDevice_S  = record
        idx               : integer;
        hnd               : Integer;
        open              : integer;
        status_           : LongInt;
        status_last       : LongInt;
        SN                : PAnsiChar;
        dev_Type           : integer;
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

  const
       INI_DELIMITER    = '=';
       INI_FILE_NAME    = 'readers.ini';
       INI_DEVICE_SECT  = 'DEVICES';

  const
       DL_OK            = 0;
       PASS             = '1111';

  format_grid:array[0..2] of ShortString = ('------------------------------------------------------------------------------------------------------------------------------------------',
                                           '| indx|  Reader HANDLE   | SerialNm | Type h/d | ID  | FW   | speed   | FTDI: sn   | opened | DevStatus | SysStatus |',
                                           '------------------------------------------------------------------------------------------------------------------------------------------');

implementation

end.
