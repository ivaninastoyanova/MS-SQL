--PROBLEM 11

CREATE VIEW v_UserWithCountries 
AS
(
SELECT CONCAT(C.FirstName, ' ', c.LastName) AS CustomerName,
       C.Age AS Age,
       C.Gender AS Gender,
       C2.Name AS CountryName
 FROM Customers AS C
 JOIN Countries C2 ON C2.Id = C.CountryId
)
