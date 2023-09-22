/* Populate animals table with provided data. */

INSERT INTO animals (NAME,DATE_OF_BIRTH,ESCAPE_ATTEMPTS,neutered,WEIGHT_KG) VALUES 
   ('Agumon', '2020-02-03', 0, TRUE, 10.23 ),
   ('Gabumon', '2018-11-15', 2, TRUE, 8.00 ),
   ('Pikachu', '2021-01-07', 1, FALSE, 15.04 ),
   ('Devimon', '2017-05-12', 5, TRUE, 11.00 );

SELECT * FROM animals;

-- Insert new data into the animals table

INSERT INTO animals (NAME,DATE_OF_BIRTH,ESCAPE_ATTEMPTS,neutered,WEIGHT_KG) VALUES 
   ('Charmander', '2020-02-08', 0, FALSE, -11.00 ),
   ('Plantmon', '2021-11-15', 2, TRUE, -5.70 ),
   ('Squirtle', '1993-04-02', 3, FALSE, -12.13 ),
   ('Angemon', '2005-06-12', 1, TRUE, -45.00 ),
   ('Boarmon', '2005-06-07', 7, TRUE, 20.40 ),
   ('Blossom', '1998-10-13', 3, TRUE, 17.00 ),
   ('Ditto', '2022-05-14', 4, TRUE, 22.00 );

SELECT * FROM animals;

/* Populate owners table with provided data. */
INSERT INTO owners (full_name,age) VALUES 
   ('Sam Smith', 34 ),
   ('Jennifer Orwell', 19),
   ('Bob', 45),
   ('Melody Pond', 77),
   ('Dean Winchester', 14),
   ('Jodie Whittaker', 38);

SELECT * FROM owners;

/* Populate species table with provided data. */
INSERT INTO species (name) VALUES 
   ('Pokemon'),
   ('Digimon');

SELECT * FROM species;

-- Update animals table by inserting species_id values
BEGIN;
UPDATE animals SET species_id = 2 WHERE NAME LIKE '%_mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
COMMIT;

-- Update animals table by inserting owners_id values
BEGIN;
UPDATE animals
SET owner_id = (
	SELECT
		id
	FROM
		owners
	WHERE
		full_name = 'Sam Smith'
)
WHERE NAME = 'Agumon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (
	SELECT
		id
	FROM
		owners
	WHERE
		full_name = 'Jennifer Orwell'
)
WHERE NAME = 'Gabumon' OR NAME = 'Pikachu';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (
	SELECT
		id
	FROM
		owners
	WHERE
		full_name = 'Bob'
)
WHERE NAME = 'Devimon' OR NAME = 'Plantmon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (
	SELECT
		id
	FROM
		owners
	WHERE
		full_name = 'Melody Pond'
)
WHERE NAME = 'Charmander' OR NAME = 'Squirtle' OR NAME = 'Blossom';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = (
	SELECT
		id
	FROM
		owners
	WHERE
		full_name = 'Dean Winchester'
)
WHERE NAME = 'Angemon' OR NAME = 'Boarmon';
COMMIT;
SELECT * FROM animals;

-----------------------------------------------------

-- Insert data into the vets table
INSERT INTO vets (NAME,AGE,DATE_OF_GRADUATION) VALUES 
   ('William Tatcher', 45, '2000-04-23'),
   ('Maisy Smith', 26, '2019-06-17'),
   ('Stephanie Mendez', 64, '1981-05-04'),
   ('Jack Harkness', 38, '2008-06-08');

-- Insert data into the specializations table
INSERT INTO specializations (specie_id, vet_id)
SELECT species.id, vets.id FROM species, vets
WHERE species.name = 'Pokemon' AND vets.name = 'William Tatcher'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.name = 'Digimon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.name = 'Pokemon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT species.id, vets.id FROM species, vets
WHERE species.name = 'Digimon' AND vets.name = 'Jack Harkness';

-- Insert data into the visits table
INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT animals.id, vets.id, to_date('2020-05-24', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Agumon' AND vets.name = 'William Tatcher'
UNION
SELECT animals.id, vets.id, to_date('2020-07-22', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Agumon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT animals.id, vets.id, to_date('2021-02-02', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Gabumon' AND vets.name = 'Jack Harkness'
UNION
SELECT animals.id, vets.id, to_date('2020-01-05', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-03-08', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-05-14', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Pikachu' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2021-05-04', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Devimon' AND vets.name = 'Stephanie Mendez'
UNION
SELECT animals.id, vets.id, to_date('2021-02-24', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Charmander' AND vets.name = 'Jack Harkness'
UNION
SELECT animals.id, vets.id, to_date('2019-12-21', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-08-10', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'William Tatcher'
UNION
SELECT animals.id, vets.id, to_date('2021-04-07', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Plantmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2019-09-29', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Squirtle' AND vets.name = 'Stephanie Mendez'
UNION
SELECT animals.id, vets.id, to_date('2020-10-03', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Angemon' AND vets.name = 'Jack Harkness'
UNION
SELECT animals.id, vets.id, to_date('2020-11-04', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Angemon' AND vets.name = 'Jack Harkness'
UNION
SELECT animals.id, vets.id, to_date('2019-01-24', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2019-05-15', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-02-27', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-08-03', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Boarmon' AND vets.name = 'Maisy Smith'
UNION
SELECT animals.id, vets.id, to_date('2020-05-24', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Blossom' AND vets.name = 'Stephanie Mendez'
UNION
SELECT animals.id, vets.id, to_date('2021-01-11', 'YYYY-MM-DD') FROM animals, vets
WHERE animals.name = 'Blossom' AND vets.name = 'William Tatcher';
