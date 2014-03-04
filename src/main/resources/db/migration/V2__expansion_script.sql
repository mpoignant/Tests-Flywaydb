--ALTER TABLE utilisateur DROP CONSTRAINT adresse_fkey;
--ALTER TABLE utilisateur DROP COLUMN idadresse;
--DROP TABLE adresse;
--DROP SEQUENCE adresse_seq;

CREATE TABLE adresse
(
  id integer NOT NULL,
  adresse character varying(255),
  codepostal integer,
  ville text,
  pays text,
  idutilisateur integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE adresse
  OWNER TO postgres;

CREATE SEQUENCE adresse_seq START 101;
UPDATE adresse SET id = nextval('adresse_seq');
ALTER TABLE adresse
  ALTER COLUMN id SET DEFAULT nextval('adresse_seq');
ALTER TABLE adresse
  ALTER COLUMN "id" SET NOT NULL;
ALTER TABLE adresse ADD UNIQUE ("id");
ALTER TABLE adresse ADD PRIMARY KEY ("id");

ALTER TABLE utilisateur 
	ADD COLUMN "idadresse" INTEGER;
ALTER TABLE utilisateur 
	ADD CONSTRAINT adresse_fkey FOREIGN KEY (idadresse) REFERENCES adresse (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

WITH RECURSIVE fk(idutilisateur, idadresse) AS(INSERT INTO adresse (adresse, codepostal, ville, pays, idutilisateur)
SELECT adresse, codepostal, ville, pays, id
FROM utilisateur RETURNING adresse.idutilisateur, adresse.id)
UPDATE utilisateur SET idadresse = fk.idadresse FROM fk WHERE id = fk.idutilisateur;

ALTER TABLE adresse
	DROP COLUMN idutilisateur;
