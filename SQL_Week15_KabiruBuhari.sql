SELECT*
FROM SQLTutorial.dbo.EmployeeSalary

--Subquery in Select
SELECT EmployeeID, Salary, (Select AVG(Salary) From SQLTutorial.dbo.EmployeeSalary) as AllAvgSalary
FROM SQLTutorial.dbo.EmployeeSalary

--Subquery with Partition By
 SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
FROM SQLTutorial.dbo.EmployeeSalary

--Subquery in From Statement
Select a.EmployeeID, AllAvgSalary
From (SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
     FROM SQLTutorial.dbo.EmployeeSalary) a

--Subquery in Where
SELECT EmployeeID, JobTitle, Salary
From SQLTutorial.dbo.EmployeeSalary
Where EmployeeID in (
         Select EmployeeID
         From SQLTutorial.dbo.EmployeeDemographics
         Where Age > 30)

--Temp Table

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int)

Select *
FROM #Temp_Employee

INSERT INTO #Temp_Employee VALUES (
'1001', 'HR', '45000')
INSERT INTO #temp_Employee
SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

CREATE TABLE #Temp_Employee2 (
JobTitle varchar (50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

INSERT INTO #Temp_Employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

--COMMON TABLE EXPRESSIONS (CTEs)
 
 SELECT FirstName, LastName, Gender, Salary,
 COUNT(Gender) OVER (PARTITION by Gender) as TotalGender,
 AVG(Salary) OVER (PARTITION by Gender) as AvgSalary
 FROM SQLTutorial.dbo.EmployeeDemographics emp
 JOIN SQLTutorial.dbo.EmployeeSalary sal
      ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary,
 COUNT(Gender) OVER (PARTITION by Gender) as TotalGender,
 AVG(Salary) OVER (PARTITION by Gender) as AvgSalary
 FROM SQLTutorial.dbo.EmployeeDemographics emp
 JOIN SQLTutorial.dbo.EmployeeSalary sal
      ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
Select *
FROM CTE_Employee
