--EJERCICIO 1
SELECT MANAGER_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID LIKE '121'
GROUP BY MANAGER_ID;

--EJERCICIO 2
SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES
WHERE DEPARTMENT_ID LIKE '30';

--EJERCICIO 3
SELECT MIN(SALARY) FROM EMPLOYEES
WHERE JOB_ID LIKE 'IT_PROG';

--EJERCICIO 4
SELECT MAX (TO_CHAR(HIRE_DATE, 'YYYY')) FROM EMPLOYEES
WHERE JOB_ID LIKE 'PU_CLERK';

--EJERCICIO 5
SELECT REGION_NAME, (SELECT COUNT (COUNTRY_ID)
FROM COUNTRIES
WHERE COUNTRIES.REGION_ID=REGIONS.REGION_ID)
AS NUMBER_COUNTRIES
FROM REGIONS;

--EJERCICIO 6
SELECT FIRST_NAME || ' ' || LAST_NAME  EMPLEADOS ,
      TO_CHAR(HIRE_DATE, 'YYYY')
FROM  EMPLOYEES
GROUP BY FIRST_NAME || ' ' || LAST_NAME , TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY TO_CHAR(HIRE_DATE, 'YYYY');

--EJERCICIO 7
SELECT DEPARTMENT_ID, (SELECT DEPARTMENT_NAME FROM DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID)
AS DEPARTMENT_NAME,
COUNT(EMPLOYEE_ID),
SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 1;

--EJERCICIO 8
SELECT L.CITY, COUNT(*) "CANTIDAD"
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
                 JOIN LOCATIONS L ON D.LOCATION_ID=L.LOCATION_ID
GROUP BY L.CITY
HAVING COUNT(*)>10;

--EJERCICIO 9
SELECT FIRST_NAME , LAST_NAME , SALARY, E.HIRE_DATE, D.DEPARTMENT_NAME  "DEPARTAMENTO"
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.SALARY > (SELECT MAX(E.SALARY) FROM EMPLOYEES E WHERE DEPARTMENT_ID = 90);

--EJERCICIO 10
SELECT TO_CHAR(HIRE_DATE ,'YYYY')  "A�OS DE CONTRATACIONES" ,COUNT(*) "EMPLEADOS CONTRATADOS"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE ,'YYYY') LIKE '%%%%'
GROUP BY TO_CHAR(HIRE_DATE ,'YYYY')
ORDER BY 1 ASC;
