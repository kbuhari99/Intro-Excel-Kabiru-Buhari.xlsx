SELECT TOP (1000) [Emp_id]
      ,[first_name]
      ,[last_name]
      ,[birthdate]
      ,[gender]
      ,[race]
      ,[department]
      ,[jobtitle]
      ,[location]
      ,[hire_date]
      ,[termdate]
      ,[location_city]
      ,[location_state]
      ,[age]
  FROM [HR Analytics].[dbo].[HR]


  ---Rename Colunm
USE [HR Analytics]
EXEC sp_rename
'HR.id', 'Emp_id'

---Date Formating
SELECT birthdate,hire_date, termdate,
CONVERT(CHAR(12), birthdate, 107) AS Birth_Date,
CONVERT(CHAR(12), hire_date, 107) AS Hire_Date,
CONVERT(CHAR(12), termdate, 102) AS Term_Date
FROM [HR Analytics].dbo.HR

ALTER TABLE [HR Analytics].dbo.HR
DROP COLUMN birthdate, hire_date, termdate

ALTER TABLE [HR Analytics].dbo.HR
ADD age AS DATEDIFF(YEAR, birthdate, Getdate())

  SELECT MAX(age), MIN(age)
  FROM [HR Analytics].dbo.HR

  SELECT *
  FROM [HR Analytics].dbo.HR

 SELECT Emp_id, hire_date, termdate,
 CASE WHEN termdate IS NULL THEN 'Terminated'
     WHEN termdate IS NOT NULL THEN 'Active'
     END AS [Emp_Status]
FROM [HR Analytics].dbo.HR


SELECT Emp_id, first_name, last_name, age,
CASE WHEN age >=20 THEN '30 - 40'
     WHEN age >=35 THEN '40 - 50'
     WHEN age >=45 THEN '50 - 55'
     WHEN age >=55 THEN '55+'
END AS Age_bracket
FROM [HR Analytics].dbo.HR

---Employee Gender Breakdown
SELECT gender, COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NULL
GROUP BY gender;

---Employee Race Breakdown
SELECT race, COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NULL
GROUP BY race;

---Age Distribution of Employees
SELECT
CASE WHEN age >=18 AND age <=20 THEN '18-24'
     WHEN age >=25 AND age <=34 THEN '25-34'
     WHEN age >=35 AND age <=44 THEN '35-44'
     WHEN age >=45 AND age <=54 THEN '45-54'
     WHEN age >=55 AND age <=64 THEN '55-64'
     ELSE '65+'
END AS Age_group,
COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NULL
GROUP BY age;

---Employees Work at HQ VS Remote
SELECT location, COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NULL
GROUP BY location;

---Average length of Terminated Appointment
SELECT YEAR(termdate) - YEAR(hire_date) AS length_of_Emp
FROM [HR Analytics].dbo.HR
WHERE termdate IS NOT NULL

---How does gender distribution vary across department and job titles
SELECT * FROM [HR Analytics].dbo.HR

SELECT department,jobtitle,gender,COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NOT NULL
GROUP BY department,jobtitle,gender
ORDER BY department,jobtitle,gender;

SELECT department,gender,COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NOT NULL
GROUP BY department,gender
ORDER BY department,gender;

---distribution of jobtitle across the company
SELECT jobtitle,COUNT(*) AS count
FROM [HR Analytics].dbo.HR
WHERE termdate IS NULL
GROUP BY jobtitle

---Department that has the highest Termination Rate
SELECT * FROM [HR Analytics].dbo.HR

SELECT department,
  COUNT(*) AS Total_count,
  COUNT (CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END AS terminated_count,
            ROUND((COUNT (CASE 
                           WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                           END)/COUNT(*))*100,2) AS terminated rate

            FROM HR Analytics.dbo.HR
            GROUP BY department
            ORDER BY termintion_rate DESC