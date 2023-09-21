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

-- Create the owners table
CREATE TABLE owners (
   ID INT GENERATED ALWAYS AS IDENTITY,
   FULL_NAME VARCHAR (20),
   AGE INT,
   PRIMARY KEY (ID)
);

-- Create the species table
CREATE TABLE species (
   ID INT GENERATED ALWAYS AS IDENTITY,
   NAME VARCHAR (20),
   PRIMARY KEY (ID)
);

-- Modify animals table
-- Add species_id column as a species table foreign key
ALTER TABLE animals  
DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT;
ALTER TABLE animals 
ADD CONSTRAINT FK_SPECIES_ID 
FOREIGN KEY(species_id) 
REFERENCES species(ID);
-- Add owner_id column as a owners table foreign key
ALTER TABLE animals
ADD COLUMN owner_id INT;
ALTER TABLE animals 
ADD CONSTRAINT FK_OWNER_ID 
FOREIGN KEY(owner_id) 
REFERENCES owners(ID);

---------------------------------------------------------------------------

-- Create the vets table
CREATE TABLE vets (
   ID INT GENERATED ALWAYS AS IDENTITY,
   NAME VARCHAR (20),
   AGE INT,
   DATE_OF_GRADUATION DATE,
   PRIMARY KEY (ID)
);

-- Create the specializations table
CREATE TABLE specializations (
  specie_id INT,
  vet_id INT,
  PRIMARY KEY (specie_id, vet_id),
  CONSTRAINT FK_SPECIAL_SPECIE_ID FOREIGN KEY (specie_id) REFERENCES species(id),
  CONSTRAINT FK_SPECIAL_VET_ID FOREIGN KEY (vet_id) REFERENCES vets(id)
);

-- Create the visits table
CREATE TABLE visits (
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY (animal_id, vet_id, date_of_visit),
  CONSTRAINT FK_VISITS_ANIMAL_ID FOREIGN KEY (animal_id) REFERENCES animals(id),
  CONSTRAINT FK_VISITS_VET_ID FOREIGN KEY (vet_id) REFERENCES vets(id)
);
