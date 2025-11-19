SELECT r.id, m.last_name, r.payment_amount FROM caf2_program_registration r JOIN caf2_member m ON m.id = r.member_id 
WHERE r.program_id  = 16396
