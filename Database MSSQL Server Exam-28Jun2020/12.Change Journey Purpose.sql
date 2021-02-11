--PROBLEM 12

CREATE PROCEDURE usp_ChangeJourneyPurpose(@JourneyId INT, @NewPurpose VARCHAR(11))
AS
BEGIN 

DECLARE @journeyIdOld INT = (SELECT Id 
                             FROM Journeys
						     WHERE Id=@JourneyId)
IF(@journeyIdOld IS NULL)
THROW 50001 , 'The journey does not exist!' , 1

DECLARE @purposeOld VARCHAR(11) = (SELECT Purpose
                                   FROM Journeys
					               WHERE Id=@JourneyId)
IF(@purposeOld = @NewPurpose)
THROW 50002, 'You cannot change the purpose!' , 1

UPDATE Journeys
SET Purpose = @NewPurpose
WHERE Id = @JourneyId

END