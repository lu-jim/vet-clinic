/*Queries that provide answers to the questions from all projects.*/
SELECT *
from animals
WHERE name LIKE '%mon';
SELECT name
from animals
WHERE date_of_birth < '2020-01-01'
  AND date_of_birth > '2015-12-31';
SELECT name
from animals
WHERE neutered = TRUE
  AND escape_attempts < 3;
SELECT date_of_birth
from animals
WHERE name = 'Agumon'
  OR name = 'Pikachu';
SELECT name,
  escape_attempts
from animals
WHERE weight_kg > 10.5;
SELECT *
from animals
WHERE neutered = TRUE;
SELECT *
from animals
WHERE name != 'Gabumon';
SELECT *
from animals
WHERE weight_kg <= 17.3
  AND weight_kg > 10.4;
/* Query and update animals table */
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species = '';
COMMIT;
BEGIN;
DELETE FROM animals;
ROLLBACK;
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT first;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO first;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT COUNT(*)
FROM animals;
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;
SELECT avg(weight_kg)
from animals;
SELECT neutered,
  avg(escape_attempts)
from animals
GROUP BY neutered
ORDER BY avg(escape_attempts) DESC;
SELECT species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM animals
GROUP BY species_id;
SELECT species_id,
  avg(escape_attempts)
from animals
WHERE date_of_birth > '1989-12-31'
  AND date_of_birth < '2001-01-01'
GROUP BY species_id;