--Problem 1------------------------------------------------------------------
USE SoftUni

SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'SA%'


--Problem 2------------------------------------------------------------------
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%'


--Problem 3------------------------------------------------------------------
SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3,10) 
     AND YEAR(HireDate) BETWEEN 1995 AND 2005


--Problem 4------------------------------------------------------------------
SELECT FirstName, LastName 
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'


--Problem 5------------------------------------------------------------------
SELECT [Name]
FROM Towns
WHERE LEN([Name]) in (5,6)
ORDER BY [Name]


--Problem 6------------------------------------------------------------------
SELECT *
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]


--Problem 7------------------------------------------------------------------
SELECT *
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]


--Problem 8------------------------------------------------------------------
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate)>2000


--Problem 9------------------------------------------------------------------
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName)=5


--Problem 10------------------------------------------------------------------
SELECT EmployeeID, FirstName, LastName , Salary, 
       DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC


--Problem 11------------------------------------------------------------------
SELECT * 
FROM
( SELECT EmployeeID, FirstName, LastName , Salary, 
       DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
) AS  TempRankTable
WHERE [Rank] = 2
ORDER BY Salary DESC


--Problem 12------------------------------------------------------------------
USE [Geography]

SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode


--Problem 13------------------------------------------------------------------
SELECT PeakName, RiverName , LOWER(PeakName + RIGHT(RiverName, LEN(RiverName)-1)) AS [Mix]
FROM Peaks, Rivers
WHERE RIGHT(PeakName , 1) = LEFT(RiverName, 1)
ORDER BY Mix


--Problem 14------------------------------------------------------------------
USE [Diablo]

SELECT TOP(50) [Name] , FORMAT([Start] , 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE YEAR([Start]) IN (2011,2012)
ORDER BY [Start] , [Name]


--Problem 15------------------------------------------------------------------
SELECT [Username] , SUBSTRING(Email,
                              CHARINDEX('@', Email) + 1,
                               LEN(Email) - CHARINDEX('@', Email) + 1)
						 AS [Email Provider] 
FROM Users
ORDER BY [Email Provider], Username


--Problem 16------------------------------------------------------------------
SELECT Username, IpAddress AS [IP Address]
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username 


--Problem 17------------------------------------------------------------------
SELECT [Name],
       CASE
           WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
           WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
          END AS [Part of the Day],
       CASE
           WHEN Duration <= 3 THEN 'Extra Short'
           WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
           WHEN Duration > 6 THEN 'Long'
           ELSE 'Extra Long'
          END AS [Duration]
FROM Games 
ORDER BY [Name], Duration


--Problem 18------------------------------------------------------------------
USE Orders

SELECT ProductName,
       OrderDate,
       DATEADD(DAY, 3, OrderDate)   AS [Pay Due],
       DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders