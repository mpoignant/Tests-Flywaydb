--DROP TABLE utilisateur;
--DROP SEQUENCE utilisateur_seq;

CREATE TABLE utilisateur
(
  id integer NOT NULL,
  adresse character varying(255),
  nom character varying(255),
  prenom character varying(255),
  codepostal integer,
  ville text,
  pays text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE utilisateur
  OWNER TO postgres;

CREATE SEQUENCE utilisateur_seq;

UPDATE utilisateur SET id = nextval('utilisateur_seq');
ALTER TABLE utilisateur
  ALTER COLUMN id SET DEFAULT nextval('utilisateur_seq');
ALTER TABLE utilisateur
  ALTER COLUMN "id" SET NOT NULL;
ALTER TABLE utilisateur ADD UNIQUE ("id");
ALTER TABLE utilisateur ADD PRIMARY KEY ("id");

INSERT INTO utilisateur (adresse, nom, prenom, codepostal, ville, pays)
VALUES('50 avenue des Champs Elysées', 'Poignant', 'Mathieu', '75008', 'Paris', 'France');
	
INSERT INTO utilisateur (adresse, nom, prenom, codepostal, ville, pays)
VALUES('12 rue des râteaux', 'Dusse', 'Jean-Claude', '75001', 'Paris', 'France');

INSERT INTO utilisateur (adresse, nom, prenom, codepostal, ville, pays)
VALUES('1 avenue des plantes', 'Dupont', 'Pierre', '94700', 'Maisons Alfort', 'France');