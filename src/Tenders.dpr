program Tenders;

uses
  Vcl.Forms,
  Tender in 'Tender.pas' {TenderFSorm},
  UObjects in 'UObjects.pas',
  UWorkers in 'UWorkers.pas',
  UContractors in 'UContractors.pas',
  UTender in 'UTender.pas',
  AddList in 'AddList.pas' {AddListForm},
  USearch in 'USearch.pas' {SearchForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTenderForm, TenderForm);
  Application.CreateForm(TAddListForm, AddListForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.Run;
end.
