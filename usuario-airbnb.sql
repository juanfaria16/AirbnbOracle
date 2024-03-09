-- Asigna nombres a los scripts que se van a ejecutar para crear y poblar las tablas
-- Salir del script en caso de cualquier error
WHENEVER SQLERROR EXIT SQL.SQLCODE

-- Inicia el proceso de registro en un archivo log
SPOOL my_schema_install.log

-- Crear tabla 'User'
CREATE TABLE "User" (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    email VARCHAR2(255),
    password VARCHAR2(255),
    first_name VARCHAR2(50),
    last_name VARCHAR2(50)
);

-- Crear tabla 'Review'
CREATE TABLE Review (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    user_id VARCHAR2(50),
    place_id VARCHAR2(50),
    text VARCHAR2(4000)
);

-- Crear tabla 'Place'
CREATE TABLE Place (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    user_id VARCHAR2(50),
    name VARCHAR2(255),
    city_id VARCHAR2(50),
    description VARCHAR2(4000),
    number_rooms NUMBER DEFAULT 0,
    number_bathrooms NUMBER DEFAULT 0,
    max_guest NUMBER DEFAULT 0,
    price_by_night NUMBER DEFAULT 0,
    latitude BINARY_FLOAT,
    longitude BINARY_FLOAT
);

-- Crear tabla 'Amenity'
CREATE TABLE Amenity (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    name VARCHAR2(255)
);

-- Crear tabla 'PlaceAmenity'
CREATE TABLE PlaceAmenity (
    amenity_id VARCHAR2(50),
    place_id VARCHAR2(50),
    CONSTRAINT PK_PlaceAmenity PRIMARY KEY (amenity_id, place_id),
    CONSTRAINT FK_PlaceAmenity_Amenity FOREIGN KEY (amenity_id) REFERENCES Amenity (id),
    CONSTRAINT FK_PlaceAmenity_Place FOREIGN KEY (place_id) REFERENCES Place (id)
);

-- Crear tabla 'State'
CREATE TABLE State (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    name VARCHAR2(255)
);

-- Crear tabla 'City'
CREATE TABLE City (
    id VARCHAR2(50) PRIMARY KEY,
    updated_at TIMESTAMP,
    created_at TIMESTAMP,
    state_id VARCHAR2(50),
    name VARCHAR2(255)
);

-- Agregar las restricciones de clave foránea

ALTER TABLE Review ADD CONSTRAINT FK_Review_User FOREIGN KEY (user_id) REFERENCES "User" (id);
ALTER TABLE Review ADD CONSTRAINT FK_Review_Place FOREIGN KEY (place_id) REFERENCES Place (id);
ALTER TABLE Place ADD CONSTRAINT FK_Place_User FOREIGN KEY (user_id) REFERENCES "User" (id);
ALTER TABLE Place ADD CONSTRAINT FK_Place_City FOREIGN KEY (city_id) REFERENCES City (id);
ALTER TABLE City ADD CONSTRAINT FK_City_State FOREIGN KEY (state_id) REFERENCES State (id);


-- Termina el proceso de registro
SPOOL OFF

-- Salida del script
EXIT

--SELECT *FROM PLACE
