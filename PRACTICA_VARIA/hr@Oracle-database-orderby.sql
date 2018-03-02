-- order by 
SELECT * FROM COUNTRIES
ORDER BY COUNTRY_NAME

SELECT * FROM COUNTRIES
ORDER BY REGION_ID, country_name 

SELECT first_name || '' || last_name "employe name"
FROM employees 
WHERE DEPARTMENT_ID = 90
ORDER BY LAST_NAME

-- ORDERNAR DE FORMA DESENDENTE 

SELECT LAST_NAME
FROM EMPLOYEES
ORDER BY LAST_NAME DESC

-- APELLIDOS DE FORMAS DESENDENTE Y ANOMBRES ACENDENTE 

SELECT LAST_NAME
FROM EMPLOYEES 
ORDER BY LAST_NAME DESC , LAST_NAME ASC 

SELECT FIRST_NAME ,HIRE_DATE, SALARY, MANAGER_ID mid
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (110, 100)
ORDER BY 4,2,3

SELECT LAST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'R%'
ORDER BY COMMISSION_PCT ASC, LAST_NAME DESC

create database MI_TALLER
