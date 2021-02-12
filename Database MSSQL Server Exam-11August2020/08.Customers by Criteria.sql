--PROBLEM 8

SELECT FirstName , Age, PhoneNumber
FROM Customers
WHERE (Age >= 21 AND FirstName LIKE '%an%') 
      OR PhoneNumber LIKE '%38'
ORDER BY FirstName ASC , Age DESC