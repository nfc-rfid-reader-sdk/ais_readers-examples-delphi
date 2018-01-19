unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnGetRunClick(Sender: TObject);
begin
    with txtOutput.Lines do begin
       Add(AIS_GetLibraryVersionStr);
       Add(format('AIS_List_EraseAllDevicesForCheck() = %d', [AIS_List_EraseAllDevicesForCheck]));
       Add(format('AIS_List_AddDeviceForCheck() = %d', [AIS_List_AddDeviceForCheck(11, 16)]));
       Add(format('AIS_List_GetDevicesForCheck = %s', [AIS_List_GetDevicesForCheck]));
    end;
end;

procedure TfrmMain.btnLibVersionClick(Sender: TObject);
begin
   txtOutput.Lines.Add(AIS_GetLibraryVersionStr);

end;

end.
