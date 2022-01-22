/* Database schema to keep the structure of entire database. */
DROP TABLE IF EXISTS species;
CREATE TABLE species (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name varchar(80) NOT NULL,
    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    full_name varchar(80) NOT NULL,
    age int,
    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name varchar(80) NOT NULL,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg real,
    species_id int REFERENCES species,
    owner_id int REFERENCES owners,
    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name varchar(80) NOT NULL,
    age int,
    date_of_graduation date,
    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
    vet_id int REFERENCES vets NOT NULL,
    animal_id int REFERENCES animals NOT NULL,
    PRIMARY KEY(vet_id, animal_id)
);
DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    vet_id int REFERENCES vets NOT NULL,
    animal_id int REFERENCES animals NOT NULL,
    date_of_visit varchar(80) NOT NULL,
    PRIMARY KEY(vet_id, animal_id)
);