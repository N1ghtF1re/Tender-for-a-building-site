unit Tender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Grids,UObjects, UWorkers, UContractors, UTender;

type
  TMode = (ObjList, ContrList, WorkList);
  TTenderForm = class(TForm)
    pnlMain: TPanel;
    mm: TMainMenu;
    mnFile: TMenuItem;
    mnLists: TMenuItem;
    ListTable: TStringGrid;
    mnObjList: TMenuItem;
    mnContrList: TMenuItem;
    mnWorkersList: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnObjListClick(Sender: TObject);
    procedure mnContrListClick(Sender: TObject);
    procedure mnWorkersListClick(Sender: TObject);
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
  mode := ContrList;
  writeContrList(ListTable, ContHead);
end;

procedure TTenderForm.FormResize(Sender: TObject);
begin
  ListTable.DefaultColWidth := Trunc( pnlMain.Width / (ListTable.ColCount)) - 3;
end;

procedure TTenderForm.ListTableMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
begin
  if mode = ContrList then
  begin
    ListTable.MouseToCell(X, Y, ACol, ARow);
    if ((ARow <> 0) and (ACol <> 0) and (ARow <> -1)) then
    begin
      writeWorkListWithContr(ListTable, ContHead,ListTable.Cells[0, ARow]);
      //ShowMessage( ListTable.Cells[0, ARow] );
      Resize;
    end;
  end;
end;

procedure TTenderForm.mnContrListClick(Sender: TObject);
begin
  Mode := ContrList;
  writeContrList(ListTable, ContHead);
end;

procedure TTenderForm.mnObjListClick(Sender: TObject);
begin
  writeObjList(ListTable, ObjHead);
  mode := ObjList;
end;

procedure TTenderForm.mnWorkersListClick(Sender: TObject);
begin
  mode := WorkList;
  writeAllWorkListWithContr(ListTable, ContHead);
end;

end.