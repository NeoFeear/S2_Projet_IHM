program Projet_Martin_Dussaussois;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_projet, u_feuille_style,
u_accueil, u_select_etudiant, u_list_etudiant,
  zcomponent, u_detail_etudiant, u_modele, u_notes_list, u_indispo
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tf_projet, f_projet);
  Application.CreateForm(Tf_accueil, f_accueil);
  Application.CreateForm(Tf_select_etudiant, f_select_etudiant);
  Application.CreateForm(Tf_list_etudiant, f_list_etudiant);
  Application.CreateForm(Tf_detail_etudiant, f_detail_etudiant);
  Application.CreateForm(Tf_notes_list, f_notes_list);
  Application.CreateForm(Tf_indispo, f_indispo);
  Application.Run;
end.

