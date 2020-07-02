create or replace view v_info_etudiant
as
select c.libelle as promotion, q.libelle as question, r.texte as commentaire,r.date,r.score,r.session_id
From reponse r
  inner join question q
  on r.question_id = q.id
  left join choix c
  on r.choix_id = c.id
where r.question_id > 3;

create or replace view v_question
AS
SELECT q.id AS id, q.libelle AS question, c.libelle AS promo, q.type AS type
FROM choix c
   JOIN page_condition pc
    ON c.id = pc.choix_id
   JOIN question q
    ON pc.page_id = q.page_id
where c.question_id = 14;


CREATE OR REPLACE VIEW v_etudiant
AS
SELECT CASE WHEN r.question_id = 3 THEN r.texte END AS Prenom,
	   CASE WHEN (r.question_id = 2) THEN r.texte END AS Nom
FROM session s
	inner JOIN reponse r
WHERE s.id = r.session_id
aND r.question_id IN (2 , 3);
