SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Gender]
  FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
     ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


