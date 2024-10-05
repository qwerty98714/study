unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    EditRatio: TEdit;
    EditRadius: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelArea: TLabel;
    LabelDiagonal: TLabel;
    procedure ButtonCalculateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  R, k, a, b, diagonal, area: Double;
begin
  // Считываем значения радиуса и отношения сторон из полей ввода
  R := StrToFloat(EditRadius.Text);
  k := StrToFloat(EditRatio.Text);

  // Вычисляем диагональ и стороны прямоугольника
  diagonal := 2 * R; // Диагональ прямоугольника равна диаметру окружности
  a := diagonal / sqrt(1 + sqr(k)); // Одна из сторон прямоугольника
  b := diagonal * k / sqrt(1 + sqr(k)); // Другая сторона, с учетом отношения сторон

  // Вычисляем площадь прямоугольника
  area := a * b;

  // Выводим результаты на экран
  LabelDiagonal.Caption := 'Диагональ: ' + FloatToStr(diagonal);
  LabelArea.Caption := 'Площадь: ' + FloatToStr(area);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;



end.

