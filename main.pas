unit main;

{
 ver 1.0.2;
}


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,System.Types, System.StrUtils,
  System.IniFiles,
  constants,
  libcoder,
  functions;

type
  TfrmMain = class(TForm)
    grpBaseCommands: TGroupBox;
    stbStatus: TStatusBar;
    txtOutput: TMemo;
    btnLibVersion: TButton;
    btnGetRun: TButton;
    procedure btnLibVersionClick(Sender: TObject);
    procedure btnGetRunClick(Sender: TObject);
  private
    procedure prepare_list_for_check;
    function list_for_check_print: string;
    function load_list_from_file:boolean;
    function list_device():integer;    //dev:TDevice_S
    function add_device(devType, devId:integer):boolean;
  public
    { Public declarations }
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

procedure TfrmMain.btnGetRunClick(Sender: TObject);
begin
    txtOutput.Lines.Add(AIS_GetLibraryVersionStr);
    list_device();
end;

procedure TfrmMain.btnLibVersionClick(Sender: TObject);
begin
   txtOutput.Lines.Add(AIS_GetLibraryVersionStr);

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
begin
     prepare_list_for_check;
     txtOutput.Lines.Add('checking...please wait...');

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
   devIni:TIniFile;
   addedDevType,
   devTypeEnum :integer;
   devValues:TStringList;
   arrv,ll:TStringDynArray;
   s:string;
begin
   GetCurrentDir;
   devIni:=TIniFile.Create('readers.ini');
   try
     try
      devValues:=TStringList.Create;
      devIni.ReadSectionValues(INI_DEVICE_SECT, devValues);

      showmessage(IntToStr(devValues.Count));


      Result:=True;

     except
      on E:Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
     end;

   finally
     devIni.Free;
     devValues.Free;
   end;

end;

end.
