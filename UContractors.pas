unit UContractors;

interface
uses UWorkers;
type
  { *** СПИСОК ПОДРЯДЧИКОВ НАЧАЛО *** }
  TContractorsInfo = record  // Блок информации
    Name:string[30];            // Название подрядчика
  end;
  TContrAdr = ^ TContractorsList; // Ссылка на список подрядчиков
  TContractorsList = record  // Список подрядчиков
    Info: TContractorsInfo;    // Блок информации
    WorkersHead: TWorkAdr;     // Ссылка на голову списка рабочих этой компании
    Adr: TContrAdr;            // Адрес след. элемента в списке
  end;
  { *** СПИСОК ПОДРЯДЧИКОВ КОНЕЦ *** }

// ПРОЦЕДУРЫ И ФУНКЦИИ
procedure readContrFile(const head:TContrAdr);
procedure saveContrFile(const head:TContrAdr);
procedure insertContrList(const head: TContrAdr; name:string);
procedure writeContrList(var head:TContrAdr);
procedure insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');

implementation
uses
  System.SysUtils;
const
  ContrFile = 'contractors.brakh';

function adrOf(head: TContrAdr; name: string):TContrAdr;
var
  temp: TContrAdr;
begin
  temp := head;
  Result := nil;
  while(temp <> nil) do
  begin
    if temp^.Info.Name = name then
      Result:=temp;
    temp := temp^.Adr;
  end;
end;

procedure readContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  Temp: TContrAdr;
begin
  AssignFile(f, ContrFile);
  if fileExists(ContrFile) then
  begin
    Reset(f);
    Writeln('Read file ' + ContrFile);
    Temp := Head;
    while not EOF(f) do
    begin
      new(Temp^.adr);
      Temp:=Temp^.adr;
      Temp^.adr:=nil;
      read(f, Temp^.Info);
      new(Temp^.WorkersHead);
      Temp^.WorkersHead.Adr := nil;
      readFromFileWithContractors(temp^.WorkersHead, temp^.Info.Name);
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

procedure saveContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  f2: file of TWorkersInfo;
  temp: TContrAdr;
begin
  AssignFile(f2, WorkFile);
  Rewrite(f2);
  Close(f2);
  AssignFile(f, ContrFile);
  rewrite(f);
  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    saveWorkFile(temp^.WorkersHead);
    temp:=temp^.adr;
  end;
  close(F);
end;

procedure insertContrList(const head: TContrAdr; name:string);
var
  temp:TContrAdr;
begin
  if (adrOf(head,name) = nil) then
  begin
    temp := head;
    while temp^.adr <> nil do
    begin
      temp := temp^.adr;
    end;
    new(temp^.adr);
    temp:=temp^.adr;
    temp^.adr:=nil;
    temp^.Info.Name := name;
    New(temp^.WorkersHead);
    temp^.WorkersHead.Adr := nil;

  end
  else
    writeln('The company is already registered');
end;

procedure writeContrList(var head:TContrAdr);
var
  temp:TContrAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INFO.Name);
    writeWorkList(temp^.WorkersHead);  // ИЗ юнита UWORKERS
    temp:=temp^.adr;
  end;
end;

procedure insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');
var
  temp:TContrAdr;
begin
  temp := head;
  while temp <> nil do
  begin
    if (temp^.Info.Name = company) then
    begin
      insertWorkList(temp^.WorkersHead, company, Name, Salary, ObjType);
      Exit;
    end;
    temp:=temp^.Adr;
  end;
  Writeln('Company not found');
end;


end.
