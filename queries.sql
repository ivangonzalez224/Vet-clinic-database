/* Queries that provide answers to the questions from the project requirements. */

--Find all animals whose name ends in "mon":

SELECT * FROM animals WHERE NAME LIKE '%_mon';

-----------------------------------------------------------

-- List the name of all animals born between 2016 and 2019:

SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' 
 AND  date_of_birth <=  '2019-12-31';

-----------------------------------------------------------

--List the name of all animals that are neutered and have less than 3 escape attempts:

SELECT name FROM animals WHERE neutered >= TRUE 
 AND  ESCAPE_ATTEMPTS <  3;

-----------------------------------------------------------

--List the date of birth of all animals named either "Agumon" or "Pikachu":

SELECT DATE_OF_BIRTH FROM animals WHERE name IN ('Agumon', 'Pikachu');

-----------------------------------------------------------

--List name and escape attempts of animals that weigh more than 10.5kg:

SELECT NAME, ESCAPE_ATTEMPTS FROM animals WHERE WEIGHT_KG > 10.5;

-----------------------------------------------------------

-- Find all animals that are neutered:

SELECT * FROM animals WHERE neutered = TRUE;

-----------------------------------------------------------

-- Find all animals not named Gabumon:

SELECT * from animals WHERE name NOT IN ('Gabumon');

-----------------------------------------------------------

Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg):

SELECT * FROM animals WHERE WEIGHT_KG BETWEEN 10.4 AND 17.3;

---------------------------------------------------------

-- Setting the species column to unspecified in a transaction
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;

-- Went back to the state before the transaction.
ROLLBACK;
SELECT * FROM animals;

-----------------------------------------------------------------

-- Setting the species column to digimon for all animals that have a 
-- name ending in mon and to pokemon for the remain animals
BEGIN;
UPDATE animals SET species = 'digimon' WHERE NAME LIKE '%_mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-----------------------------------------------------------------

-- Delete all records in the animals, then roll back the transaction.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-----------------------------------------------------------------

BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
-- Create a savepoint for the transaction and update all animals' weight to be their weight multiplied by -1
SAVEPOINT weight_minus;
UPDATE animals SET WEIGHT_KG = WEIGHT_KG * -1;
SELECT * FROM animals;
-- Rollback to the savepoint and update all animals' weights that are negative to be their weight multiplied by -1.
ROLLBACK TO weight_minus;
UPDATE animals SET WEIGHT_KG = WEIGHT_KG * -1 WHERE WEIGHT_KG < 0;
COMMIT;
SELECT * FROM animals;

------------------------------------------------------------------

-- How many animals are there?

SELECT COUNT(*) as total_animals FROM animals;

-- How many animals have never tried to escape?

SELECT ESCAPE_ATTEMPTS, COUNT(NAME)
FROM animals WHERE ESCAPE_ATTEMPTS = 0 GROUP BY ESCAPE_ATTEMPTS;

-- What is the average weight of animals?

SELECT AVG(WEIGHT_KG) as AVG_WEIGHT_KG FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(ESCAPE_ATTEMPTS) as TOTAL_ESCAPES
FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(WEIGHT_KG) as MIN_WEIGHT_KG,  MAX(WEIGHT_KG) as MAX_WEIGHT_KG
FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those 
-- born between 1990 and 2000?

SELECT species, AVG(ESCAPE_ATTEMPTS) as AVG_ESCAPES
FROM animals WHERE date_of_birth >= '1990-01-01' 
AND  date_of_birth <=  '2000-12-31' GROUP BY species;

------------------------------------------------------------------

-- What animals belong to Melody Pond?
SELECT NAME AS animal_name, full_name AS owner_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon
SELECT animals.name AS animal_name, species.name AS specie
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal.
SELECT full_name AS owner_name, name AS animal_name
FROM owners 
LEFT JOIN animals 
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name AS specie,  COUNT(animals.name) AS total_animals
FROM animals 
LEFT JOIN species 
ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS animal_name, full_name AS owner_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
INNER JOIN species
ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' and species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name AS animal_name, full_name AS owner_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE escape_attempts = 0 and full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT full_name AS owner_name, COUNT(owner_id) AS total_animals
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id 
GROUP BY full_name;
 