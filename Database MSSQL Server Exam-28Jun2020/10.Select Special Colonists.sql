--PROBLEM 10

SELECT Ranked.JobDuringJourney , Ranked.FullName , ranked.JobRank  
         FROM (SELECT tc.JobDuringJourney, 
		              c.FirstName + ' ' + c.LastName AS FullName,
                      DENSE_RANK() OVER (PARTITION BY tc.JobDuringJourney ORDER BY c.BirthDate) AS JobRank
               FROM Colonists AS c
               JOIN TravelCards AS tc ON c.Id = tc.ColonistId
               JOIN Journeys AS j ON j.Id = tc.JourneyId) AS [Ranked]
WHERE JobRank = 2
      