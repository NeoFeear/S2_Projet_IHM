unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_loaddataset;

type
Tmodele = class(TMySQL)
   private
   { private declarations }
   public
   { public declarations }
   procedure open;
   procedure close;
   function  etudiant_liste_tous : TLoadDataSet;
   function  etudiant_liste_etudiant (numero, nom : string) : TLoadDataSet;
   function  etudiant_liste_filiere (code : string) : TLoadDataSet;

   function  liste_notes (num : String) : TLoadDataSet;

   function  etudiant_num (num : String) : TLoadDataSet;
   function  etudiant_filiere (num : String) : String;
   function  moy_inscrit (num : string) : String;
   function  moy_filiere (num : string) : String;

   procedure etudiant_delete (id : String);
   procedure etudiant_insert (id,civ,nom,prenom,adresse,cp,ville,telephone,portable,mel,code_filiere : String);
   procedure etudiant_update (id,civ,nom,prenom,adresse,cp,ville,telephone,portable,mel : string);

end;

var
     modele: Tmodele;

implementation

procedure Tmodele.open;
begin
Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0, 'martin776u_projetihm', 'martin776u_appli', '31905216', 'mysqld-5', 'libmysql64.dll');
end;

procedure Tmodele.close;
begin
Bd_close;
end;

//////////////////////////////// LISTES ////////////////////////////////

//Tous les étudiant
function Tmodele.etudiant_liste_tous : TLoadDataSet;
begin
     result := load('sp_etudiant_liste_tous',[]);
end;

//Liste par ID ou nom
function Tmodele.etudiant_liste_etudiant (numero, nom : string) : TLoadDataSet;
begin
     result := load('sp_etudiant_liste_etudiant',[numero,nom]);
end;

//Liste par filière
function Tmodele.etudiant_liste_filiere (code : string) : TLoadDataSet;
begin
     result := load('sp_etudiant_liste_filiere',[code]);
end;

////////////////////////////// DONNEES //////////////////////////////

//Données d'un étudiant
function Tmodele.etudiant_num (num : string) : TLoadDataSet;
begin
     result := load('sp_etudiant_num',[num]);
end;

//Afficher filière
function Tmodele.etudiant_filiere (num : string) : String;
begin
     load('sp_etudiant_filiere',[num], result);
end;

//Afficher moyenne étudiant
function Tmodele.moy_inscrit (num : string) : String;
begin
     load('sp_moy_inscrit',[num], result);
end;

//Afficher moyenne filière
function Tmodele.moy_filiere (num : string) : String;
begin
     load('sp_moy_filiere',[num], result);
end;

//Tableau des notes
function Tmodele.liste_notes (num : string) : TLoadDataSet;
begin
     result := load('sp_notes',[num]);
end;

//Supprimer des notes en même temps qu'un étudiant


//Supprimer un étudiant + ses notes
procedure Tmodele.etudiant_delete (id : string);
begin
exec('sp_etudiant_delete',[id]);
end;

//Insérer un étudiant
procedure Tmodele.etudiant_insert (id,civ,nom,prenom,adresse,cp,ville,telephone,portable,mel,code_filiere : string);
begin
exec('sp_etudiant_insert',[id,civ,nom,prenom,adresse,cp,ville,telephone,portable,mel,code_filiere]);
end;

//Mettre à jour un étudiant
procedure Tmodele.etudiant_update (id,civ,nom,prenom,adresse,cp,ville,telephone,portable,mel : string);
begin
exec('sp_etudiant_update',[id], [civ,nom,prenom,adresse,cp,ville,telephone,portable,mel]);
end;

begin
modele := TModele.Create;

end.

