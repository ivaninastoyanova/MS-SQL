--PROBLEM 9

SELECT p.Name, COUNT(*)
FROM Planets AS p
JOIN Spaceports AS sp ON sp.PlanetId = p.Id
JOIN Journeys AS j ON J.DestinationSpaceportId = sp.Id
GROUP BY p.Name
ORDER BY COUNT(*) DESC , p.Name ASC
