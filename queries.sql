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

----------------------------------------------------------------- 

-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS animal_name, vets.name AS vet_name, MAX(date_of_visit) AS last_visit
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
GROUP BY vets.name, animals.name
ORDER BY last_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name AS vet_name, COUNT(visits.animal_id) AS total_animals_seing
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name, species.name AS speciality
FROM vets 
LEFT JOIN specializations 
ON vets.id = specializations.vet_id
LEFT JOIN species 
ON species.id = specializations.specie_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name, vets.name AS vet_name, date_of_visit
FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30'
GROUP BY vets.name, animals.name, date_of_visit;

-- What animal has the most visits to vets?
SELECT animals.name AS animal_name, COUNT(visits.animal_id) AS total_visits
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id 
GROUP BY animals.name
ORDER BY total_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal_name, vets.name AS vet_name, MIN(date_of_visit) AS first_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, vets.name
ORDER BY first_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, date_of_birth, ESCAPE_ATTEMPTS, neutered, weight_kg, species.name AS especie, full_name AS owner_name, vets.name AS vet_name, vets.age AS vet_age, date_of_graduation, MAX(date_of_visit) AS most_recent_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
INNER JOIN owners
ON owners.id = animals.owner_id
INNER JOIN species
ON species.id = animals.species_id
GROUP BY animals.name, vets.name, date_of_birth, ESCAPE_ATTEMPTS, neutered, weight_kg, especie, full_name, vets.age, date_of_graduation 
ORDER BY most_recent_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS total_visits
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
LEFT JOIN specializations
ON specializations.vet_id = vets.id AND animals.species_id = specializations.specie_id
WHERE specializations.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name AS vet_name, species.name AS specie, COUNT(visits.animal_id) AS total_visits_get
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN species
ON species.id = animals.species_id
LEFT JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name, vets.name
ORDER BY total_visits_get DESC
LIMIT 1;

-- Create index for the animal_id column
CREATE INDEX animals_index ON visits(animal_id);

-- Create index for the vet_id colunm in the visits table
CREATE INDEX vet_id_index ON visits (vet_id);

-- Create index for the email colunm in the owners table
CREATE INDEX owners_email_index ON owners(email);
