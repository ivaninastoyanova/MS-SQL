--PROBLEM 11

CREATE FUNCTION udf_GetColonistsCount(@PlanetName VARCHAR(30)) 
RETURNS INT
AS
BEGIN
DECLARE @count INT = (SELECT COUNT(c.Id)
                      FROM Planets AS p
                      JOIN Spaceports AS sp ON sp.PlanetId = p.Id
                      JOIN Journeys AS j ON j.DestinationSpaceportId = sp.Id
                      JOIN TravelCards AS tc ON j.Id= tc.JourneyId
                      JOIN Colonists AS c ON c.Id = tc.ColonistId
				      WHERE p.Name = @PlanetName)
RETURN @count
END
