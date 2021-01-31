--Problem 1------------------------------------------------------------------
USE Gringotts

SELECT COUNT(*) 
FROM WizzardDeposits


--Problem 2------------------------------------------------------------------
SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits


--Problem 3------------------------------------------------------------------
SELECT DepositGroup , MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup


--Problem 4------------------------------------------------------------------
SELECT TOP(2) DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)


--Problem 5------------------------------------------------------------------
SELECT DepositGroup , SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup


--Problem 6------------------------------------------------------------------
SELECT DepositGroup , SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup


--Problem 7------------------------------------------------------------------
SELECT DepositGroup , SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC


--Problem 8------------------------------------------------------------------
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup , MagicWandCreator


--Problem 9------------------------------------------------------------------
SELECT AgeRanking AS AgeGroup, COUNT(*) AS WizardCount
FROM (
         SELECT CASE
                    WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
                    WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
                    WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
                    WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
                    WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
                    WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
                    ELSE '[61+]'
                    END AS AgeRanking
         FROM WizzardDeposits) AS AGERankingQuery
GROUP BY AgeRanking


--Problem 10------------------------------------------------------------------
SELECT LEFT(FirstName , 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName , 1) 


--Problem 11------------------------------------------------------------------
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '01/01/1985'
GROUP BY DepositGroup , IsDepositExpired
ORDER BY DepositGroup DESC , IsDepositExpired 


--Problem 12------------------------------------------------------------------
SELECT SUM(Difference) AS SumDifference
  FROM (
         SELECT FirstName AS HostWirzard,
                DepositAmount AS HostWizardDeposit,
                LEAD(FirstName) OVER (ORDER BY Id ) AS GuestWizard,
                LEAD(DepositAmount) OVER (ORDER BY id) AS GuestDeposit,
                (DepositAmount - LEAD(DepositAmount) OVER (ORDER BY id)) AS [Difference]
         FROM WizzardDeposits) AS DifferenceAmountQuery


--Problem 13------------------------------------------------------------------
USE SoftUni

SELECT DepartmentID , SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID


--Problem 14------------------------------------------------------------------
SELECT DepartmentID , MIN(Salary)
FROM Employees
WHERE DepartmentID IN (2,5,7) AND HireDate > '01/01/2000'
GROUP BY DepartmentID


--Problem 15------------------------------------------------------------------
SELECT *
INTO NewTable
FROM Employees
WHERE Salary > 30000

DELETE 
FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
SET Salary = Salary + 5000
WHERE DepartmentID = 1

SELECT DepartmentID , AVG(Salary)
FROM NewTable
GROUP BY DepartmentID


--Problem 16------------------------------------------------------------------
SELECT DepartmentID , MAX(Salary) 
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000


--Problem 17------------------------------------------------------------------
SELECT COUNT(*) AS [Count] 
FROM Employees
WHERE ManagerID IS NULL


--Problem 18------------------------------------------------------------------
SELECT DISTINCT  DepartmentID , Salary AS ThirdHighestSalary
FROM ( SELECT * , 
       DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC ) AS [Ranked]
       FROM Employees) AS r
WHERE Ranked = 3


--Problem 19------------------------------------------------------------------
SELECT TOP (10) E.FirstName, E.LastName, E.DepartmentID
FROM Employees AS E
WHERE E.Salary > (
                  SELECT AVG(Salary) AS AverageSalary
                  FROM Employees AS eAverageSalary
                  WHERE eAverageSalary.DepartmentID = E.DepartmentID
                  GROUP BY DepartmentID
				 )
ORDER BY DepartmentID