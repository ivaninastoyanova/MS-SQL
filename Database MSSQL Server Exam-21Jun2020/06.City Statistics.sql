--PROBLEM 6

SELECT c.Name , COUNT(*) AS Hotels
FROM Cities AS c
JOIN Hotels AS h ON H.CityId = c.Id
GROUP BY c.Id , c.Name
ORDER BY COUNT(*) DESC , c.Name 