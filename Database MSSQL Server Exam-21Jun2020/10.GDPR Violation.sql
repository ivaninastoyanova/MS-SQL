--PROBLEM 10

SELECT t.Id , 
       a.FirstName + ' ' + ISNULL(a.MiddleName + ' ' , '') + a.LastName AS [Full Name],
	   c.Name AS [From],
	   ch.Name AS [To],
	   CASE
		   WHEN t.CancelDate IS NOT NULL THEN 'Canceled'
	       ELSE CONVERT(VARCHAR ,DATEDIFF(DAY , t.ArrivalDate , t.ReturnDate)) + ' days'
	   END AS [Duration]
FROM Trips AS t
LEFT JOIN AccountsTrips AS ac ON ac.TripId = t.Id
JOIN Accounts AS a ON a.Id = ac.AccountId
JOIN Cities AS c ON c.Id = a.CityId 
JOIN Rooms AS r ON r.Id = t.RoomId
JOIN Hotels AS h ON h.Id = r.HotelId
JOIN Cities AS ch ON ch.Id = h.CityId
ORDER BY [Full Name] , t.Id