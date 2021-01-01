unit u_projet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls;

type

  { Tf_projet }

  Tf_projet = class(TForm)
    mnu_main: TMainMenu;
    item_Accueil: TMenuItem;
    pnl_ariane: TPanel;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    item_Statistiques: TMenuItem;
    item_Inscrit: TMenuItem;
    item_Filiere: TMenuItem;
    item_Quitter: TMenuItem;
    item_Liste1: TMenuItem;
    item_Archive: TMenuItem;
    item_ArchiveN1: TMenuItem;
    item_ArchiveN2: TMenuItem;
    item_Liste2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure item_QuitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure choix_item_Accueil;
    procedure choix_item_Liste1;
    procedure choix_item_ArchiveN1;
    procedure choix_item_ArchiveN2;
    procedure choix_item_Liste2;
    procedure choix_item_Statistiques;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_projet: Tf_projet;

implementation

{$R *.lfm}

{ Tf_projet }

uses u_feuille_style,
     u_accueil, u_indispo,
     u_select_etudiant, u_list_etudiant,
     u_detail_etudiant, u_modele;


  procedure Tf_projet.FormShow(Sender: TObject);
  begin
    pnl_ariane.Caption := ' > Accueil';
    f_accueil.borderstyle := bsNone;
    f_accueil.parent := pnl_travail;
    f_accueil.align := alClient;
    f_accueil.init;
    f_accueil.show;

    style.panel_selection (pnl_ariane);
    style.panel_defaut (pnl_selection);
    style.panel_travail (pnl_travail);
    style.panel_defaut (pnl_info);
    f_projet.width := 1200;
    f_projet.height := 800;

    modele.open;
  end;

  procedure Tf_projet.mnu_item_Click(Sender: TObject);
  var
     item : TMenuItem;
  begin
     pnl_selection.show;

     pnl_ariane.Caption := '';
     item := TmenuItem(Sender);
     repeat
           pnl_ariane.Caption := ' > ' + item.caption +pnl_ariane.Caption;
           item := item.parent;
     until item.parent = nil;
     item := TmenuItem(Sender);
     if item=item_Accueil then choix_item_Accueil;
     if item=item_Liste1 then choix_item_Liste1;
     if item=item_ArchiveN1 then choix_item_ArchiveN1;
     if item=item_ArchiveN2 then choix_item_ArchiveN2;
     if item=item_Liste2 then choix_item_Liste2;
     if item=item_Statistiques then choix_item_Statistiques;
  end;

  procedure Tf_projet.choix_item_Accueil;
  begin
    f_indispo.Close;
    f_select_etudiant.Close;
    f_list_etudiant.Close;

    f_accueil.borderstyle := bsNone;
    f_accueil.parent := pnl_travail;
    f_accueil.align := alClient;
    f_accueil.init;
    f_accueil.show;
  end;

  procedure Tf_projet.choix_item_Liste1;
  begin
    f_accueil.Close;
    f_indispo.Close;

    f_select_etudiant.borderstyle := bsNone;
    f_select_etudiant.parent      := pnl_selection;
    f_select_etudiant.align       := alClient;
    f_select_etudiant.init;
    f_select_etudiant.show;

    f_list_etudiant.borderstyle   := bsNone;
    f_list_etudiant.parent        := pnl_travail;
    f_list_etudiant.align         := alClient;
    f_list_etudiant.init;
    f_list_etudiant.show;

    f_detail_etudiant.borderstyle := bsNone;
    f_detail_etudiant.parent := pnl_travail;
    f_detail_etudiant.align := alClient;
  end;

  procedure Tf_projet.choix_item_ArchiveN1;
  begin
    f_accueil.Close;
    f_select_etudiant.Close;
    f_list_etudiant.Close;

    f_indispo.borderstyle := bsNone;
    f_indispo.parent := pnl_travail;
    f_indispo.align := alClient;
    f_indispo.init;
    f_indispo.show;
  end;

  procedure Tf_projet.choix_item_ArchiveN2;
  begin
    f_accueil.Close;
    f_select_etudiant.Close;
    f_list_etudiant.Close;

    f_indispo.borderstyle := bsNone;
    f_indispo.parent := pnl_travail;
    f_indispo.align := alClient;
    f_indispo.init;
    f_indispo.show;
  end;

  procedure Tf_projet.choix_item_Liste2;
  begin
    f_accueil.Close;
    f_select_etudiant.Close;
    f_list_etudiant.Close;

    f_indispo.borderstyle := bsNone;
    f_indispo.parent := pnl_travail;
    f_indispo.align := alClient;
    f_indispo.init;
    f_indispo.show;
  end;

  procedure Tf_projet.choix_item_Statistiques;
  begin
    f_accueil.Close;
    f_select_etudiant.Close;
    f_list_etudiant.Close;

    f_indispo.borderstyle := bsNone;
    f_indispo.parent := pnl_travail;
    f_indispo.align := alClient;
    f_indispo.init;
    f_indispo.show;
  end;

  procedure Tf_projet.item_QuitterClick(Sender: TObject);
  begin
    modele.Close;
    Close;
  end;

end.

