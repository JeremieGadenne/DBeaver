create table TInscriptions 
WITH CoEnc AS (
    SELECT member_id, base_program_id 
    FROM caf2_program_cosupervisor co 
    JOIN supervisor s ON s.id = co.supervisor_id
),
TNombre AS (
    SELECT p.id AS idSortie, COUNT(*) AS NbTotal 
    FROM program p 
    JOIN caf2_program_registration r ON r.program_id = p.id 
    WHERE status = 1 
    GROUP BY p.id
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY p.id, c1.id) AS idVue,  -- identifiant artificiel
    p.id AS idSortie, 
    a.name AS Commission, 
    p.title AS NomSortie, 
    p.starts_on AS DateDebut, 
    p.ends_on AS DateFin, 
    p.duration AS NbJours, 
    p.duration_hours AS Durée, 
    TNombre.NbTotal, 
    p.maximum_registrations AS NbMax, 
    c1.id AS idMembre, 
    c1.last_name, 
    c1.first_name, 
    CASE 
        WHEN (CoEnc.member_id IS NOT NULL) THEN 'Coencadrant' 
        WHEN c2.id = c1.id THEN 'Encadrant' 
        ELSE 'Inscrit' 
    END AS Role,
    CASE r.status 
        WHEN 1 THEN 'Accepté' 
        WHEN 2 THEN 'Refusé' 
        WHEN 5 THEN 'Désisté' 
    END AS StatusLibelle,
    r.status
FROM program p 
LEFT JOIN activity a ON a.id = p.activity_id 
LEFT JOIN caf2_program_registration r ON r.program_id = p.id
LEFT JOIN caf2_member c1 ON c1.id  = r.member_id
LEFT JOIN caf2_guest g ON g.id = r.guest_id
LEFT JOIN supervisor s1  ON s1.id = p.supervisor_id
LEFT JOIN caf2_member c2 ON c2.id  = s1.member_id
LEFT JOIN CoEnc ON CoEnc.base_program_id = p.id AND r.member_id  = CoEnc.member_id
LEFT JOIN TNombre ON idSortie = p.id
WHERE p.canceled  = 0
and p.id	= 16101