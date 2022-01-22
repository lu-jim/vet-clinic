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
SELECT A.name,
  S.name
FROM animals A
  JOIN species S ON A.species_id = S.id
  JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell'
  AND S.name = 'Digimon'
GROUP BY A.name,
  S.name;
SELECT A.name,
  A.escape_attempts
FROM animals A
  JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester'
  AND A.escape_attempts = 0
GROUP BY A.name,
  A.escape_attempts;
SELECT O.full_name,
  COUNT(*)
FROM animals A
  INNER JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY COUNT(*) DESC;
/* Add "join table" for visits */
/* Who was the last animal seen by William Tatcher? */
SELECT a.name,
  vi.date_of_visit,
  ve.name
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
WHERE ve.name = 'William Tatcher'
ORDER BY vi.date_of_visit DESC;
/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(DISTINCT a.id)
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
WHERE ve.id = 3;
/* List all vets and their specialties, including vets with no specialties. */
SELECT v.name,
  sp.name
FROM vets v
  LEFT JOIN specializations sl ON v.id = sl.vet_id
  LEFT JOIN species sp ON sl.species_id = sp.id
GROUP BY v.name,
  sp.name;
/* Animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT a.name,
  vi.date_of_visit,
  ve.name
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
WHERE ve.id = 3
  AND date_of_visit > '2020-04-01'
  AND date_of_visit < '2020-08-30'
ORDER BY vi.date_of_visit DESC;
/* What animal has the most visits to vets? */
SELECT a.name,
  COUNT(*)
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
GROUP BY a.name
ORDER BY COUNT(*) DESC
LIMIT 1;
/*Who was Maisy Smith's first visit? */
SELECT a.name as animal_name,
  vi.date_of_visit
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
WHERE ve.id = 2
ORDER BY vi.date_of_visit ASC
LIMIT 1;
/*Details for most recent visit */
SELECT *
FROM animals a
  JOIN visits vi ON a.id = vi.animal_id
  JOIN vets ve ON ve.id = vi.vet_id
ORDER BY vi.date_of_visit DESC
LIMIT 1;
/* How many visits were with a vet that did not specialize in that animal's species*/
SELECT vi.date_of_visit,
  vets.name as vets,
  a.name as animal_name,
  a.species_id,
  sl.species_id as specializations
FROM visits vi
  JOIN animals a ON vi.animal_id = a.id
  JOIN species sp ON a.species_id = sp.id
  JOIN vets ON vi.vet_id = vets.id
  LEFT JOIN specializations sl ON vets.id = sl.vet_id
GROUP BY vi.date_of_visit,
  vets.name,
  a.name,
  a.species_id,
  sl.species_id;
/* What specialty should Maisy Smith consider getting?*/
SELECT y.name,
  COUNT(*)
FROM (
    SELECT sp.name as name,
      vi.date_of_visit
    FROM visits vi
      JOIN vets ve ON vi.vet_id = ve.id
      JOIN animals a ON a.id = vi.animal_id
      JOIN species sp ON a.species_id = sp.id
    WHERE vi.vet_id = 2
  ) y
GROUP BY y.name;