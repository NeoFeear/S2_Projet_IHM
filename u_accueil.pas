unit u_accueil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tf_accueil }

  Tf_accueil = class(TForm)
    lbl_bvn1: TLabel;
    lbl_bvn2: TLabel;
    lbl_bvn3: TLabel;
    pnl_tout: TPanel;
    procedure Init;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_accueil: Tf_accueil;

implementation

{$R *.lfm}

{ Tf_accueil }

uses u_feuille_style;

var
  pnl_actif : TPanel;

procedure Tf_accueil.Init;
begin
  style.panel_travail(pnl_tout);
end;

end.

