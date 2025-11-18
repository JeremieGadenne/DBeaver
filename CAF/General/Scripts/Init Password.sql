-- Réinitialise le passaword à mdp1234

SELECT * FROM caf2_member WHERE last_name = 'GABRIEL'

UPDATE caf2_member cm SET password = '$2b$13$UQ9wHgqeg0m1Ec1TJHDz7evn60PskpYBfmZc5iDgMj0vX2qm5lZBa'
 WHERE last_name = 'GABRIEL'
 
 