unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    bCancel: TBitBtn;
    bSave: TBitBtn;
    CBNote: TComboBox;
    eTelephone: TEdit;
    eName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure bCancelClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure CBNoteChange(Sender: TObject);
    procedure eNameChange(Sender: TObject);
    procedure eTelephoneChange(Sender: TObject);
    procedure eTelephoneKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;

procedure TfEdit.eNameChange(Sender: TObject);
begin

end;

procedure TfEdit.eTelephoneChange(Sender: TObject);
begin

end;

procedure TfEdit.eTelephoneKeyPress(Sender: TObject; var Key: char);
begin
  if (Key in ['0'..'9', #8]) or
     ((Key = '+') and (eTelephone.Text = '')) then
    Exit;

  Key := #0;
end;

procedure TfEdit.CBNoteChange(Sender: TObject);
begin

end;

procedure TfEdit.bSaveClick(Sender: TObject);
begin

  ModalResult := mrOk;
end;

procedure TfEdit.bCancelClick(Sender: TObject);
begin

  ModalResult := mrCancel;
end;

end.

