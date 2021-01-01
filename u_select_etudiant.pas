unit u_select_etudiant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_select_etudiant }

  Tf_select_etudiant = class(TForm)
    btn_ok: TButton;
    cbo_code: TComboBox;
    edt_numero: TEdit;
    edt_nom: TEdit;
    lbl_code: TLabel;
    lbl_nom: TLabel;
    lbl_numero: TLabel;
    pnl_ok: TPanel;
    pnl_filiere_btn: TPanel;
    pnl_filiere_edit: TPanel;
    pnl_filiere: TPanel;
    pnl_etudiant_btn: TPanel;
    pnl_etudiant_edit: TPanel;
    pnl_etudiant: TPanel;
    pnl_tous_btn: TPanel;
    pnl_tous_edit: TPanel;
    pnl_tous: TPanel;
    pnl_titre: TPanel;
    pnl_choix: TPanel;
    procedure Init;
    procedure NonSelectionPanel (pnl : TPanel);
    procedure AucuneSelection;
    procedure pnl_choix_btnClick (Sender: TObject);
    procedure btn_okClick(Sender : TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_select_etudiant: Tf_select_etudiant;

implementation

{$R *.lfm}

{ Tf_select_etudiant }

uses u_feuille_style, u_list_etudiant, u_modele;

var
  pnl_actif : TPanel;

procedure Tf_select_etudiant.Init;
begin
  style.panel_defaut(pnl_choix);
  style.panel_selection(pnl_titre);
  style.panel_defaut(pnl_ok);
  pnl_choix_btnClick (pnl_tous_btn);
end;

procedure Tf_select_etudiant.pnl_choix_btnClick (Sender : TObject);
var pnl : TPanel;
begin
  AucuneSelection; // retirer la sélection en cours
  pnl := TPanel(Sender) ;
  style.panel_selection (pnl);
  pnl := TPanel(pnl.Parent); // récupération du panel parent "pnl_xxx"
  style.panel_selection (pnl);
  pnl := TPanel(f_select_etudiant.FindComponent(pnl.name +'_edit'));
  style.panel_selection (pnl);
  pnl.show;
  pnl_actif := pnl; pnl_actif.enabled := true;
  btn_ok.visible := true;
end;

procedure Tf_select_etudiant.NonSelectionPanel (pnl : TPanel);
var pnl_enfant : TPanel;
  begin
  style.panel_defaut(pnl); // affectation des paramètres Fonte et Couleur du panel pnl_choix
  // récupération du panel '_btn'
  pnl_enfant := TPanel(f_select_etudiant.FindComponent(pnl.name +'_btn'));
  style.panel_bouton(pnl_enfant);
  // récupération du panel '_edit'
  pnl_enfant := TPanel(f_select_etudiant.FindComponent(pnl.name +'_edit'));
  pnl_enfant.Hide;
end;

procedure Tf_select_etudiant.AucuneSelection;
begin
  NonSelectionPanel (pnl_tous); NonSelectionPanel (pnl_etudiant);
  NonSelectionPanel (pnl_filiere);
end;

procedure Tf_select_etudiant.btn_okClick(Sender : TObject);
begin
  if pnl_tous_edit.Visible then
     f_list_etudiant.affi_data(modele.etudiant_liste_tous)
  else if pnl_etudiant_edit.Visible then
     f_list_etudiant.affi_data(modele.etudiant_liste_etudiant(edt_numero.text,edt_nom.text))
  else if pnl_filiere_edit.Visible then
     f_list_etudiant.affi_data(modele.etudiant_liste_filiere(cbo_code.text))
end;

end.
