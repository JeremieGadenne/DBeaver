

/* Vidage de la table */
TRUNCATE TABLE DVA ;


/* Remplissage de l'année 2024 */
INSERT INTO DVA 
SELECT NULL, r.member_id, 3, '2024-12-08', 2, '2024-12-08 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15284 -- Sortie Brigitte CORAT
UNION
SELECT NULL, r.member_id, 3, '2024-12-15', 2, '2024-12-15 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15285; -- Sortie Frédéric FAVIER

