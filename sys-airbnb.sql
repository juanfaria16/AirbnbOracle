--Crear el usuario desde el administrador
CREATE USER usuario_airbnb IDENTIFIED BY 061620;
GRANT CONNECT, RESOURCE TO usuario_airbnb;

ALTER USER usuario_airbnb QUOTA UNLIMITED ON USERS;

SELECT *FROM dba_users
