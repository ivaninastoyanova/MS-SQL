--PROBLEM 10

SELECT [Ranked].CountryName , [Ranked].DisributorName
 FROM ( SELECT c.Name AS CountryName, 
               d.Name AS DisributorName,
	           DENSE_RANK() OVER (PARTITION BY c.Name ORDER BY COUNT(i.Id) DESC) AS [Rank]
       FROM Countries AS c
       JOIN Distributors AS d ON d.CountryId = c.Id
       JOIN Ingredients AS i ON i.DistributorId = d.Id
       GROUP BY c.Name , d.Name) AS [Ranked] 
WHERE [Ranked].[Rank] = 1
ORDER BY [Ranked].CountryName , [Ranked].DisributorName


