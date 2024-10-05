unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TForm1 }

  TForm1 = class(TForm)
    But1: TButton;
    But10: TButton;
    But11: TButton;
    But12: TButton;
    But13: TButton;
    But14: TButton;
    But15: TButton;
    But16: TButton;
    But17: TButton;
    But18: TButton;
    But19: TButton;
    But20: TButton;
    But21: TButton;
    But22: TButton;
    But2: TButton;
    But3: TButton;
    But4: TButton;
    But5: TButton;
    But6: TButton;
    But7: TButton;
    But8: TButton;
    But9: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure But16Click(Sender: TObject);
    procedure But17Click(Sender: TObject);
    procedure But18Click(Sender: TObject);
    procedure But19Click(Sender: TObject);
    procedure But20Click(Sender: TObject);
    procedure But21Click(Sender: TObject);
    procedure But22Click(Sender: TObject);
    procedure ClickBut(Sender: TObject);
    procedure ClickZnak(Sender: TObject);
  private
    { private declarations }
    function TryGetNumberFromEdit(out Value: Real): Boolean;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  a, b, c: Real;
  znak: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.ReadOnly := True;
  Self.BorderStyle := bsSingle;
end;

function TForm1.TryGetNumberFromEdit(out Value: Real): Boolean;
var
  S: String;
begin
  S := Edit1.Text;
  // Используем Delphi функцию TryStrToFloat для безопасного преобразования строки в число
  Result := TryStrToFloat(S, Value);
  if not Result then
    Edit1.Text := 'Некорректный ввод!';
end;

procedure TForm1.ClickBut(Sender: TObject);
var
  ButtonText, CurrentText: String;
begin
  ButtonText := (Sender as TButton).Caption;
  CurrentText := Edit1.Text;
  if ((ButtonText = '.') or (ButtonText = ',')) and ((Pos('.', CurrentText) > 0) or (Pos(',', CurrentText) > 0)) then Exit;
  if (CurrentText = '0') and (ButtonText <> '.') then
    CurrentText := '';
  if ButtonText = ',' then ButtonText := '.';
  Edit1.Text := CurrentText + ButtonText;
end;

procedure TForm1.ClickZnak(Sender: TObject);
var
  Num: Real;
begin
  if TryGetNumberFromEdit(Num) then
  begin
    a := Num;
    Edit1.Clear;
    znak := (Sender as TButton).Caption;
  end;
end;

procedure TForm1.But21Click(Sender: TObject);
begin
  Edit1.Clear;
end;

procedure TForm1.But22Click(Sender: TObject);
var
  str: String;
begin
  str := Edit1.Text;
  if str <> '' then Delete(str, Length(str), 1);
  Edit1.Text := str;
end;

procedure TForm1.But16Click(Sender: TObject);
begin
  if TryGetNumberFromEdit(b) then
  begin
    case znak of
      '+': c := a + b;
      '-': c := a - b;
      '*': c := a * b;
      '/': if b = 0 then
             Edit1.Text := 'Деление на ноль невозможно!'
           else
             c := a / b;
    else
      Edit1.Text := 'Не выбрана операция!';
      Exit;
    end;
    Edit1.Text := FloatToStr(c);
  end;
end;

procedure TForm1.But17Click(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) and (a <> 0) then
  begin
    a := 1 / a;
    Edit1.Text := FloatToStr(a);
  end
  else if a = 0 then
    Edit1.Text := 'Деление на ноль невозможно!';
end;

procedure TForm1.But18Click(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) then
  begin
    a := sqr(a);
    Edit1.Text := FloatToStr(a);
  end;
end;

procedure TForm1.But19Click(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) and (a >= 0) then
  begin
    a := sqrt(a);
    Edit1.Text := FloatToStr(a);
  end
  else if a < 0 then
    Edit1.Text := 'Корень из отрицательного числа невозможен!';
end;

procedure TForm1.But20Click(Sender: TObject);
begin
  Edit1.Clear;
  a := 0;
  b := 0;
  c := 0;
  znak := '';
end;

end.

