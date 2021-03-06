{*******************************************************}
{       ADD NEW ELEMENT TO LIST                         }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit AddList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, System.Actions, Vcl.ActnList, UObjects, UWorkers, UContractors;

type
  TMode = (MObjList, MContrList, MWorkList, MTender);
  TAddListForm = class(TForm)
    pnlMain: TPanel;
    lblInput1: TLabel;
    edtInput1: TEdit;
    lblInput2: TLabel;
    edtInput2: TEdit;
    lblInput3: TLabel;
    edtInput3: TEdit;
    btnAddList: TButton;
    cbbSetCompany: TComboBox;
    cbbSetObject: TComboBox;
    lblInput4: TLabel;
    edtInput4: TEdit;
    procedure btnAddListClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure FillFrom(Mode:TMode);
  end;

var
  AddListForm: TAddListForm;

implementation
uses Tender;
{$R *.dfm}

procedure TAddListForm.btnAddListClick(Sender: TObject);
var 
  st:string;
  objt: TObjTypes;
begin
  case TMode(TenderForm.mode) of
    MObjList:
    begin
      try
        if ObjAdrOfName(TenderForm.getObjHead, Trim(edtInput1.Text)) = nil then
        begin
          if ( (Trim(edtInput1.Text) <> '') and (Trim(edtInput2.Text) <> '') and (Trim(edtInput1.Text) <> '')) then
          begin
            while Ord(ObjT)<>cbbSetObject.ItemIndex do ObjT:=Succ(ObjT);
            TenderForm.addNewObj(ObjT, Trim(edtInput1.Text),StrToInt(edtInput2.Text), StrToCurr(edtInput4.Text));
            Self.Close;
          end
          else
            ShowMessage('���� �� ����� ���� �������');
        end
        else
          ShowMessage('����� ������ ��� ����������');
      except on E: Exception do
        ShowMessage('������������ ����')
      end;
    end;
    MContrList:
    begin
      if ContrAdrOf(TenderForm.getContHead, Trim(edtInput1.Text)) = nil then
      begin
        if ( (Trim(edtInput1.Text) <> '')) then
        begin
          TenderForm.addNewCompany(edtInput1.Text);
          Self.Close;
        end
        else
            ShowMessage('���� �� ����� ���� �������');
      end
      else
        ShowMessage('�������� ��� ����������������');
    end;
    MWorkList:
    begin
      try
        st := cbbSetCompany.Text;
          //ShowMessage( TenderForm.getAdditionalTitle );
          if (TenderForm.getAdditionalTitle <> '' ) then
          begin
            st:=TenderForm.getAdditionalTitle;
          end;

          while Ord(ObjT)<>cbbSetObject.ItemIndex do ObjT:=Succ(ObjT);
          if ( (Trim(cbbSetObject.Text) <> '') and (Trim(edtInput1.Text) <> '') and (Trim(edtInput4.Text) <> '') and (Trim(cbbSetObject.Text) <> '')) then
          begin
            TenderForm.addNewWorkers(edtInput1.Text, objt,st, StrToCurr(edtInput4.Text));
            Self.Close;
          end
          else
            ShowMessage('���� �� ����� ���� �������');

      except on E: Exception do
        ShowMessage('������������ ����')
      end;
    end;
  end;
end;

procedure TAddListForm.FillFrom(Mode:TMode);
begin
  //ShowMessage( IntToStr(Ord(mode) ) );
  case TMode(TenderForm.mode) of
      MObjList:
      begin
        lblInput1.Caption := '�������� �������';
        edtInput1.Text := '';
        lblInput2.Visible := true;
        lblInput3.Visible := True;
        edtInput2.Visible := true;
        edtInput3.Visible := True;
        cbbSetCompany.Visible := false;
        cbbSetObject.Visible:=true;

        edtInput4.Visible := true;
        lblInput4.Visible := true;
        lblInput2.Caption := '����������� ���-�� �������';
        edtInput2.Text := '';
        lblInput3.Caption := '��� �������';
        edtInput3.Text := '';
        lblInput4.Caption := '���� ����������';
        edtInput4.Text := '';
      end;
      MContrList:
      begin
        lblInput2.Visible := false;
        lblInput3.Visible := false;
        edtInput2.Visible := false;
        edtInput3.Visible := false;
        edtInput4.Visible := false;
        lblInput4.Visible := false;
        cbbSetCompany.Visible := false;
        cbbSetObject.Visible:=False;
        lblInput1.Caption := '�������� ��������';
        edtInput1.Text := '';
      end;
      MWorkList:
      begin
        lblInput2.Visible := true;
        lblInput3.Visible := true;
        edtInput2.Visible := false;
        edtInput3.Visible := false;
        cbbSetCompany.Visible := True;
        cbbSetObject.Visible:=true;
        //getCBBObjectsList(cbbSetObject, TenderForm.getObjHead);
        getCBBContrList(cbbSetCompany, TenderForm.getContHead);
        if (TenderForm.getAdditionalTitle <> '' ) then
        begin
          cbbSetCompany.Enabled := false;
        end;
        edtInput4.Visible := true;
        lblInput4.Visible := true;
        lblInput1.Caption := '���';
        lblInput2.Caption:= '��������';
        lblInput3.Caption:= '������';
        edtInput1.Text := '';
        lblInput4.Caption:= '��������';
        edtInput4.Text := '';
      end;
    end;
end;
procedure TAddListForm.FormActivate(Sender: TObject);
begin
  btnAddList.Visible := True;
  FillFrom(TMode(TenderForm.Mode));
end;

end.
