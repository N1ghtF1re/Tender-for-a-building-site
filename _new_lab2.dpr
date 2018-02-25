{*******************************************************}
{                                                       }
{       Lab №2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}

program _new_lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  { *** СПИСОК ОБЪЕКТОВ НАЧАЛО *** }
  TObjInfo = record    // Блок информации
    obType:string[30];  // Тип объекта
    Workers:integer;    // Минимальное количество рабочих
    MatCost:Currency;   // Стоимость материалов
  end;
  TObjAdr = ^TObjList; // Ссылка на Список Объектов
  TObjList = record    // Список Объектов
    Info: TObjInfo;
    Adr: TObjAdr;
  end;
  { *** СПИСОК ОБЪЕКТОВ КОНЕЦ  *** }

  { *** СПИСОК ПОДРЯДЧИКОВ НАЧАЛО *** }

    {  ***** СПИСОК РАБОЧИХ НАЧАЛО ***** }
    TWorkersInfo = record    // Блок информации
      Name: string[30];        // ФИО Рабочего
      Company: string[30];     // Компания, в которой он работает (Подрядчик)
      Salary:Currency;         // Зарплата
      ObjType: string[30];     // Тип объекта, которым он может заниматься
    end;
    TWorkAdr = ^TWorkersList;// Ссылка на список рабочих
    TWorkersList = record    // Список рабочих
      Info: TWorkersInfo;      // Блок информации
      Adr: TWorkAdr;           // Адрес след элемент списка
    end;
    {  ***** СПИСОК РАБОЧИХ КОНЕЦ ***** }

  TContractorsInfo = record  // Блок информации
    Name:string[30];            // Название подрядчика
  end;
  TContrAdr = ^ TContractorsList; // Ссылка на список подрядчиков
  TContractorsList = record  // Список подрядчиков
    Info: TContractorsInfo;    // Блок информации
    WorkersHead: TWorkAdr;     // Ссылка на голову списка рабочих этой компании
    Adr: TContrAdr             // Адрес след. элемента в списке
  end;
  { *** СПИСОК ПОДРЯДЧИКОВ КОНЕЦ *** }
  const
    ObjFile = 'objects.brakh'; // Файл объектов
    WorkFile = 'workers.brakh'; // Файл объектов
    ContrFile = 'contractors.brakh'; // Файл объектов
var
  ObjHead:TObjAdr;
  //TObjects



procedure readObjFile;
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    Writeln('Read file');
    OTemp := ObjHead;
    while not EOF(f) do
    begin
      new(OTemp^.adr);
      OTemp:=OTemp^.adr;
      OTemp^.adr:=nil;
      read(f, OTemp^.Info);
      //OTemp^.Info

    end;
    close(f);
  end
  else
  begin
    Rewrite(f);
    Writeln('Create File');
    close(f);
  end;

end;

procedure saveObjFile(var head:TObjAdr);
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

procedure insertObjList(var head: TObjAdr; tp:string = '1 Float House'; wk:integer = 0; mc:Currency = 0);
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
  temp^.Info.obType := tp;
  temp^.Info.Workers := wk;
  temp^.Info.MatCost := mc;
end;

procedure writeList(var head:TObjAdr);
var
  temp:TObjAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INFO.obType);
    writeln(temp^.INFO.Workers);
    writeln(CurrToStr(temp^.INFO.MatCost));
    temp:=temp^.adr;
  end;
end;

begin
  new(ObjHead);
  ObjHead^.adr := nil;
  readObjFile;
  writeln;
  writeList(objHead);
  writeln;

 // insertObjList(ObjHead);
 // insertObjList(ObjHead,'Trading House', 45, 885);
  writeList(objHead);
  saveObjFile(objHead);



  readln;
end.
