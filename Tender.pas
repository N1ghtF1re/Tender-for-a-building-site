unit Tender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Grids,UObjects, UWorkers, UContractors, UTender;

type
  TMode = (MObjList, MContrList, MWorkList, MTender);
  TTenderForm = class(TForm)
    pnlMain: TPanel;
    mm: TMainMenu;
    mnFile: TMenuItem;
    mnLists: TMenuItem;
    ListTable: TStringGrid;
    mnObjList: TMenuItem;
    mnContrList: TMenuItem;
    mnWorkersList: TMenuItem;
    mnTender: TMenuItem;
    mnNewTender: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnObjListClick(Sender: TObject);
    procedure mnContrListClick(Sender: TObject);
    procedure mnWorkersListClick(Sender: TObject);
    procedure mnNewTenderClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  TenderForm: TTenderForm;
  ObjHead:TObjAdr;
  TendHead: TTendAdr;
  ContHead: TContrAdr;
  Mode: TMode;
  N:integer;
  additionalTitle: string;

implementation



{$R *.dfm}

procedure createLists;
begin
  New(ObjHead);
  ObjHead.Adr := nil;

  new(ContHead);
  ContHead.WorkersHead := nil;
  ContHead.Adr := nil;
end;

procedure TTenderForm.FormCreate(Sender: TObject);
begin
  createLists;
  readObjFile(ObjHead);
  readContrFile(ContHead);
  mode := MContrList;
  insertObjList(ObjHead, 'Developer', 3, 456.4);
  insertObjList(ObjHead, 'AI', 3, 456.4);
  writeContrList(ListTable, ContHead);
end;

procedure TTenderForm.FormResize(Sender: TObject);
begin
  ListTable.DefaultColWidth := Trunc( pnlMain.Width / (ListTable.ColCount)) - 3;
  case mode of
    MObjList:  TenderForm.Caption := '������ ��������';
    MContrList:  TenderForm.Caption := '������ �����������';
    MWorkList:  TenderForm.Caption := '������ ������� ' + additionalTitle;
    MTender: TenderForm.Caption := '������ �� ������� ' + additionalTitle;
    else
      TenderForm.Caption := 'Tender';
  end;
end;

procedure TTenderForm.ListTableMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  company:string[30];
begin
  ListTable.MouseToCell(X, Y, ACol, ARow);
  if mode = MContrList then
  begin
    if ((ARow <> 0) and (ACol <> 0) and (ARow <> -1)) then
    begin
      company:= ListTable.Cells[0, ARow];
      writeWorkListWithContr(ListTable, ContHead,ListTable.Cells[0, ARow]);
      //ShowMessage( ListTable.Cells[0, ARow] );
      additionalTitle := company;
      mode := MWorkList;
      Resize;
    end;
  end;
  if mode = MTender then
  begin
    if ((ARow = 0) and (ACol = 1)) then
    begin
      sortTenders(TendHead, field2sort);
      writeTendList(ListTable, TendHead);
    end;
    if ((ARow = 0) and (ACol = 2)) then
    begin
      sortTenders(TendHead, field3sort);
      writeTendList(ListTable, TendHead);
    end;
  end;
end;

procedure TTenderForm.mnContrListClick(Sender: TObject);
begin
  Mode := MContrList;
  writeContrList(ListTable, ContHead);
  Resize;
end;

procedure TTenderForm.mnNewTenderClick(Sender: TObject);
var
  obj:string[30];
  tenderRes:integer;
begin
  if TendHead <> nil then
    removeTender(TendHead);
  obj := InputBox('����� ������','�� ������ ������� �������� ������?','1 Float House');
  tenderRes := newTender(N, TendHead, ObjHead, ContHead, obj);
  if (tenderRes > 0) then
  begin
    writeTendList(ListTable, TendHead);
    additionalTitle := obj;
    resize;
    Mode := MTender;
  end
  else if tenderRes = 0 then
  begin
    ShowMessage('�� ������� ����������� ��� ������������� ��������� �������');
  end
  else
  begin
    ShowMessage('������ �� ������');
  end;
end;

procedure TTenderForm.mnObjListClick(Sender: TObject);
begin
  writeObjList(ListTable, ObjHead);
  mode := MObjList;
  Resize;
end;

procedure TTenderForm.mnWorkersListClick(Sender: TObject);
begin
  mode := MWorkList;
  additionalTitle := '';
  writeAllWorkListWithContr(ListTable, ContHead);
  Resize;
end;

end.
