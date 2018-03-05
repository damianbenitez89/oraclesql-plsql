--CLASE 12 Y ULTIMA CLASE

-- TRIGGERS 
/*
?se conocen como disparadores o desencadenadores
?es un bloque de c�digo que se ejecuta autom�ticamente cuando ocurre alg�n evento sobre una determinada tabla
?los eventos pueden ser INSERT, UPDATE o DELETE (triggers DML)
?es un mecanismo adicional para conservar la integridad referencial

Diferencias con los STORED PROCEDURES:
?no pueden ser invocados directamente ya que el disparador se ejecuta autom�ticamente al intentar modificar los datos de su tabla asociada
?no reciben ni retornan par�metros

Privilegios necesarios para crear triggers:
?ALTER ANY TABLE
?CREATE ANY TRIGGER
?ALTER ANY TRIGGER
?DROP ANY TRIGGER 

Para ver triggers creados:

*/
SELECT * FROM USER_TRIGGERS;

/*
Existen distintos tipos de triggers:
? Triggers DML
? Triggers INSTEAD OF
? Triggers de sistema (DATABASE y SCHEMA)
*/

CREATE [ OR REPLACE ] TRIGGER TG_NAME 
[ ENABLE | DISABLE ] 
CUANDO ? ANTES O DESPUES DE LA ACCION
ACCION ? ORDEN DML QUE GENERA INVOCACI�N
ON TABLE_NAME
NIVEL ? SENTENCIA O FILA

DECLARE
--VARIABLES 
BEGIN
--SENTENCIAS
END TG_NAME;

/*
Existen distintos tipos de triggers:
? Triggers DML
? Triggers INSTEAD OF
? Triggers de sistema (DATABASE y SCHEMA)
*/

CREATE [ OR REPLACE ] TRIGGER TG_NAME
[ ENABLE | DISABLE ] 
CUANDO ? ANTES O DESPUES DE LA ACCION
ACCION ? ORDEN DML QUE GENERA INVOCACI�N
ON TABLE_NAME
NIVEL ? SENTENCIA O FILA 
DECLARE 
--VARIABLES
BEGIN 
--SENTENCIAS 
END TG_NAME;

-- TRIGGERS - CUANDO 
--SINTAXIS
CREATE [ OR REPLACE ] TRIGGER TG_NAME
CUANDO ? ANTES O DESPUES DE LA ACCION
ACCION ? ORDEN DML QUE GENERA INVOCACI�N
ON TABLE_NAME
NIVEL ? SENTENCIA O FILA
/*
?BEFORE (antes de ejecutar la acci�n)
?AFTER (despu�s de ejecutar la acci�n)

*/

-- TRIGGERS ACCION
--SINTAXIS
CREATE [ OR REPLACE ] TRIGGER TG_NAME
CUANDO ? BEFORE | AFTER
ACCION ? ORDEN DML QUE GENERA INVOCACI�N 
ON TABLE_NAME NIVEL ? SENTENCIA O FILA
/*
?INSERT
?UPDATE
?DELETE
-- Pueden concatenarse acciones con el operador OR Ejemplo:
?INSERT OR UPDATE
?INSERT OR UPDATE OR DELETE
*/
-- TRIGGERS  - NIVEL 

--SINTAXIS
CREATE [ OR REPLACE ] TRIGGER TG_NAME
CUANDO ? BEFORE | AFTER
ACCION ? INSERT | UPDATE | DELETE
ON TABLE_NAME
 /*
 NIVEL ? SENTENCIA O FILA
?Nivel de sentencia 
Se ejecutan una vez para cada instrucci�n DML. Son el tipo predeterminado que se crea con el comando CREATE TRIGGER
?Nivel de fila 
Se ejecutan una vez para cada fila afectada por una instrucci�n DML. Los disparadores de nivel de fila se crean utilizando la cl�usula FOR EACH ROW
*/
--EJEMPLOS DE NIVEL DE SENTENCIAS 

CREATE OR REPLACE TRIGGER TG_REGIONS_1
BEFORE UPDATE 
ON REGIONS

DECLARE VMSG VARCHAR2(100); 
BEGIN 
  VMSG := 'TRIGGER UPDATE REGIONS - NIVEL DE SENTENCIA';
  DBMS_OUTPUT.PUT_LINE(VMSG); 
END TG_REGIONS_1;

--PRUEBA TRIGGER 
UPDATE REGIONS 
SET REGION_NAME = UPPER(REGION_NAME) 
WHERE REGION_ID IN (1,2);
/
--DESHABILITAR TRIGGER
ALTER TRIGGER TG_REGIONS_1 DISABLE;
/
-- BORRADO DE TRIGGER
DROP TRIGGER TG_REGIONS_2;
/
-- EJEMPLOS - NIVEL FILA 
CREATE OR REPLACE TRIGGER TG_REGIONS_2
BEFORE UPDATE 
ON REGIONS 
FOR EACH ROW
DECLARE
    VMSG VARCHAR2(100);
    BEGIN 
      VMSG := 'TRIGGER UPDATE REGIONS - NIVEL DE FILA';
      DBMS_OUTPUT.PUT_LINE(VMSG); 
END TG_REGIONS_2;

--PRUEBA TRIGGER 
  UPDATE REGIONS 
  SET REGION_NAME = UPPER(REGION_NAME)
  WHERE REGION_ID IN (1,2); 
  --DESHABILITAR TRIGGER
  ALTER TRIGGER TG_REGIONS_2 DISABLE;
 / 
  -- EJEMPLOS DE MULTIPLES ACCIONES 
  
 CREATE OR REPLACE TRIGGER TG_REGIONS_3
 AFTER INSERT OR UPDATE OR DELETE
 ON REGIONS 
 DECLARE 
 VMSG VARCHAR2(100); 
 BEGIN
 
 VMSG := 'TRIGGER REGIONS - NIVEL DE SENTENCIA';
 IF INSERTING THEN 
 dbms_output.put_line(VMSG || ' - INSERTING');
 ELSIF UPDATING THEN dbms_output.put_line(VMSG || ' - UPDATING'); 
 ELSIF DELETING THEN dbms_output.put_line(VMSG || ' - DELETING'); 
 END IF; 
 END TG_REGIONS_3; 
 /
 --PRUEBA TRIGGER
 INSERT INTO REGIONS (REGION_ID,REGION_NAME)
 VALUES (99,'Oceania');
 UPDATE REGIONS 
 SET REGION_NAME = UPPER(REGION_NAME)
 WHERE REGION_ID = 99;
 
 DELETE FROM REGIONS
 WHERE REGION_ID = 99; 
 
 --DESHABILITAR TRIGGER
 
 ALTER TRIGGER TG_REGIONS_3 DISABLE;
 /
 DROP TG_REGIONS_3;
 
 -- DATOS DE LA SENTENCIAS DML 
 /*
 TECNICAS DE ALMACENAMIENTO DE DATOS
Para acceder a los conjuntos de datos de la sentencia DML,
Oracle ofrece el uso de los registros:
?:OLD
?:NEW 
Ambos tienen la estructura de los campos de la tabla que se est� modificando 
(�dem a %ROWTYPE) y contienen una copia del registro antes (OLD) y despu�s (NEW) de la acci�n SQL (INSERT, UPDATE, DELETE)
  */
  
 -- EJEMPLOS DE OLD / NEW 
 CREATE OR REPLACE TRIGGER TG_REGIONS_4 
 BEFORE UPDATE
 ON REGIONS 
 FOR EACH ROW 
 DECLARE
 VMSG VARCHAR2(100);
 BEGIN
 VMSG := 'TRIGGER UPDATE REGIONS - REGION_NAME OLD: '; 
 VMSG := VMSG || :OLD.REGION_NAME; DBMS_OUTPUT.PUT_LINE(VMSG);
 VMSG := 'TRIGGER UPDATE REGIONS - REGION_NAME NEW: '; 
 VMSG := VMSG || :NEW.REGION_NAME; DBMS_OUTPUT.PUT_LINE(VMSG); 
 END TG_REGIONS_4;
 
 --PRUEBA TRIGGER
 /
 DELETE 
 FROM REGIONS
 WHERE REGION_ID = 99; 
 INSERT INTO REGIONS (REGION_ID,REGION_NAME)
 VALUES (99,'Oceania');
 UPDATE REGIONS 
 SET REGION_NAME = UPPER(REGION_NAME) 
 WHERE REGION_ID = 99; 
 --DESHABILITAR TRIGGER
 /
 ALTER TRIGGER TG_REGIONS_4 DISABLE;
 -- MODIFICAR TRIGGERS
 --DESHABILITAR TRIGGER INDIVIDUALMENTE
 ALTER TRIGGER TRIGGER_NAME DISABLE;
 --DESHABILITAR TRIGGERS DE UNA TABLA 
 ALTER TABLE TABLE_NAME DISABLE ALL TRIGGERS;
 --HABILITAR TRIGGER INDIVIDUALMENTE
 ALTER TRIGGER TRIGGER_NAME ENABLE; 
 --HABILITAR TRIGGERS DE UNA TABLA
 ALTER TABLE TABLE_NAME ENABLE ALL TRIGGERS;
 --RENOMBRAR TRIGGER
 ALTER TRIGGER TRIGGER_NAME RENAME TO NEW_NAME; 
 --BORRAR TRIGGER
 DROP TRIGGER TRIGGER_NAME;
 
 /*
 EJERCICIO 
 Crear un trigger sobre la tabla REGIONS que ante un INSERT con valor de REGION_ID nulo le cargue el valor m�ximo existente en la tabla +1
 
 */
 