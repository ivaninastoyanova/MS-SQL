--PROBLEM 7

SELECT COUNT(*) AS [count]
FROM Colonists AS c
JOIN TravelCards AS tc ON tc.ColonistId = c.Id
JOIN Journeys AS j on j.Id = tc.JourneyId
WHERE j.Purpose = 'Technical'