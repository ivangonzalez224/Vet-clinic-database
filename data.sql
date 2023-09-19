/* Populate animals table with provided data. */

INSERT INTO animals (NAME,DATE_OF_BIRTH,ESCAPE_ATTEMPTS,neutered,WEIGHT_KG) VALUES 
   ('Agumon', '2020-02-03', 0, TRUE, 10.23 ),
   ('Gabumon', '2018-11-15', 2, TRUE, 8.00 ),
   ('Pikachu', '2021-01-07', 1, FALSE, 15.04 ),
   ('Devimon', '2017-05-12', 5, TRUE, 11.00 );

SELECT * FROM animals;
