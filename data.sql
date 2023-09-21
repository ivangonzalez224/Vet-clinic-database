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