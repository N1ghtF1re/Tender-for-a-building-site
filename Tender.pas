unit Tender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Grids,UObjects, UWorkers, UContractors, UTender,
  Vcl.StdCtrls, AddList, USearch;

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
    mniObjList: TMenuItem;
    mniContrList: TMenuItem;
    mniWorkersList: TMenuItem;
    mniTender: TMenuItem;
    mnNewTender: TMenuItem;
    mniSaveAll: TMenuItem;
    pnlBottom: TPanel;
    btnAdd: TButton;
    mnEdit: TMenuItem;
    mniEditOn: TMenuItem;
    mniEditOff: TMenuItem;
    pnlEditOn: TPanel;
    tmrEditMode: TTimer;
    mnSearch: TMenuItem;
    mniSearchObj: TMenuItem;
    mniSearchContr: TMenuItem;
    mniSearchWorkers: TMenuItem;
    mniOpenObj: TMenuItem;
    dlgOpenFile: TOpenDialog;
    mniOpenContr: TMenuItem;
    mniOpenWorkers: TMenuItem;
    mnSort: TMenuItem;
    mniSortPrice: TMenuItem;
    mniSortSpeed: TMenuItem;
    mniExit: TMenuItem;
    function getObjHead():TObjAdr;
    procedure FormCreate(Sender: TObject);
    function getAdditionalTitle():String;
    procedure FormResize(Sender: TObject);
    procedure ListTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function getContHead():TContrAdr;
    procedure mniObjListClick(Sender: TObject);
    procedure mniContrListClick(Sender: TObject);
    procedure mniWorkersListClick(Sender: TObject);
    procedure mnNewTenderClick(Sender: TObject);
    procedure mniSaveAllClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure SetEditOff;
    procedure addNewWorkers(fio:string;obj:string;company:string; money: Currency);
    procedure addNewCompany(CompName:string);
    procedure addNewObj(obj:string; workers: Integer; money: Currency);
    procedure ListTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure mniEditOnClick(Sender: TObject);
    procedure mniEditOffClick(Sender: TObject);
    procedure tmrEditModeTimer(Sender: TObject);
    procedure editObjData(inptext:string; ACol,ARow: integer);
    procedure editContrData(inptext:string; ACol, ARow:Integer);
    procedure editWorkersData(inptext:string; ACol, ARow:integer);
    procedure mniSearchObjClick(Sender: TObject); 
    procedure SearchContr(const contrname : string; n1:byte);
    procedure mniSearchContrClick(Sender: TObject);
    procedure mniSearchWorkersClick(Sender: TObject);
    procedure SearchWorker(const fio, comp, obj:string; salary: Currency; n1,n2,n3,n4:byte);
    procedure SearchObj(obj:string; minwork: integer; money: Currency; n1,n2,n3:Byte);
    procedure mniOpenObjClick(Sender: TObject);
    procedure rewriteObjects;
    procedure mniOpenContrClick(Sender: TObject);
    procedure rewriteContractors;
    procedure mniOpenWorkersClick(Sender: TObject);
    procedure rewriteWorkers;
    procedure mniSortPriceClick(Sender: TObject);
    procedure mniSortSpeedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniExitClick(Sender: TObject);
 
  private
  public
    Mode: TMode;
    SearchMode: TMode;
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
  ObjFile,ContrFile, WorkFile:string;
  isChanged: Boolean;

implementation



{$R *.dfm}

procedure removeRow(var Grid:TStringGrid; el:integer);
var i:integer;
begin
  for I := el to Grid.RowCount-2 do
  begin
    Grid.Rows[i] := Grid.Rows[i+1];
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure saveall;
begin
  saveContrFile(ContHead, ContrFile,WorkFile);
  saveObjFile(ObjHead, ObjFile);
end;

procedure TTenderForm.addNewObj(obj:string; workers: Integer; money: Currency);
begin
  insertObjList(ObjHead, obj, workers, money);
  with TenderForm.ListTable do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := obj;
    Cells[1, RowCount-1] := IntToStr(workers);
    Cells[2, RowCount-1] := CurrToStr(money);
    Cells[3,RowCount - 1] := 'Удалить';
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
    Cells[1, RowCount-1] := 'Показать сотрудников';
    Cells[2, RowCount-1] := 'Удалить';
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
  AddListForm.ShowModal;
end;


procedure TTenderForm.FormClose(Sender: TObject; var Action: TCloseAction);
var repond: integer;
begin
  if isChanged then
  begin
    repond := MessageDlg('Вы внесли изменения. Если вы просто выйдете, они удалятся. Сохранить изменения перед выходом?',
                          mtCustom, mbYesNoCancel, 0);
    case repond of
      mrCancel: Action := caNone;
      mrYes:
      begin
        Action := caFree;
        saveall;
      end;
      mbNo: Action := caFree;
    end;


  end;
end;

procedure TTenderForm.FormCreate(Sender: TObject);
begin
  ObjFile := GetCurrentDir + '\objects.brakh';
  ContrFile := GetCurrentDir + '\contractors.brakh';
  WorkFile := GetCurrentDir + '\workers.brakh';
  createLists;
  readObjFile(ObjHead,ObjFile);
  readContrFile(ContHead, ContrFile, WorkFile);
  mode := MContrList;
  writeContrList(ListTable, ContHead);
  isChanged := false;
end;

procedure TTenderForm.FormResize(Sender: TObject);
var i:Byte;
begin
  if mode = MTender then
    mnSort.Visible := True
  else
    mnSort.Visible := false;
  if (ListTable.Cells[0,1] = 'Ничего не найдено') and (ListTable.RowCount > 2) then
    removeRow(ListTable, 1); 
  if ListTable.RowCount = 1 then
  begin
    mnEdit.Enabled := false;
    ListTable.RowCount := 2;
    ListTable.Cells[0,1] := 'Ничего не найдено';
    for I := 1 to ListTable.ColCount-1 do
      ListTable.Cells[i,1] := '';
      
  end;
  ListTable.DefaultColWidth := Trunc( pnlMain.Width / (ListTable.ColCount)) - 3;
  case mode of
    MObjList:
    begin
      pnlBottom.Visible := True;
      TenderForm.Caption := 'Список объектов';
    end;
    MContrList:
    begin
      pnlBottom.Visible := True;
      TenderForm.Caption := 'Список подрядчиков';
    end;
    MWorkList:
    begin
       pnlBottom.Visible := True;
      TenderForm.Caption := 'Список рабочих ' + additionalTitle;
    end;
    MTender:
    begin
       pnlBottom.Visible := false;
      TenderForm.Caption := 'Тендер по объекту ' + additionalTitle;
    end
    else
    begin
      TenderForm.Caption := 'Tender';
    end;
  end;
end;

procedure TTenderForm.ListTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if ARow = 0 then
  begin
    With ListTable do
    begin
      Canvas.Brush.Color := clTeal;
      Rect.Left := Rect.Left - 5;
      Canvas.FillRect(Rect);
      Canvas.Font.Color := clWhite;
      ListTable.Canvas.TextOut(Rect.Left + 5,Rect.Top+5, Cells[ACol, ARow]);  
    end;
    Canvas.Font.Color := clBlack;
  end;
  if Mode = MWorkList then
  begin
    if (ACol = 4) and (arow <> 0) and (ListTable.Cells[ACol,ARow] <> '') then   // Там хранится адрес элемента
    // Списка рабочих, закрашиваем и добавляем текст "Удалить"
    begin
      ListTable.Canvas.Brush.Color := clWhite;
      ListTable.Canvas.FillRect(Rect);
      ListTable.Canvas.TextOut(Rect.Left,Rect.Top+5,'Удалить');
    end;
  end;
end;

procedure TTenderForm.editObjData(inptext:string; ACol,ARow: integer);
var 
  name_id, objtype:string[30]; 
  minwork:integer; 
  money: Currency;
begin
  // Сохраняем исходные данные
  name_id:= ListTable.Cells[0,ARow];
  objtype := ListTable.Cells[0,ARow];
  minwork := StrToInt(ListTable.Cells[1,ARow]);
  money := StrToCurr(ListTable.Cells[2,ARow]);
  case ACol of
    0: // Меняем название объекта
    begin
      if(ObjAdrOf(ObjHead, inptext) = nil) then
      begin
        objtype := inptext;
        ListTable.Cells[ACol,ARow] := inptext;
      end
      else
        ShowMessage('Такой объект уже есть');
    end;
    1: // Меняем мин. кол-во рабочих
    begin
      try
        minwork := StrToInt(inptext);
        ListTable.Cells[ACol,ARow] := inptext;
      except on E: Exception do
        ShowMessage('Некорректный ввод')
      end;
    end;
    2: // Меняем ЗП
    begin
      try
        money := StrToCurr(inptext);
        ListTable.Cells[ACol,ARow] := inptext;
      except on E: Exception do
        ShowMessage('Некорректный ввод')
      end;
    end;          
  end;
  editObjList(ObjHead,name_id, objtype, minwork, money); // Изменяем список 
end;

procedure TTenderForm.editContrData(inptext:string; ACol, ARow:Integer);
var
  contadr : TContrAdr;
begin
  // Изменяем название компании
  if ContrAdrOf(ContHead, inptext) = nil then
  begin
    editContrList(ContHead, ListTable.Cells[0, ARow], inptext);
    ListTable.Cells[0, ARow] := inptext;
    contadr := ContrAdrOf(Conthead, inptext);
    editWorkList(contadr.WorkersHead, inptext); 
    // Изменяем название компании в полях рабочих                  
  end
  else
    ShowMessage('Такая компания уже зарегистрирована'); 
end;

procedure TTenderForm.editWorkersData(inptext: string; ACol: Integer; ARow: Integer);
var 
  intadr : integer;
  fio,company, obj:string;
  salary: Currency;
begin
  intadr := StrToInt(ListTable.Cells[4,ARow]);
  fio := ListTable.Cells[0,ARow];
  company := ListTable.Cells[1,ARow];
  salary := StrToCurr(ListTable.Cells[2,ARow]);
  obj := ListTable.Cells[3,ARow];
  case ACol of
    0: // Изменение ФИО
    begin
      fio := inptext;
      ListTable.Cells[ACol,ARow] := inptext;  
    end;
    1: // Меняем компанию
    begin
      if ContrAdrOf(ContHead, inptext) <> nil then
      begin
        company := inptext;
        // Перемещаем рабочего из прошлого элемента в списке подрядчика в новый
        removeWorkList(ContHead, intadr); 
        insertWorkListFromCompany(ContHead, company,fio, salary, obj);
        // Если мы не находимся в общем списке рабочих, то удаляем строку
        if additionalTitle <> '' then
        begin
          removeRow(ListTable,ARow); 
        end
        else
          ListTable.Cells[ACol,ARow] := inptext;
      end 
      else
          ShowMessage('Такой компании нет ;c');
    end;
    2: // Меняем ЗП
    begin
      try
        salary := StrToCurr(inptext);
        ListTable.Cells[ACol,ARow] := inptext;
      except on E: Exception do
        ShowMessage('Некорректный ввод')
      end;
    end;
    3: // Меняем объект
    begin
      if ObjAdrOf(ObjHead, inptext) <> nil then
      begin
        obj := inptext;
        ListTable.Cells[ACol,ARow] := inptext;
      end 
      else
        ShowMessage('Такого объекта не существует');
    end;
  end;
  editWorkList(ContHead, intadr, fio, company, obj, salary);
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
  // Если включен режим редактирования, изменяем поле по клику
  if (ViewMode = MEdit) and (ARow <> 0) and (ACol <> ListTable.ColCount - 1) and (ARow <> -1) then
  begin
    if (Mode <> MContrList) or (ACOL <> 1) then
    inptext :=
      InputBox('Изменить поле',
      'Введите новое значение поля ' + ListTable.Cells[ACol,0],
      ListTable.Cells[ACol, ARow]);
    inptext := Trim(inptext);
    if (ListTable.Cells[ACol, ARow] <> inptext) and (inptext <> '')  then
    begin
      isChanged := true;
      case mode of
        MObjList:
        begin
          editObjData(inptext, ACol, ARow);
        end;
        MContrList:
        begin
          editContrData(inptext, ACol, ARow);
        end;
        MWorkList:
        begin
          editWorkersData(inptext,ACol,ARow);
        end;
      end;
    end;
  end;
  if listtable.Cells[0,1] <> 'Ничего не найдено' then
  begin
    if mode = MContrList then
    begin
      if ((ARow <> 0) and (ACol = 1) and (ARow <> -1)) then
      begin
        // Переключение на список рабочих компании
        company:= ListTable.Cells[0, ARow];
        writeWorkListWithContr(ListTable, ContHead,ListTable.Cells[0, ARow]);
        additionalTitle := company;
        mode := MWorkList;
        setEditOff;
        Resize;
      end;
      if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
      begin
        if MessageDlg('Удалить ' + ListTable.Cells[0, ARow] + ' ?!' + #10#13 + 'При удалении подрядчика, будут удалены все его сотрудники',mtCustom,[mbYes,mbNo], 0) = mrYes then
        begin
          isChanged := true;
          removeContrList(ContHead, ListTable.Cells[0, ARow]);
          removeRow(ListTable, ARow);
        end;
        Resize;
      end;
    end;
    if mode = MObjList then
    begin
      if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
      begin
        if MessageDlg('Удалить ' + ListTable.Cells[0, ARow] + ' ?!' + #10#13 + 'При удалении объекта будут удалены все рабочие, которые могут строить этот объект',mtCustom,[mbYes,mbNo], 0) = mrYes then
        begin
          isChanged := true;
          removeObjList(ObjHead, ListTable.Cells[0, ARow]);
          removeWorkList(ContHead,ListTable.Cells[0, ARow]);
          removeRow(ListTable, ARow);
        end;
        Resize;
      end;
    end;
    if mode = MWorkList then
    begin
      if ((ARow <> 0) and (ACol = ListTable.ColCount-1) and (ARow <> -1)) then
      begin
        if MessageDlg('Удалить ' + ListTable.Cells[0, ARow] + ' ?!',mtCustom,[mbYes,mbNo], 0) = mrYes then
        begin
          isChanged := true;
          removeWorkList(ContHead, StrToInt(ListTable.Cells[4,ARow]));
          removeRow(ListTable, ARow);
        end;
        Resize;
      end;
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
procedure TTenderForm.rewriteContractors;
begin
  setEditOff;
  Mode := MContrList;
  writeContrList(ListTable, ContHead);
  Resize;
end;

procedure TTenderForm.mniContrListClick(Sender: TObject);
begin
  rewriteContractors;
end;


procedure TTenderForm.mniEditOffClick(Sender: TObject);
begin
  setEditOff;
end;

procedure TTenderForm.mniEditOnClick(Sender: TObject);
begin
  mniEditOn.Checked := True;
  ViewMode := MEdit;
  pnlEditOn.Visible := true;
  tmrEditMode.Enabled := True;
end;

procedure TTenderForm.mniExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TTenderForm.SetEditOff;
begin
  mnEdit.Enabled := True;
  mniEditOff.Checked := true;
  ViewMode := MView;
  pnlEditOn.Visible := false;
  tmrEditMode.Enabled := false;
end;

procedure TTenderForm.mnNewTenderClick(Sender: TObject);
var
  obj:string[30];
  tenderRes:integer;
begin
  setEditOff;
  mnEdit.Enabled := false;
  if TendHead <> nil then
    removeTender(TendHead);
  obj := InputBox('Новый тендер','По какому объекту объявить тендер?','1 Float House');
  tenderRes := newTender(N, TendHead, ObjHead, ContHead, obj);
  if (tenderRes > 0) then
  begin
    writeTendList(ListTable, TendHead);
    additionalTitle := obj;
    Mode := MTender;
  end
  else if tenderRes = 0 then
  begin
    ShowMessage('Не найдено подрядчиков для строительства заданного объекта');
  end
  else
  begin
    ShowMessage('Объект не найден');
  end;
  resize;
end;

procedure TTenderForm.mniObjListClick(Sender: TObject);
begin
  rewriteObjects;
end;

procedure TTenderForm.rewriteObjects;
begin
  setEditOff;
  writeObjList(ListTable, ObjHead);
  mode := MObjList;
  Resize;
end;

procedure TTenderForm.mniOpenContrClick(Sender: TObject);
begin
  dlgOpenFile.InitialDir := GetCurrentDir;
  dlgOpenFile.FileName := 'contractors.brakh';
  if dlgOpenFile.Execute then
  begin
      ContrFile := dlgOpenFile.FileName;
      removeAllContrList(ContHead);
      readContrFile(ContHead, ContrFile, WorkFile);
      rewriteContractors;
  end;
end;

procedure TTenderForm.mniOpenObjClick(Sender: TObject);
begin
  dlgOpenFile.InitialDir := GetCurrentDir;
  dlgOpenFile.FileName := 'objects.brakh';
  if dlgOpenFile.Execute then
  begin
      ObjFile := dlgOpenFile.FileName;
      removeAllObjList(ObjHead);
      readObjFile(ObjHead, ObjFile);
      rewriteObjects;
  end;
end;

procedure TTenderForm.mniOpenWorkersClick(Sender: TObject);
begin
  dlgOpenFile.InitialDir := GetCurrentDir;
  dlgOpenFile.FileName := 'workers.brakh';
  if dlgOpenFile.Execute then
  begin
      WorkFile := dlgOpenFile.FileName;
      removeOnlyAllWorkers(ContHead);
      readOnlyWorkers(ContHead, WorkFile);
      rewriteWorkers;
  end;
end;

procedure TTenderForm.mniSaveAllClick(Sender: TObject);
begin
  saveall;
  ShowMessage('Успешно сохранено');
end;

procedure TTenderForm.mniSearchContrClick(Sender: TObject);
begin
  SearchMode := MContrList; 
  SearchForm.ShowModal;
end;

procedure TTenderForm.mniSearchObjClick(Sender: TObject);
begin
  SearchMode := MObjList; 
  SearchForm.ShowModal;
end;

procedure TTenderForm.mniSearchWorkersClick(Sender: TObject);
begin
  SearchMode := MWorkList; 
  SearchForm.ShowModal;
end;

procedure TTenderForm.mniSortPriceClick(Sender: TObject);
begin
  sortTenders(TendHead, field3sort);
  writeTendList(ListTable, TendHead);
end;

procedure TTenderForm.mniSortSpeedClick(Sender: TObject);
begin
  sortTenders(TendHead, field2sort);
  writeTendList(ListTable, TendHead);
end;

procedure TTenderForm.rewriteWorkers;
begin
  setEditOff;
  mode := MWorkList;
  additionalTitle := '';
  writeAllWorkListWithContr(ListTable, ContHead);
  Resize;
end;

procedure TTenderForm.mniWorkersListClick(Sender: TObject);
begin
  rewriteWorkers;
end;

procedure TTenderForm.tmrEditModeTimer(Sender: TObject);
begin
  pnlEditOn.Visible := False;
end;

procedure TTenderForm.SearchObj(obj:string; minwork: integer; money: Currency; n1, n2,n3:Byte);
begin
  searchObjList(ObjHead,ListTable, obj, minwork, money, n1, n2,n3);  
  Mode := MObjList;
  resize;
end;

procedure TTenderForm.SearchContr(const contrname : string; n1:byte);
begin
  searchContrList(ContHead,ListTable, contrname, n1);  
  Mode := MContrList;
  resize;
end;

procedure TTenderForm.SearchWorker(const fio, comp, obj:string; salary: Currency; n1,n2,n3,n4:byte);
begin
  searchWorkerList(ListTable, ContHead, fio, comp, obj, salary,n1,n2,n3,n4);
  Mode := MWorkList;
  resize;
end;


end.
