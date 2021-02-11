--PROBLEM 9

SELECT a.Id , a.Email , c.Name , COUNT(*) AS Trips
FROM Accounts AS a
JOIN AccountsTrips AS ac ON ac.AccountId = a.Id 
JOIN Trips AS t ON t.Id = ac.TripId
JOIN Rooms AS r ON r.Id = t.RoomId
JOIN Hotels AS h ON h.Id = r.HotelId
JOIN Cities AS c ON c.Id = a.CityId
WHERE a.CityId = h.CityId
GROUP BY a.Id , a.Email , c.Name
HAVING COUNT(*) >= 1 
ORDER BY COUNT(*) DESC , a.Id

