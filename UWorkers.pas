{*******************************************************}
{       WORKERS LIBRARY                                 }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UWorkers;

interface
uses
  Vcl.Forms,Vcl.Grids, Vcl.Graphics, Vcl.StdCtrls;

type
 {  ***** ������ ������� ������ ***** }
    TWorkersInfo = record    // ���� ����������
      Name: string[30];        // ��� ��������
      Company: string[30];     // ��������, � ������� �� �������� (���������)
      Salary:Currency;         // ��������
      ObjType: string[30];     // ��� �������, ������� �� ����� ����������
    end;
    TWorkAdr = ^TWorkersList;// ������ �� ������ �������
    TWorkersList = record    // ������ �������
      Info: TWorkersInfo;      // ���� ����������
      Adr: TWorkAdr;           // ����� ���� ������� ������
    end;
    {  ***** ������ ������� ����� ***** }
  const
    WorkFile = 'workers.brakh';

// ��������� � �������
procedure writeWorkList(Grid:TStringGrid; const head:TWorkAdr);
//procedure removeWorkList(var head:TContrAdr; const el:string);
procedure readFromFileWithContractors(const head: TWorkAdr; contr: string);
function insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House'):integer;
procedure saveWorkFile(const head:TWorkAdr);

implementation

  uses  System.SysUtils, UObjects, UContractors;



procedure readFromFileWithContractors(const head: TWorkAdr; contr: string);
var
  f: file of TWorkersInfo;
  Temp: TWorkAdr;
  TInfo: TWorkersInfo;
begin
  AssignFile(f, WorkFile);
  if fileExists(WorkFile) then
  begin
    Reset(f);
    //Writeln('Read file ' + WorkFile);
    Head^.Adr := nil;
    Temp := Head;
    while not EOF(f) do
    begin
      read(f, TInfo);
      if (TInfo.Company = contr) then
      begin
        new(Temp^.adr);
        Temp:=Temp^.adr;
        Temp^.adr:=nil;
        Temp^.Info := TInfo;
      end;
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

function insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House'):integer;
var
  temp:TWorkAdr;
begin
  //if ObjAdrOf(_new_lab2.ObjHead, ObjType) = nil then

  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Info.Name := name;
  temp^.Info.Company := company;
  temp^.Info.Salary := Salary;
  temp^.Info.ObjType := ObjType;
  Result:= Integer(temp);
end;


procedure writeWorkList(Grid:TStringGrid; const head:TWorkAdr);
var
  temp:TWorkAdr;
begin
  Grid.ColCount := 5;
  Grid.Cells[0,0] := '���';
  Grid.Cells[1,0] := '��������';
  Grid.Cells[2,0] := '��������';
  Grid.Cells[3,0] := '��� �������';

  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Info.Company;
    Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.Salary);
    Grid.Cells[3,Grid.RowCount - 1] := temp^.Info.ObjType;
    Grid.Cells[4,Grid.RowCount - 1] := IntToStr( Integer(temp) );
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
end;

procedure saveWorkFile(const head:TWorkAdr);
var
  f: file of TWorkersInfo;
  temp: TWorkAdr;
begin
  AssignFile(f, WorkFile);
  Reset(f);
  Seek(f,FileSize(f));

  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    temp:=temp^.adr;
  end;
  close(F);
end;



end.
