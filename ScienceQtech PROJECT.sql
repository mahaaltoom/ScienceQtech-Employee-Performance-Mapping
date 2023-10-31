#3
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM  employee.emp_record_table;
#4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING < 2 ;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employee.emp_record_table
WHERE EMP_RATING > 4 ;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM employee.emp_record_table
WHERE  (EMP_RATING >= 2 AND EMP_RATING <= 4);
#5
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM employee.emp_record_table
WHERE DEPT = 'Finance';
#6
SELECT m.EMP_ID,e.MANAGER_ID,m.FIRST_NAME,m.LAST_NAME,m.ROLE,
m.EXP,COUNT(e.EMP_ID) as "EMP_COUNT"
FROM employee.emp_record_table m ,employee.emp_record_table e 
WHERE  m.EMP_ID = e.MANAGER_ID
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;


#7
SELECT *
FROM employee.emp_record_table
WHERE EMP_ID IN (
    SELECT EMP_ID
    FROM employee.emp_record_table
    WHERE DEPT = 'Healthcare'
)
UNION
SELECT *
FROM employee.emp_record_table
WHERE EMP_ID IN (
    SELECT EMP_ID
    FROM employee.emp_record_table
    WHERE DEPT = 'Finance'
);

# CHAPTER 8
#8
SELECT
    E.EMP_ID,
    E.FIRST_NAME,
    E.LAST_NAME,
    E.ROLE,
    E.DEPT AS DEPARTMENT,
    E.EMP_RATING,
    D.MAX_EMP_RATING
FROM emp_record_table AS E
JOIN (
    SELECT DEPT, MAX(EMP_RATING) AS MAX_EMP_RATING
    FROM emp_record_table
    GROUP BY DEPT
) AS D
ON E.DEPT = D.DEPT;

#9 
SELECT ROLE, MIN(SALARY) AS Min_Salary, MAX(SALARY) AS Max_Salary
FROM employee.emp_record_table
GROUP BY ROLE;

#10
SELECT *,
       RANK() OVER (ORDER BY EXP DESC) AS Exp_Rank
FROM employee.emp_record_table ;

#11
CREATE VIEW EMP_HIGH_SALARY11 AS
SELECT FIRST_NAME ,LAST_NAME ,COUNTRY , SALARY
FROM employee.emp_record_table 
WHERE SALARY > 6000 ;
SELECT * FROM EMP_HIGH_SALARY11;

#12 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM employee.emp_record_table 
WHERE EXP > (
    SELECT MAX(EXP)
    FROM employee.emp_record_table 
    WHERE EXP < 10
);

#13 
DELIMITER //

CREATE PROCEDURE GetEmpWithExp(IN minExperience INT)
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
    FROM employee.emp_record_table
    WHERE EXP > minExperience;
END //

DELIMITER ;
CALL GetEmpWithExp(3);



#14 
DELIMITER &&
CREATE FUNCTION fun_role(EXP int)
RETURNS varchar(50)  DETERMINISTIC
 
BEGIN 
DECLARE assig_role varchar(50);

IF EXP <= 2 THEN SET assig_role="JUNIOR DATA SCIENTIST";
ELSEIF EXP <= 5 THEN SET assig_role="ASSOCIATE DATA SCIENTIST";
ELSEIF EXP <= 10 THEN SET assig_role="SENIOR DATA SCIENTIST";
ELSEIF EXP <= 12 THEN SET assig_role="LEAD DATA SCIENTIST";
ELSEIF EXP <= 16 THEN SET assig_role="MANAGER";

 END IF;

RETURN (assig_role);

END &&

SELECT EXP , fun_role(EXP)
FROM employee.data_science_team;

#15

EXPLAIN SELECT * 
FROM employee.emp_record_table
WHERE FIRST_NAME = "Eric"; 

CREATE INDEX index_name 
ON employee.emp_record_table(FIRST_NAME(40));


#16
SELECT
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    EMP_RATING,
    (SALARY * 0.05 * EMP_RATING ) AS Bonus
FROM employee.emp_record_table  ;
    

#17
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS Ave_Salary
FROM employee.emp_record_table 
GROUP BY
    CONTINENT, COUNTRY
ORDER BY
    CONTINENT, COUNTRY;




    










   
    