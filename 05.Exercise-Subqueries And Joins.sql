--Problem 1------------------------------------------------------------------
USE SoftUni

SELECT TOP(5) e.EmployeeID , e.JobTitle, e.AddressID, a.AddressText 
FROM Employees AS e
JOIN Addresses AS a ON A.AddressID = E.AddressID
ORDER BY E.AddressID


--Problem 2------------------------------------------------------------------
SELECT TOP(50) e.FirstName , e.LastName , t.Name AS Town , a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY e.FirstName , e.LastName


--Problem 3------------------------------------------------------------------
SELECT e.EmployeeID, e.FirstName, e.LastName , d.Name
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID


--Problem 4------------------------------------------------------------------
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID


--Problem 5------------------------------------------------------------------
SELECT TOP(3) e.EmployeeID , e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID 


--Problem 6------------------------------------------------------------------
SELECT e.FirstName , e.LastName , e.HireDate , d.Name
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1.1.1999' AND d.Name IN ('Sales' , 'Finance')
ORDER BY e.HireDate


--Problem 7------------------------------------------------------------------
SELECT TOP(5) e.EmployeeID , e.FirstName , p.Name
FROM Employees AS e
 JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
 JOIN Projects AS p ON ep.ProjectID = p.ProjectID
 WHERE p.StartDate > '08/13/2002' AND p.EndDate IS NULL
 ORDER BY e.EmployeeID 


--Problem 8------------------------------------------------------------------
 SELECT e.EmployeeID , 
        e.FirstName , 
		CASE 
		   WHEN YEAR(p.StartDate) >= 2005 THEN NULL
		   ELSE p.Name
        END AS ProjectName
FROM Employees AS e
 JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
 JOIN Projects AS p ON ep.ProjectID = p.ProjectID
 WHERE e.EmployeeID = 24


--Problem 9------------------------------------------------------------------
 SELECT e.EmployeeID , e.FirstName , e.ManagerID , m.FirstName AS ManagerName
 FROM Employees AS e
 JOIN Employees AS m ON e.ManagerID = m.EmployeeID
 WHERE e.ManagerID IN (3 , 7) 
 ORDER BY e.EmployeeID


--Problem 10------------------------------------------------------------------
 SELECT TOP (50) e.EmployeeID , 
                 e.FirstName + ' ' + e.LastName AS EmployeeName, 
		         m.FirstName + ' ' + m.LastName AS ManagerName, 
		         d.Name AS DepartmentName
 FROM Employees AS e
 LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
 LEFT JOIN Departments AS d ON e.DepartmentID = d.DepartmentID


--Problem 11------------------------------------------------------------------
SELECT MIN(a.AverageSalary) AS MinAverageSalary
    FROM (
	      SELECT AVG(Salary) AS AverageSalary
          FROM Employees AS e
          GROUP BY e.DepartmentID
		 ) AS a


--Problem 12------------------------------------------------------------------
 USE Geography

 SELECT c.CountryCode , m.MountainRange , p.PeakName , p.Elevation
 FROM Countries AS c
 JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
 JOIN Mountains AS m ON mc.MountainId = m.Id
 JOIN Peaks AS p ON m.Id = p.MountainId
 WHERE c.CountryName = 'Bulgaria' AND p.Elevation > 2835
 ORDER BY p.Elevation DESC


--Problem 13------------------------------------------------------------------
SELECT c.CountryCode , COUNT(m.MountainRange)  
 FROM Countries AS c
 JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
 JOIN Mountains AS m ON mc.MountainId = m.Id
 WHERE c.CountryName IN ('United States' , 'Russia' , 'Bulgaria') 
 GROUP BY c.CountryCode


--Problem 14------------------------------------------------------------------
 SELECT TOP (5) c.CountryName , r.RiverName
 FROM Countries AS c
 LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
 LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
 WHERE c.ContinentCode = 'AF'
 ORDER BY c.CountryName


--Problem 15------------------------------------------------------------------
SELECT ContinentCode, CurrencyCode, CurrencyCount AS CurrencyUsage
FROM (SELECT ContinentCode,
             CurrencyCode,
             CurrencyCount,
             DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyCount DESC) AS CurrencyRank
         FROM (SELECT ContinentCode,
                      CurrencyCode,
                      COUNT(*) AS CurrencyCount
                 FROM Countries
                 GROUP BY ContinentCode, CurrencyCode
               ) AS CurrencyCountQuery
      WHERE CurrencyCount > 1) AS CurrencyRankingQuery
WHERE CurrencyRank=1
ORDER BY ContinentCode


--Problem 16------------------------------------------------------------------
SELECT COUNT(*) 
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE mc.MountainId IS NULL


--Problem 17------------------------------------------------------------------
SELECT TOP(5) CountryName,
              MAX(p.Elevation) AS HightestPeakElevation,
              MAX(r.Length) AS LongestRiverLength
 FROM Countries AS c
 LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
 LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
 LEFT JOIN Peaks AS p ON m.Id = p.MountainId
 LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
 LEFT JOIN Rivers AS r on r.Id = cr.RiverId
 GROUP BY c.CountryName
 ORDER BY HightestPeakElevation DESC,
          LongestRiverLength DESC,
          CountryName ASC


--Problem 18------------------------------------------------------------------
 SELECT TOP (5) Country,
               CASE
                   WHEN PeakName IS NULL THEN '(no highest peak)'
                   ELSE PeakName
               END AS [Highest Peak Name],
               CASE
                   WHEN Elevation IS NULL THEN 0
                   ELSE Elevation
               END AS [Highest Peak Elevation],
               CASE
                   WHEN Mountain IS NULL THEN '(no mountain)'
                   ELSE Mountain
               END AS Mountain
   FROM (
         SELECT *,
                DENSE_RANK() OVER (PARTITION BY Country ORDER BY Elevation DESC) AS PeakRank
         FROM (SELECT CountryName AS Country,
                      p.PeakName,
                      p.Elevation,
                      m.MountainRange AS Mountain
               FROM Countries AS c
                        LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
                        LEFT JOIN Mountains m ON mc.MountainId = m.Id
                        LEFT JOIN Peaks p ON m.Id = p.MountainId)
                  AS AllPeaksQuery)
         AS PeakRankingQuery
WHERE PeakRank = 1
ORDER BY Country, [Highest Peak Name]