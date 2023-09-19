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
