

/* Vidage de la table */
TRUNCATE TABLE DVA ;


/* Remplissage de l'année 2024 */
INSERT INTO DVA 
SELECT NULL, r.member_id, 3, '2024-12-08', 2, '2024-12-08 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15284
AND r.status = 1; -- Sortie Brigitte CORAT

INSERT INTO DVA 
SELECT NULL, r.member_id, 3, '2024-12-15', 2, '2024-12-15 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 15285
AND r.status = 1; -- Sortie Frédéric FAVIER

/* Remplissage de l'année 2023 */
INSERT INTO DVA
SELECT NULL, r.member_id, 3, '2023-12-10', 2, '2023-12-10 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 14955 
AND r.status = 1; -- Sortie Fabien OUILLON

INSERT INTO DVA
SELECT NULL, r.member_id, 3, '2023-12-17', 2, '2023-12-17 21:00:00.000', NULL  FROM program p JOIN caf2_program_registration r ON r.program_id  = p.id 
WHERE p.id = 14989
AND r.status = 1 ; -- Sortie Yann QUILLARD

--TEST

