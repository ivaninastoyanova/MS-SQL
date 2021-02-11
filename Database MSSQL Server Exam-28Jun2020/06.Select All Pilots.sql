--PROBLEM 6

SELECT c.Id , 
       c.FirstName + ' ' + c.LastName AS [full_name]
FROM Colonists AS c
JOIN TravelCards AS tc ON tc.ColonistId = c.Id
WHERE JobDuringJourney = 'Pilot'
ORDER BY c.Id