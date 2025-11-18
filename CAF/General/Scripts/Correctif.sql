UPDATE caf2_member AS cm
JOIN caf2_ffcam_member AS cfm 
    ON cfm.license12 = cm.license
SET 
    cm.email = cfm.email,
    cm.username = cfm.email
WHERE cm.username NOT LIKE '%@%';


select * from caf2_member where username not like '%@%'

select * from caf2_member where last_name = 'SIMONET'


select * from caf2_ffcam_member cfm where last_name = 'SIMONET'

