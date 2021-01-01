unit u_detail_etudiant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids;

type

  { Tf_detail_etudiant }

  Tf_detail_etudiant = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    cbo_genre: TComboBox;
    cbo_codefiliere: TComboBox;
    edt_numero: TEdit;
    edt_nom: TEdit;
    edt_adr: TEdit;
    edt_cp: TEdit;
    edt_numero1: TEdit;
    edt_numero2: TEdit;
    edt_ville: TEdit;
    edt_prenom: TEdit;
    edt_mel: TEdit;
    lbl_moy: TLabel;
    lbl_codefiliere_erreur: TLabel;
    lbl_mel_erreur: TLabel;
    lbl_tel_erreur: TLabel;
    lbl_ville_erreur: TLabel;
    lbl_code_erreur: TLabel;
    lbl_adr_erreur: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_numero_erreur: TLabel;
    lbl_filiere: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_releve: TLabel;
    lbl_mel: TLabel;
    lbl_adresse: TLabel;
    lbl_contact: TLabel;
    lbl_numero: TLabel;
    lbl_nom: TLabel;
    lbl_adr: TLabel;
    lbl_telephone: TLabel;
    lbl_portable: TLabel;
    lbl_codefiliere: TLabel;
    lbl_ville: TLabel;
    lbl_code: TLabel;
    lbl_prenom: TLabel;
    lbl_ident: TLabel;
    mmo_filiere: TMemo;
    pnl_notes_liste: TPanel;
    pnl_releve: TPanel;
    pnl_adresse: TPanel;
    pnl_filiere: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_contact: TPanel;
    pnl_titre: TPanel;
    pnl_btn: TPanel;
    sg_liste: TStringGrid;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure btn_validerClick(Sender: TObject);
    procedure cbo_codefiliereExit(Sender: TObject);
    procedure edt_numeroExit(Sender: TObject);
    procedure init (id_inscr : string; affi : boolean);
    procedure detail (id_inscr : string);
    procedure edit (id_inscr : string);
    procedure add;
    procedure delete (id_inscr : string);
    procedure edt_Enter (Sender : TObject );

  private
    procedure affi_page;
    procedure affi_filiere (num : string);
    function  affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
    function  affi_erreur_saisie_cbo (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;


    { private declarations }
  public
    { public declarations }
  end;

var
  f_detail_etudiant: Tf_detail_etudiant;

implementation

{$R *.lfm}

uses u_feuille_style, u_select_etudiant, u_list_etudiant,
     u_notes_list, u_modele, u_loaddataset;

{ Tf_detail_etudiant }

var
   oldvaleur : string; // utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
   id : string; // variable active dans toute l'unité, contenant l'id étudiant affichée

procedure Tf_detail_etudiant.Init ( id_inscr : string; affi : boolean);
// affichage détail d'une étudiant : affi est vrai sinon affi est faux
begin
style.panel_travail (pnl_titre);
style.panel_travail (pnl_btn);
style.panel_travail (pnl_detail);
  style.panel_travail (pnl_ident);
     style.label_titre (lbl_ident);
     style.label_erreur (lbl_numero_erreur);       lbl_numero_erreur.Caption :='';
     style.label_erreur (lbl_nom_erreur);          lbl_nom_erreur.Caption :='';
     style.label_erreur (lbl_prenom_erreur);       lbl_prenom_erreur.Caption :='';
  style.panel_travail (pnl_adresse);
     style.label_titre (lbl_adresse);
     style.label_erreur (lbl_adr_erreur);          lbl_adr_erreur.Caption :='';
     style.label_erreur (lbl_code_erreur);         lbl_code_erreur.Caption :='';
     style.label_erreur (lbl_ville_erreur);        lbl_ville_erreur.Caption :='';
  style.panel_travail (pnl_contact);
     style.label_titre (lbl_contact);
     style.label_erreur (lbl_tel_erreur);          lbl_tel_erreur.Caption :='';
     style.label_erreur (lbl_mel_erreur);          lbl_mel_erreur.Caption :='';
  style.panel_travail (pnl_filiere);
     style.label_titre (lbl_filiere);
     style.label_erreur (lbl_codefiliere_erreur);  lbl_codefiliere_erreur.Caption :='';
     style.memo_info (mmo_filiere);
  style.panel_travail (pnl_releve);
     style.label_titre (lbl_releve);
     style.grille (sg_liste);

//initialisation IDENTIFICATION
  lbl_numero_erreur.caption := '';
  lbl_nom_erreur.caption    := '';
  lbl_prenom_erreur.caption := '';
  edt_numero.Clear;
  edt_nom.Clear;
  edt_prenom.Clear;
  edt_numero.ReadOnly      :=affi;
  cbo_genre.ReadOnly       :=affi;
  cbo_genre.enabled        :=false;
  edt_nom.ReadOnly         :=affi;
  edt_prenom.ReadOnly      :=affi;

//initialisation ADRESSE
  lbl_adr_erreur.caption     := '';
  lbl_code_erreur.caption    := '';
  lbl_ville_erreur.caption   := '';
  edt_adr.Clear;
  edt_cp.Clear;
  edt_ville.Clear;
  edt_adr.ReadOnly          :=affi;
  edt_cp.ReadOnly           :=affi;
  edt_ville.ReadOnly        :=affi;

//initialisation CONTACT
  lbl_tel_erreur.caption    := '';
  lbl_mel_erreur.caption    := '';
  edt_numero1.Clear;
  edt_numero2.Clear;
  edt_mel.Clear;
  edt_numero1.ReadOnly     :=affi;
  edt_numero2.ReadOnly     :=affi;
  edt_mel.ReadOnly         :=affi;

//initialisation FILIERE
  lbl_codefiliere_erreur.caption   := '';
  cbo_codefiliere.ReadOnly :=affi;
  cbo_codefiliere.enabled :=false;
  mmo_filiere.Clear;
  mmo_filiere.ReadOnly     :=true;

  btn_retour.visible      :=affi;
  btn_valider.visible     :=NOT affi;
  btn_annuler.visible     :=NOT affi;

//initialisation RELEVE DE NOTES
  f_notes_list.borderstyle := bsNone;
  f_notes_list.parent      := pnl_notes_liste;
  f_notes_list.align       := alClient;
  f_notes_list.init(affi);
  f_notes_list.show;

  show;

  id  := id_inscr;
  IF  NOT  ( id = '')   // affichage/modification infraction
  THEN  affi_page;

end;

procedure Tf_detail_etudiant.affi_filiere (num : string);
var
   ch : string;
begin
  mmo_filiere.clear;
  if num = ''
  then mmo_filiere.lines.add('Filière non identifiée.')
  else begin
       ch := modele.etudiant_filiere(num);
       if ch ='' then mmo_filiere.lines.add('Filière inconnue.')
       else mmo_filiere.lines.text := ch;
  end;
end;

function Tf_detail_etudiant.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
  lbl.caption := erreur;
  if NOT (erreur = '')
  then begin
  edt.setFocus;
  result := false;
  end
  else result := true;
end;

function Tf_detail_etudiant.affi_erreur_saisie_cbo (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;
begin
  lbl.caption := erreur;
  if NOT (erreur = '')
  then begin
  cbo.setFocus;
  result := false;
  end
  else result := true;
end;

procedure Tf_detail_etudiant.affi_page;
var
   flux : TLoadDataSet;
begin
  flux := modele.etudiant_num(id);
  flux.read;
  edt_numero.text := flux.Get('id');
  cbo_genre.text := flux.Get('civ');
  edt_nom.text := flux.Get('nom');
  edt_prenom.text := flux.Get('prenom');
  edt_adr.text := flux.Get('adresse');
  edt_cp.text := flux.Get('cp');
  edt_ville.text := flux.Get('ville');
  edt_numero1.text := flux.Get('telephone');
  edt_numero2.text := flux.Get('portable');
  edt_mel.text := flux.Get('mel');
  cbo_codefiliere.text := flux.Get('code_filiere');

  affi_filiere (cbo_codefiliere.text);
  f_notes_list.affi_data(modele.liste_notes(edt_numero.text));
  lbl_releve.Caption := ('   RELEVÉ DE NOTES - Moyenne étudiant : ' +modele.moy_inscrit(edt_numero.text)+
                      ' - Moyenne filière : ' +modele.moy_filiere(flux.Get('id_fil'))+ ' ');
  flux.destroy;
end;

procedure Tf_detail_etudiant.detail (id_inscr : string);
begin
  init (id_inscr, true); // mode affichage
  pnl_titre.caption := 'Détail d''une inscription';
  btn_retour.setFocus;
end;

procedure Tf_detail_etudiant.edit (id_inscr : string);
begin
  init (id_inscr, false);
  pnl_titre.caption := 'Modification d''une inscription';
  edt_numero.ReadOnly := true;
  edt_nom.setFocus;
  cbo_genre.enabled :=true;
  cbo_codefiliere.enabled :=false;
end;

procedure Tf_detail_etudiant.add;
begin
  init ('',false); // pas de numéro d'étudiant
  pnl_titre.caption := 'Nouvelle inscription';
  edt_numero.setFocus;
  lbl_releve.Caption := ('   RELEVÉ DE NOTES                  ');
  cbo_genre.enabled :=true;
  cbo_codefiliere.enabled :=true;
end;

procedure Tf_detail_etudiant.delete (id_inscr : string);
begin
   IF   messagedlg ('Demande de confirmation'
  ,'Confirmez-vous la suppression de l''étudiant n°' +id_inscr
  ,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
   THEN BEGIN
        modele.etudiant_delete(id_inscr);
        f_list_etudiant.line_delete;
   END;
end;

procedure Tf_detail_etudiant.btn_retourClick(Sender: TObject);
begin
  Close;
  f_select_etudiant.show;
end;

procedure Tf_detail_etudiant.btn_validerClick(Sender: TObject);
var
  flux : TLoadDataSet;
  saisie, saisie2, erreur, ch : string;
  i : integer;
  valide : boolean;

begin
  valide := true;
// Test validité saisie dans l'ordre inverse

// Code filière existe + obligatoire
  erreur := '';
  saisie := cbo_codefiliere.text;
  if saisie = '' then erreur := 'La filière doit être renseignée.'
  else begin
    ch := modele.etudiant_filiere(saisie);
    if ch = '' then erreur := 'Filière inexistante.';
  end;
  valide := affi_erreur_saisie_cbo (erreur, lbl_codefiliere_erreur, cbo_codefiliere) AND valide;

// Mel obligatoire
   erreur := '';
   saisie := edt_mel.text;
   if saisie = '' then erreur := 'L''adresse mel doit être remplie.';
   valide := affi_erreur_saisie (erreur, lbl_mel_erreur, edt_mel) AND valide;

// Numéro téléphone fix + portable (1 des 2 obligatoire)
  erreur := '';
  saisie := edt_numero1.text;
  saisie2 := edt_numero2.text;
  if (saisie = '') AND (saisie2 = '') then erreur := 'Le téléphone ou le portable doit être rempli.';
  valide := affi_erreur_saisie (erreur, lbl_tel_erreur, edt_numero1) AND valide;
  valide := affi_erreur_saisie (erreur, lbl_tel_erreur, edt_numero2) AND valide;

// Ville obligatoire
   erreur := '';
   saisie := edt_ville.text;
   if saisie = '' then erreur := 'La ville doit être remplie.';
   valide := affi_erreur_saisie (erreur, lbl_ville_erreur, edt_mel) AND valide;

// Code postal obligatoire
   erreur := '';
   saisie := edt_cp.text;
   if saisie = '' then erreur := 'Le code postal doit être rempli.';
   valide := affi_erreur_saisie (erreur, lbl_code_erreur, edt_cp) AND valide;

// Adresse obligatoire
   erreur := '';
   saisie := edt_adr.text;
   if saisie = '' then erreur := 'L''adresse doit être remplie.';
   valide := affi_erreur_saisie (erreur, lbl_adr_erreur, edt_adr) AND valide;

// Prénom obligatoire
   erreur := '';
   saisie := edt_prenom.text;
   if saisie = '' then erreur := 'Le prénom doit être rempli.';
   valide := affi_erreur_saisie (erreur, lbl_prenom_erreur, edt_prenom) AND valide;

// Nom obligatoire
   erreur := '';
   saisie := edt_nom.text;
   if saisie = '' then erreur := 'Le nom doit être rempli.';
   valide := affi_erreur_saisie (erreur, lbl_nom_erreur, edt_nom) AND valide;

// ID obligatoire + ne doit pas exister
   if id = ''
   then begin
     erreur := '';
     saisie := edt_numero.text;
     if saisie = '' then erreur := 'Le numéro doit être rempli.'
     else begin
       flux := modele.etudiant_num(saisie);
       if NOT flux.endOf
       then erreur := 'Le numéro existe déjà';
   end;
   valide := affi_erreur_saisie (erreur, lbl_numero_erreur, edt_numero) AND valide;
   end;

   if NOT valide
   then messagedlg ('Erreur enregistrement étudiant'
                   ,'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.'
                   , mtWarning, [mbOk], 0)
   else begin
   // sauvegarde des données
     if id = ''
     then modele.etudiant_insert(edt_numero.text, cbo_genre.text, edt_nom.text, edt_prenom.text,
                                 edt_adr.text, edt_cp.text, edt_ville.text,
                                 edt_numero1.text, edt_numero2.text, edt_mel.text, cbo_codefiliere.text)
     else begin
          modele.etudiant_update(edt_numero.text, cbo_genre.text, edt_nom.text, edt_prenom.text,
                                 edt_adr.text, edt_cp.text, edt_ville.text,
                                 edt_numero1.text, edt_numero2.text, edt_mel.text);
     end ;

     f_detail_etudiant.close;
     f_select_etudiant.show;
     f_list_etudiant.affi_data(modele.etudiant_liste_tous)
   end;
end;

procedure Tf_detail_etudiant.cbo_codefiliereExit(Sender: TObject);
begin
  cbo_codefiliere.text := TRIM(cbo_codefiliere.text);
  IF NOT ( cbo_codefiliere.text = oldvaleur )
  THEN affi_filiere (cbo_codefiliere.text);
end;

procedure Tf_detail_etudiant.btn_annulerClick(Sender: TObject);
begin
  Close;
  f_select_etudiant.show;
end;

procedure Tf_detail_etudiant.edt_numeroExit(Sender: TObject);
begin
  edt_numero.text := TRIM(edt_numero.text);
end;

procedure Tf_detail_etudiant.edt_Enter(Sender : TObject);
begin
  oldvaleur := TEdit(Sender).text;
end;

end.

