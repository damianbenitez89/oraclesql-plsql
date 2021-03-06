--count (* , espresion )
-- CONTAR LA CANTIDAD DE EMPLEADOS
SELECT COUNT(*)
FROM EMPLOYEES;

-- CONTAR LA CANT DE PAISES 

SELECT COUNT(*) 
FROM COUNTRIES;

-- CONTAR LOS VALORES DE COMISION (NO CUENTA LOS VALORESS QUE SEAN NULOS )
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;

-- CUENTA LOS VALORES DE CONDICIONES QUE SEAN DISTINTOS 
SELECT COUNT(DISTINCT COMMISSION_PCT) FROM EMPLOYEES;

-- CONTAR LOS PAISES QUE EMPIEZA CON LA LETRA A 
/
SELECT COUNT(*) --  "PAISES QUE COMIENZAN CON LA LETRA A"
FROM COUNTRIES
WHERE COUNTRY_NAME LIKE 'A%';

