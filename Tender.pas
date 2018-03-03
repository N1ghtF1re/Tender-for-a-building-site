unit Tender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Grids,UObjects, UWorkers, UContractors, UTender,
  Vcl.StdCtrls, AddList;

type
  TMode = (MObjList, MContrList, MWorkList, MTender);
  TViewMode = (MView, MEdit);
  //TEdm = (madd, medit);
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
    mnSaveAll: TMenuItem;
    pnlBottom: TPanel;
    btnAdd: TButton;
    mnEdit: TMenuItem;
    mnEditOn: TMenuItem;
    mnEditOff: TMenuItem;
    pnlEditOn: TPanel;
    tmrEditMode: TTimer;
    function getObjHead():TObjAdr;
    procedure FormCreate(Sender: TObject);
    function getAdditionalTitle():String;
    procedure FormResize(Sender: TObject);
    procedure ListTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function getContHead():TContrAdr;
    procedure mnObjListClick(Sender: TObject);
    procedure mnContrListClick(Sender: TObject);
    procedure mnWorkersListClick(Sender: TObject);
    procedure mnNewTenderClick(Sender: TObject);
    procedure mnSaveAllClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure addNewWorkers(fio:string;obj:string;company:string; money: Currency);
    procedure addNewCompany(CompName:string);
    procedure addNewObj(obj:string; workers: Integer; money: Currency);
    procedure ListTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure mnEditOnClick(Sender: TObject);
    procedure mnEditOffClick(Sender: TObject);
    procedure tmrEditModeTimer(Sender: TObject);
  private
  public
    Mode: TMode;
    //edm: TEdm;
    { Public declarations }
  end;

var
  TenderForm: TTenderForm;
  ViewMode: TViewMode;
  ObjHead:TObjAdr;
  TendHead: TTendAdr;
  ContHead: TContrAdr;
  N:integer;
  additionalTitle: string;

implementation



{$R *.dfm}

procedure TTenderForm.addNewObj(obj:string; workers: Integer; money: Currency);
begin
  insertObjList(ObjHead, obj, workers, money);
  with TenderForm.ListTable do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := obj;
    Cells[1, RowCount-1] := IntToStr(workers);
    Cells[2, RowCount-1] := CurrToStr(money);
    Cells[3,RowCount - 1] := '�������';
    Resize;
  end;
end;

function TTenderForm.getAdditionalTitle():String;
begin
  result := additionalTitle;
end;

procedure TTenderForm.addNewWorkers(fio:string;obj:string;company:string; money: Currency);
var
  intadr:integer;
begin
  intadr := insertWorkListFromCompany(ContHead, company,fio,money, obj);
  with TenderForm.ListTable do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := fio;
    Cells[1, RowCount-1] := company;
    Cells[2, RowCount-1] := CurrToStr(money);
    Cells[3, RowCount-1] := obj;
    Cells[4, RowCount-1] := IntToStr(intadr);
    Resize;
  end;
end;

procedure TTenderForm.addNewCompany(CompName:string);
begin
  insertContrList(ContHead, CompName);
  with TenderForm.ListTable do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := CompName;
    Cells[1, RowCount-1] := '�������� �����������';
    Cells[2, RowCount-1] := '�������';
    Resize;
  end;
end;

function TTenderForm.getObjHead():TObjAdr;
begin
  Result := ObjHead;
end;

function TTenderForm.getContHead():TContrAdr;
begin
  Result := ContHead;
end;

procedure createLists;
begin
  New(ObjHead);
  ObjHead.Adr := nil;

  new(ContHead);
  ContHead.WorkersHead := nil;
  ContHead.Adr := nil;
end;

procedure TTenderForm.btnAddClick(Sender: TObject);
begin
  //Edm := Madd;
  AddListForm.ShowModal;
end;


procedure TTenderForm.FormCreate(Sender: TObject);
begin
  createLists;
  readObjFile(ObjHead);
  readContrFile(ContHead);
  mode := MContrList;
//  insertObjList(ObjHead, 'Developer', 3, 456.4);
//  insertWorkListFromCompany(ContHead, 'HorusMen', 'Lucik', 342312.5, 'Developer');
//  insertObjList(ObjHead, 'AI', 3, 456.4);
  writeContrList(ListTable, ContHead);
end;

procedure TTenderForm.FormResize(Sender: TObject);
begin
  ListTable.DefaultColWidth := Trunc( pnlMain.Width / (ListTable.ColCount)) - 3;
  case mode of
    MObjList:
    begin
      pnlBottom.Visible := True;
      TenderForm.Caption := '������ ��������';
    end;
    MContrList:
    begin
      pnlBottom.Visible := True;
      TenderForm.Caption := '������ �����������';
    end;
    MWorkList:
    begin
       pnlBottom.Visible := True;
      TenderForm.Caption := '������ ������� ' + additionalTitle;
    end;
    MTender:
    begin
       pnlBottom.Visible := false;
      TenderForm.Caption := '������ �� ������� ' + additionalTitle;
    end
    else
    begin
      TenderForm.Caption := 'Tender';
    end;
  end;
end;

procedure removeRow(var Grid:TStringGrid; el:integer);
var i:integer;
begin
  for I := el to Grid.RowCount-2 do
  begin
    Grid.Rows[i] := Grid.Rows[i+1];
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure TTenderForm.ListTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if Mode = MWorkList then
  begin
    if (ACol = 4) and (arow <> 0) then
    begin
      ListTable.Canvas.Brush.Color := clWhite;
      ListTable.Canvas.FillRect(Rect);
      ListTable.Canvas.TextOut(Rect.Left,Rect.Top+5,'�������');
    end;
  end;
end;

procedure TTenderForm.ListTableMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
  company:string[30];
  comname:string[30];
  inptext:string[30];
begin
  ListTable.MouseToCell(X, Y, ACol, ARow);
  if mode = MContrList then
  begin
    if ViewMode = MEdit then
    begin
      if ((ARow <> 0) and (ACol = 0) and (ARow <> -1)) then
      begin
        comname := InputBox('�������� ����','������� �������� ���������� ',ListTable.Cells[0, ARow]);
        comname := Trim(comname);
        if (ListTable.Cells[0, ARow] <> comname) and (Trim(comname) <> '') then
        begin
          if ContrAdrOf(ContHead, comname) = nil then
          begin
            editContrList(ContHead, ListTable.Cells[0, ARow], comname);
            ListTable.Cells[0, ARow] := comname;
          end
          else
            ShowMessage('����� �������� ��� ����������������');
        end;
      end;
    end;
    if ((ARow <> 0) and (ACol = 1) and (ARow <> -1)) then
    begin
      company:= ListTable.Cells[0, ARow];
      writeWorkListWithContr(ListTable, ContHead,ListTable.Cells[0, ARow]);
      //ShowMessage( ListTable.Cells[0, ARow] );
      additionalTitle := company;
      mode := MWorkList;
      mnEditOff.Checked := true;
      mnEdit.Enabled := true;
      ViewMode := MView;
      pnlEditOn.Visible := false;
      tmrEditMode.Enabled := false;
      Resize;
    end;
    if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
    begin
      if MessageDlg('������� ' + ListTable.Cells[0, ARow] + ' ?!',mtCustom,[mbYes,mbNo], 0) = mrYes then
      begin
        removeContrList(ContHead, ListTable.Cells[0, ARow]);
        removeRow(ListTable, ARow);
      end;
      Resize;
    end;
  end;
  if mode = MObjList then
  begin
    if ViewMode = MEdit then
    begin
      if ((ARow <> 0) and (ACol = 0) and (ARow <> -1)) then
      begin
        comname := InputBox('�������� ����','������� �������� ������� ',ListTable.Cells[0, ARow]);
        comname := Trim(comname);
        if (ListTable.Cells[0, ARow] <> comname) and (comname <> '')  then
        begin
          if (ObjAdrOf(ObjHead, comname) = nil) then
          begin
            // ShowMessage('kek');
            editObjList(ObjHead, ListTable.Cells[0, ARow], comname, StrToInt(ListTable.Cells[1, ARow]),StrToCurr(ListTable.Cells[2, ARow]));
            ListTable.Cells[0, ARow] := comname;
          end
          else
            ShowMessage('����� ������ ��� ����');
        end;
      end;
      if ((ARow <> 0) and (ACol = 1) and (ARow <> -1)) then
      begin
        inptext := InputBox('�������� ����','������� ���������� ������� ',ListTable.Cells[ACol, ARow]);
        if ListTable.Cells[0, ARow] <> comname then
        begin
          try
            // ShowMessage('kek');
            with ListTable do
            begin
              editObjList(ObjHead,Cells[0, ARow], Cells[0, ARow], StrToInt(inptext),StrToCurr(Cells[2, ARow]));
              Cells[ACol, ARow] := inptext;
            end;
          except on E: Exception do
            ShowMessage('������������ ����')
          end;
        end;
      end;
      if ((ARow <> 0) and (ACol = 2) and (ARow <> -1)) then
      begin
        inptext := InputBox('�������� ����','������� ����� ���� ���������� ',ListTable.Cells[ACol, ARow]);
        if ListTable.Cells[0, ARow] <> comname then
        begin
          try
            // ShowMessage('kek');
            with ListTable do
            begin
              editObjList(ObjHead,Cells[0, ARow], Cells[0, ARow], StrToInt(ListTable.Cells[1, ARow]),StrToCurr(inptext));
              Cells[ACol, ARow] := inptext;
            end;
          except on E: Exception do
            ShowMessage('������������ ����')
          end;
        end;
      end;
    end;
    if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
    begin
      if MessageDlg('������� ' + ListTable.Cells[0, ARow] + ' ?!',mtCustom,[mbYes,mbNo], 0) = mrYes then
      begin
        removeObjList(ObjHead, ListTable.Cells[0, ARow]);
        removeRow(ListTable, ARow);
      end;
      Resize;
    end;
  end;
  if mode = MWorkList then
  begin
    if ViewMode = MEdit then
    begin
      if ((ARow <> 0) and (ACol = 0) and (ARow <> -1)) then
      begin
        inptext := InputBox('�������� ����','������� ����� ��� ��������',ListTable.Cells[ACol, ARow]);
        inptext := Trim(inptext);
        if (ListTable.Cells[0, ARow] <> inptext) and (inptext <> '')  then
        begin
          with ListTable do
          begin
            editWorkList(ContHead, StrToInt(Cells[4,arow]), inptext, Cells[1,ARow], Cells[3,ARow], StrToCurr(Cells[2,ARow]) );
            Cells[ACol,ARow] := inptext;
          end;
        end;
      end;
      if ((ARow <> 0) and (ACol = 1) and (ARow <> -1)) then
      begin
        inptext := InputBox('�������� ����','������� ����� �������� ��������',ListTable.Cells[ACol, ARow]);
        inptext := Trim(inptext);
        if ContrAdrOf(ContHead, inptext) <> nil then
        begin
          if (ListTable.Cells[0, ARow] <> inptext) and (inptext <> '')  then
          begin
            with ListTable do
            begin
              editWorkList(ContHead, StrToInt(Cells[4,arow]), Cells[0,ARow], inptext, Cells[3,ARow], StrToCurr(Cells[2,ARow]) );
              removeWorkList(ContHead, StrToInt(Cells[4,ARow]));
              if additionalTitle <> inptext then
              begin
                removeRow(ListTable,ARow);
                insertWorkListFromCompany(ContHead, inptext,Cells[0,ARow], StrToCurr(Cells[2,ARow]), Cells[3,ARow]);
              end
              else
                Cells[ACol,ARow] := inptext;
            end;
          end;
        end
        else
          ShowMessage('����� �������� ��� ;c');
      end;
    end;
    if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
    begin
      if MessageDlg('������� ' + ListTable.Cells[0, ARow] + ' ?!',mtCustom,[mbYes,mbNo], 0) = mrYes then
      begin
        removeWorkList(ContHead, StrToInt(ListTable.Cells[4,ARow]));
        removeRow(ListTable, ARow);
      end;
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
  mnEditOff.Checked := true;
  mnEdit.Enabled := true;
  ViewMode := MView;
  Mode := MContrList;
  writeContrList(ListTable, ContHead);
  Resize;
end;

procedure TTenderForm.mnEditOffClick(Sender: TObject);
begin
  mnEditOff.Checked := true;
  ViewMode := MView;
  pnlEditOn.Visible := false;
  tmrEditMode.Enabled := false;
end;

procedure TTenderForm.mnEditOnClick(Sender: TObject);
begin
  mnEditOn.Checked := True;
  ViewMode := MEdit;
  pnlEditOn.Visible := true;
  tmrEditMode.Enabled := True;
end;

procedure TTenderForm.mnNewTenderClick(Sender: TObject);
var
  obj:string[30];
  tenderRes:integer;
begin
  mnEdit.Enabled := false;
  if TendHead <> nil then
    removeTender(TendHead);
  obj := InputBox('����� ������','�� ������ ������� �������� ������?','1 Float House');
  tenderRes := newTender(N, TendHead, ObjHead, ContHead, obj);
  if (tenderRes > 0) then
  begin
    writeTendList(ListTable, TendHead);
    additionalTitle := obj;
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
  resize;
end;

procedure TTenderForm.mnObjListClick(Sender: TObject);
begin
  mnEditOff.Checked := true;
  mnEdit.Enabled := true;
  ViewMode := MView;
  writeObjList(ListTable, ObjHead);
  mode := MObjList;
  Resize;
  pnlEditOn.Visible := false;
  tmrEditMode.Enabled := false;
end;

procedure TTenderForm.mnSaveAllClick(Sender: TObject);
begin
  saveContrFile(ContHead);
  saveObjFile(ObjHead);
  ShowMessage('������� ���������');
end;

procedure TTenderForm.mnWorkersListClick(Sender: TObject);
begin
  mode := MWorkList;
  mnEdit.Enabled := true;
  mnEditOff.Checked := true;
  ViewMode := MView;
  additionalTitle := '';
  writeAllWorkListWithContr(ListTable, ContHead);
  Resize;
  pnlEditOn.Visible := false;
  tmrEditMode.Enabled := false;
end;

procedure TTenderForm.tmrEditModeTimer(Sender: TObject);
begin
  pnlEditOn.Visible := False;
end;

end.
