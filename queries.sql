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
SELECT name
FROM owners O
  JOIN animals A ON O.id = A.owner_id
WHERE full_name = 'Melody Pond';
SELECT A.name
FROM species S
  JOIN animals A ON S.id = A.species_id
WHERE S.name = 'Pokemon';
SELECT full_name,
  name
FROM owners O
  LEFT JOIN animals A ON O.id = A.owner_id;
SELECT S.name,
  COUNT(*)
FROM animals A
  INNER JOIN species S ON A.species_id = S.id
GROUP BY S.name;
SELECT A.name, S.name
FROM animals A
  JOIN species S ON A.species_id = S.id
  JOIN owners O ON A.owner_id = O.id  WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon'
GROUP BY A.name, S.name;
SELECT A.name, A.escape_attempts
FROM animals A
  JOIN owners O ON A.owner_id = O.id  WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0
GROUP BY A.name, A.escape_attempts;
SELECT O.full_name,
  COUNT(*)
FROM animals A
  INNER JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name ORDER BY COUNT(*) DESC;