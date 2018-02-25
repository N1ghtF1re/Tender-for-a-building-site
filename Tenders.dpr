program Tenders;

uses
  Vcl.Forms,
  Tender in 'Tender.pas' {TenderFSorm},
  UObjects in 'UObjects.pas',
  UWorkers in 'UWorkers.pas',
  UContractors in 'UContractors.pas',
  UTender in 'UTender.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTenderForm, TenderForm);
  Application.Run;
end.
