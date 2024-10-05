unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    LClock: TLabel;
    Timer1: TTimer;
    procedure LClockClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Timer1Timer(Sender: TObject);
var i:byte;
begin
     LClock.Caption:=TimeToStr(Now);
     i:=random(4);
     case i of
     0: LClock.Left := LClock.Left + 50;
     1: LClock.Left := LClock.Left - 50;
     2: LClock.Top := LClock.Left + 50;
     3: LClock.Top := LClock.Left - 50;
     end;
     if (lClock.Left + lClock.Width) > fMain.Width then
        lClock.Left:= fMain.Width - lClock.Width;
     if LClock.Left < 0 then LClock.Left:= 0;
     if LClock.Top < 0 then LClock.Top:= 0;
     if (LClock.Left + LClock.Width) > fMain.Width then
        LClock.Top:= fMain.Height - LClock.Height;
end;

procedure TfMain.LClockClick(Sender: TObject);
begin

end;

end.

