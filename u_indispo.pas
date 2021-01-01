unit u_indispo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tf_indispo }

  Tf_indispo = class(TForm)
    lbl_indispo1: TLabel;
    lbl_indispo2: TLabel;
    pnl_tout: TPanel;
    procedure Init;

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_indispo: Tf_indispo;

implementation

{$R *.lfm}

{ Tf_indispo }

uses u_feuille_style;

var
  pnl_actif : TPanel;

procedure Tf_indispo.Init;
begin
  style.panel_travail(pnl_tout);
end;

end.

