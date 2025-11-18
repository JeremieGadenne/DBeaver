TRUNCATE TABLE tinscriptions;

INSERT INTO tinscriptions (idSortie, Commission, NomSortie, Nom, Prenom, DateDebut, DateFin, NbJours, Duree, Nbmax, StatusLibelle, Status, idMembre)
SELECT p.id, a.name, p.title, c1.last_name, c1.first_name , p.starts_on, p.ends_on, p.duration, p.duration_hours, p.maximum_registrations, 
    CASE r.status 
	    when 0 then 'Attente'    
	    WHEN 1 THEN 'Accepté' 
	    WHEN 3 THEN 'Refusé' 
	    when 4 then 'Absent'
	    WHEN 5 THEN 'Désisté' 
    end, 
    status, 
    c1.id
FROM program p 
LEFT JOIN activity a ON a.id = p.activity_id 
LEFT JOIN caf2_program_registration r ON r.program_id = p.id
LEFT JOIN caf2_member c1 ON c1.id  = r.member_id
LEFT JOIN caf2_guest g ON g.id = r.guest_id
LEFT JOIN supervisor s1  ON s1.id = p.supervisor_id
LEFT JOIN caf2_member c2 ON c2.id  = s1.member_id
WHERE p.canceled = 0;


/* Casse du prénom */
UPDATE TInscriptions t SET Prenom = CONCAT(UCASE(LEFT(Prenom, 1)), LCASE(SUBSTRING(Prenom, 2)));

/* Mise à jour du nombre réel de participants */
UPDATE tinscriptions t JOIN (SELECT p.id AS idSortie, COUNT(*) AS Compteur  FROM program p JOIN caf2_program_registration r ON r.program_id = p.id  WHERE r.status = 1 GROUP BY p.id) 
AS cte ON t.idSortie = cte.idSortie SET t.NbReel = cte.Compteur;

/* Mise à jour du nombre total de participants */
UPDATE tinscriptions t JOIN (SELECT p.id AS idSortie, COUNT(*) AS Compteur  FROM program p JOIN caf2_program_registration r ON r.program_id = p.id GROUP BY p.id) 
AS cte ON t.idSortie = cte.idSortie SET t.NbTotal = cte.Compteur;

/* Mise à jour du sexe */
UPDATE tInscriptions t JOIN (SELECT cm.id AS id, CASE civility WHEN 'M' THEN 'H' ELSE 'F' END AS Sexe FROM caf2_ffcam_member cfm JOIN caf2_member cm ON CONCAT(cfm.license12, cfm.license_key) = CONCAT(cm.license, cm.license_key))
AS cte ON t.idMembre = cte.id SET t.Sexe = cte.Sexe;

/* Mise à jour du CREATEUR */
UPDATE tInscriptions t JOIN (SELECT p.id, s.member_id, cm.last_name , cm.first_name  FROM program p JOIN supervisor s ON s.id = p.supervisor_id JOIN caf2_member cm ON cm.id = s.member_id )
AS cte ON t.idSortie = cte.id SET Createur = CONCAT (last_name, ' ', first_name); 


/* Mise à jour du rôle ENCADRANT */
UPDATE tInscriptions t JOIN (SELECT p.id, s.member_id  FROM program p JOIN supervisor s ON s.id = p.supervisor_id)
AS cte ON t.idSortie = cte.id AND idMembre = member_id  SET ROLE = 'encadrant' ; 

/* Mise à jour du rôle CO-ENCADRANT */
UPDATE tInscriptions t JOIN (SELECT p.id, s.member_id FROM program p JOIN caf2_program_cosupervisor cpc ON cpc.base_program_id  = p.id JOIN supervisor s ON s.id = cpc.supervisor_id)
AS cte ON t.idSortie = cte.id AND idMembre = member_id   SET Role = 'coEncadrant';

/* Mise à jour du rôle MEMBRE */
UPDATE tInscriptions t SET ROLE	= 'inscrit' WHERE ROLE IS NULL;	

/* Mise à jour de la saison du 01/10 au 30/09 */
UPDATE tInscriptions t 
SET Saison = CONCAT(
    YEAR(DateDebut) + IF(DateDebut >= DATE_ADD(DATE(CONCAT(YEAR(DateDebut), '-01-01')), INTERVAL 9 MONTH), 0, -1),
    '/',
    YEAR(DateDebut) + IF(DateDebut >= DATE_ADD(DATE(CONCAT(YEAR(DateDebut), '-01-01')), INTERVAL 9 MONTH), 0, -1) + 1
);
 


select * from tinscriptions t
WHERE idSortie  = 16049
AND status = 1

CREATE VIEW AS 
SELECT idSortie, Commission, Createur AS Createur, CONCAT (NomSortie, ' / ',idSortie) AS NomSortie , DateDebut, DateFin, nbJours AS Duree, NbReel AS NbInscrits, NbMax, Nom, Prenom, Sexe AS Genre, ROLE, Status AS Statut, Saison, CONCAT (Nom, ' ', Prenom) AS NomPrenom
FROM TInscriptions 
WHERE Commission IN ('Marche Nordique', 'Randonnée Pédestre', 'Ski de Randonnée', 'Raquettes', 'Ski de Fond', 'Alpinisme', 'Via Ferrata', 'Vélo de Montagne', 'Randonnée Alpine', 'Escalade', 'Trail', 'Nettoyage')





SELECT * FROM caf2_ffcam_member cfm WHERE email  = 'ziorchir7@yahoo.fr'


DELETE FROM caf2_member_dvatraining cmd ;

INSERT INTO caf2_member_dvatraining 
SELECT NULL, r.member_id, 3, '2024-12-08', 2, '2024-12-08 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15284
UNION
SELECT NULL, r.member_id, 3, '2024-12-15', 2, '2024-12-15 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15285;

SELECT * FROM caf2_member_dvatraining cmd

