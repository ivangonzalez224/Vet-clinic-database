-- Create the animals table structure:

CREATE TABLE animals (
   ID INT GENERATED ALWAYS AS IDENTITY,
   NAME VARCHAR (20),
   DATE_OF_BIRTH DATE,
   ESCAPE_ATTEMPTS INT,
   neutered BOOLEAN,
   WEIGHT_KG DECIMAL,
   PRIMARY KEY (ID)
);

-- Add the species column into the animals table

ALTER TABLE animals
ADD COLUMN species VARCHAR (20);
