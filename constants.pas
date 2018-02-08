unit constants;

interface

 const
   NFC_UID_MAX_LEN  = 10;


  type
    TS_PROGRESS = record
        print_hdr :Boolean;
        percent_old : integer;
    end;


  type
      TS_LOG = record
        log_index:integer;
        log_action:integer;
        log_reader_id:integer;
        log_card_id:integer;
        log_system_id:integer;
        log_nfc_uid:array[0..NFC_UID_MAX_LEN] of Byte;
        log_nfc_uid_len:integer;
        log_timestamp:Int64;
      end;

  type
    TDevice_S  = record
        idx               : integer;
        hnd               : Integer;
        open              : integer;
        status_           : LongInt;
        status_last       : LongInt;
        SN                : PAnsiChar;
        dev_Type          : integer;
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
        log               : TS_LOG;
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
       RECORDS_TO_ACK   = 1;

  format_grid:array[0..2] of ShortString = ('----------------------------------------------------------------------------------------------------------------------------------------------------------',
                                            '| indx|  Reader HANDLE   | SerialNm | Type h/d | ID  | FW   | speed   | FTDI: sn   | opened | DevStatus | SysStatus |',
                                            '----------------------------------------------------------------------------------------------------------------------------------------------------------');


  rte_list_header:array[0..2] of ShortString = ('--------------------------------------------------------------------------------------------------------------------------------------------------------------------',
                                                '| Idx   |              action              | RD ID | Card ID | JobNr |    NFC [length] : UID    | Time-stamp |       Date - Time        |',
                                                '--------------------------------------------------------------------------------------------------------------------------------------------------------------------');

  const
  list_info :shortstring = '| %3d | %.16X | %s  | %7d  | %2d  | %d   | %7d  | %s  | %5d  | %8d  | %9d | ';
  rte_format:shortstring = '| %5d | %28s  | %5d | %7d  | %5d  | %24s | %10d | %7s | ';

implementation

end.
