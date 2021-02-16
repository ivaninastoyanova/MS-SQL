--PROBLEM 8 

SELECT f2.Id, 
       f2.Name,	
	   CONVERT(VARCHAR , f2.Size) + 'KB'
FROM Files AS f1
FULL JOIN Files AS f2 ON f1.ParentId = f2.Id
WHERE f1.ParentId IS NULL
ORDER BY f1.Id , f1.Name , f1.Size DESC