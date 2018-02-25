program lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type TInf = record
  name: String[100];
  {GR: string[6];
  Oaip:integer;
  }end;
  TADR = ^TSP;
  TSP = record
    INF: TINF;
    adr:TADR;
  end;

  var
    Head, temp:TADR;
    temp2: TADR;
    i:integer;
    delel:string;

procedure addList(var temp:TADR);
begin
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  Readln(temp^.INF.name); // := 'Kek';
end;

procedure writeList(var head:TADR);
var
  temp:TADR;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INF.name);
    temp:=temp^.adr;
  end;
end;

procedure removeList(var head:TADR; const el:string);
var
  temp,temp2:TADR;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.INF.name = el then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure AfterInsertList(var head:TADR; const el:string; const Insert:string);
var
  temp,temp2:TADR;
begin
  temp := head;
  while temp <> nil do
  begin
    if temp^.INF.name = el then
    begin
      temp2 := temp^.adr;
      new(temp^.adr);
      temp:=temp^.adr;
      temp^.INF.name:=Insert;
      temp^.adr := temp2;
      // temp2.adr := temp.adr;
      // temp^.adr := temp;
    end
    else
    begin
      temp:= temp^.adr;
    end;
  end;
end;

procedure insertList(var head:TADR; insert:string);
var
  temp:TADR;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.INF.name:=insert;

end;

begin

  new(Head);
  Head^.adr := nil;
  temp := head;
  for i := 1 to 3 do
  begin
    addList(temp);
  end;
  Writeln;
  writeList(head);
  readln(delel);

  writeln;

  removeList(head, delel);

  writeln;

  writeList(head);

  writeln;

  readln(delel);

  writeln;

  AfterInsertList(head, delel, 'kek');
  insertList(head, 'lol');
  Writeln;

  writeList(head);
  readln(i);
end.
