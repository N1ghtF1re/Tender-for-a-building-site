{*******************************************************}
{       OBJECTS LIBRARY                                 }
{       Lab №2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UObjects;

interface
uses
  Vcl.Forms,Vcl.Grids, Vcl.Graphics,Vcl.Dialogs, Vcl.StdCtrls;
type
  TObjTypes = (house = 0, building = 1, Railway = 2, road = 3, objNone);
  { *** СПИСОК ОБЪЕКТОВ НАЧАЛО *** }
  TObjInfo = record    // Блок информации
    name: String[30];
    obType:TObjTypes;  // Тип объекта
    Workers:integer;    // Минимальное количество рабочих
    MatCost:Currency;   // Стоимость материалов
  end;
  TObjAdr = ^TObjList; // Ссылка на Список Объектов
  TObjList = record    // Список Объектов
    Info: TObjInfo;
    Adr: TObjAdr;
  end;
  { *** СПИСОК ОБЪЕКТОВ КОНЕЦ  *** }

// ПРОЦЕДУРЫ И ФУНКЦИИ
function writeObjType(ob: TObjTypes):string;
procedure getCBBObjectsList(CBB: TComboBox; const head: TObjAdr);
procedure readObjFile(const head:TObjAdr; ObjFile:string);
procedure saveObjFile(const head:TObjAdr; ObjFile:string);
procedure removeObjList(var head:TObjAdr; const el:string);
procedure insertObjList(const head: TObjAdr; name: string; tp:TObjTypes ; wk:integer = 0; mc:Currency = 0);
procedure writeObjList(Grid:TStringGrid; const head:TObjAdr);
function ObjAdrOfName(head: TObjAdr; name: string):TObjAdr;
procedure editObjList(head:TObjAdr; name:string; newname:string; newtype: TObjTypes; newwork: integer; newmoney: Currency );
procedure searchObjList(head:TObjAdr;Grid:TStringGrid;obj:string; minwork: integer; money: Currency; objtype: TObjTypes; n1,n2,n3:integer);
procedure removeAllObjList(head:TObjAdr);
function compareType(t: string):boolean;
function getObjType(t:string):TObjTypes;

implementation
uses
 System.SysUtils, tender;

//const
    //ObjFile = 'objects.brakh'; // Файл объектов

{ Функция ObjAdrOf возвращает адрес элемента списка с нужным полем name
  Если значение не найдено, возвращается nil }

function ObjAdrOfName(head: TObjAdr; name: string):TObjAdr;
var
  temp: TObjAdr;
begin
  temp := head;
  Result := nil;
  while(temp <> nil) do
  begin
    //ShowMessage(name + ' / ' + temp^.Info.obType);
    if temp^.Info.name = name then
      Result:=temp;
    temp := temp^.Adr;
  end;

end;


{ Процедура readObjFile читает  типизированный файл, если его нет, создает его
и заполняет список объектов из файла }

procedure readObjFile(const head:TObjAdr; ObjFile:string);
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    //ShowMessage(objfile);
    //Writeln('Read file ' + ObjFile);
    OTemp := Head;
    head^.Adr := nil;
    while not EOF(f) do
    begin
      new(OTemp^.adr);
      OTemp:=OTemp^.adr;
      OTemp^.adr:=nil;

      read(f, OTemp^.Info);
      //ShowMessage(otemp^.Info.obType);
      //OTemp^.Info

    end;
    close(f);
  end
  else
  begin
    Rewrite(f);
    //Writeln('Create File');
    close(f);
  end;

end;

// Сохранения списка в типизированный файл }
procedure saveObjFile(const head:TObjAdr; ObjFile:string);
var
  f: file of TObjInfo;
  temp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  rewrite(f);
  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    temp:=temp^.adr;
  end;
  close(F);
end;

{ Вставка элемента в конец списка}
procedure insertObjList(const head: TObjAdr; name: string; tp:TObjTypes ; wk:integer = 0; mc:Currency = 0);
var
  temp:TObjAdr;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Info.name := name;
  temp^.Info.obType := tp;
  temp^.Info.Workers := wk;
  temp^.Info.MatCost := mc;
end;

function compareType(t: string):boolean;
begin
  if t = 'Дом' then
    Result:= true
  else if t = 'Здание' then
    Result:= true
  else if t = 'Железная дорога' then
    Result:= true
  else if t = 'Дорога' then
    Result:= true
  else
    Result:= false;

end;

function getObjType(t:string):TObjTypes;
begin
  if t = 'Дом' then
    Result:= house
  else if t = 'Здание' then
    Result:= building
  else if t = 'Железная дорога' then
    Result:= Railway
  else if t = 'Дорога' then
    Result:= road

end;

function writeObjType(ob: TObjTypes):string;
begin
  case ob of
    house: Result := 'Дом';
    building: Result := 'Здание' ;
    Railway: Result := 'Железная дорога';
    road: Result:= 'Дорога';
  end;
end;

procedure writeObjList(Grid:TStringGrid; const head:TObjAdr);
var
  temp:TObjAdr;
begin
  Grid.ColCount := 5;
  Grid.RowCount := 2;
  Grid.Font.Color:= clWhite;
  Grid.Cells[0,0] := 'Название объекта';
  Grid.Cells[1,0] := 'Тип объекта';
  Grid.Cells[2,0] := 'Мин. кол-во рабочих';
  Grid.Cells[3,0] := 'Стоимость материалов';
  Grid.Font.Color:= clBlack;
  //ShowMessage('kek');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.name;
    Grid.Cells[1,Grid.RowCount - 1] := writeObjType(temp^.INFO.obType);
    Grid.Cells[2,Grid.RowCount - 1] := IntToStr(temp^.INFO.Workers);
    Grid.Cells[3,Grid.RowCount - 1] := CurrToStr(temp^.INFO.MatCost);
    Grid.Cells[4,Grid.RowCount - 1] := 'Удалить';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure getCBBObjectsList(CBB: TComboBox; const head: TObjAdr);
var
  temp:TObjAdr;
begin
  CBB.Clear;
  CBB.Text := 'Выбрать объект';
  temp := head^.adr;
  while temp <> nil do
  begin
    CBB.Items.Add(temp^.Info.name);
    temp:=temp^.adr;
  end;
end;

procedure removeObjList(var head:TObjAdr; const el:string);
var
  temp,temp2:TObjAdr;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Info.name = el then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure editObjList(head:TObjAdr; name:string; newname:string; newtype: TObjTypes; newwork: integer; newmoney: Currency );
var
  temp:TObjAdr;
  flag: boolean;
begin
  temp:= head;
  flag := true;
  while (temp <> nil) and flag do
  begin
    if temp.Info.name = name then
    begin
      temp^.info.name := newname;
      temp^.Info.obType := newtype;
      temp^.Info.Workers := newwork;
      temp^.Info.MatCost := newmoney;
      flag := false;
    end;
    temp := temp^.Adr;
  end;
end;

procedure searchObjList(head:TObjAdr;Grid:TStringGrid;obj:string; minwork: integer; money: Currency; objtype: TObjTypes; n1,n2,n3:integer);
var
  b1,b2,b3, b4:Boolean;
  temp:TObjAdr;
begin
  Grid.ColCount := 5;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := 'Название объекта';
  Grid.Cells[1,0] := 'Тип объекта';
  Grid.Cells[2,0] := 'Мин. кол-во рабочих';
  Grid.Cells[3,0] := 'Стоимость материалов';
  temp:=head.adr;
  while temp <> nil do
  begin
    if obj = '' then
      b1 := true
    else
    begin
      if n1 = 0 then
        b1 := temp^.Info.name = obj
      else
      begin
        b1 := Pos(AnsiUpperCase(obj),AnsiUpperCase(temp^.Info.name)) > 0;
      end;

    end;
    if minwork = -1 then
      b2 := True
    else
    begin
      b2 := temp^.Info.Workers = minwork;
      case n2 of
        0: b2 := temp^.Info.Workers = minwork;
        1: b2 := temp^.Info.Workers < minwork;
        2: b2 := temp^.Info.Workers > minwork;
      end;
    end;
    if money = -1 then
      b3:= True
    else
    begin
      case n3 of
        0: b3 := temp^.Info.MatCost = money;
        1: b3 := temp^.Info.MatCost < money;
        2: b3 := temp^.Info.MatCost > money;
      end;
    end;
    if objtype = objNone then
      b4:= True
    else
      b4 := objtype = temp^.Info.obType;


    if b1 and b2 and b3 and b4 then
    begin
      Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.name;
      Grid.Cells[1,Grid.RowCount - 1] := writeObjType(temp^.Info.obType);
      Grid.Cells[2,Grid.RowCount - 1] := IntToStr(temp^.INFO.Workers);
      Grid.Cells[3,Grid.RowCount - 1] := CurrToStr(temp^.INFO.MatCost);
      Grid.Cells[4,Grid.RowCount - 1] := 'Удалить';
      Grid.RowCount := Grid.RowCount + 1;
    end;

    temp:= temp^.Adr;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;
procedure removeAllObjList(head:TObjAdr);
var
  temp, temp2: tobjadr;
begin
  temp := head^.Adr;
  while temp <> nil do
  begin
    temp2:=temp^.Adr;
    dispose(temp);
    temp:=temp2;
  end;
  head.Adr := nil;
end;
end.

