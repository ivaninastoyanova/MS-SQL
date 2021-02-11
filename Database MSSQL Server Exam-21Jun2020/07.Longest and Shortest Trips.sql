--PROBLEM 7

SELECT a.Id , 
       a.FirstName + ' ' + a.LastName AS FullName,
	   MAX(DATEDIFF(day , t.ArrivalDate , t.ReturnDate)) AS LongestTrip,
	   MIN(DATEDIFF(day , t.ArrivalDate , t.ReturnDate)) AS ShortestTrip
FROM AccountsTrips AS ac
JOIN Accounts AS a ON ac.AccountId = a.Id
JOIN Trips AS t ON ac.TripId = t.Id
WHERE t.CancelDate IS NULL AND a.MiddleName IS NULL
GROUP BY a.Id, a.FirstName + ' ' + a.LastName
ORDER BY LongestTrip DESC , ShortestTrip ASC