SELECT m.FirstName + ' ' + m.LastName AS [Available]
FROM Mechanics AS m
LEFT JOIN Jobs AS j ON j.MechanicId = m.MechanicId
WHERE j.MechanicId IS NULL OR j.Status = 'Finished'
GROUP BY m.FirstName + ' ' + m.LastName , m.MechanicId
ORDER BY m.MechanicId