unit u_notes_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Spin, StdCtrls, Grids, u_liste;

type

  { Tf_notes_list }

  Tf_notes_list = class(TF_liste)
    procedure Init(affi : boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_notes_list: Tf_notes_list;

implementation

{$R *.lfm}

uses u_feuille_style;

procedure Tf_notes_list.Init (affi : boolean);
begin
style.panel_travail(pnl_affi);
style.grille (sg_liste);
pnl_titre.Hide;
pnl_btn.Hide;
end;

end.

