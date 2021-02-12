SELECT m.FirstName + ' ' + m.LastName AS Mechanic,
       AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate))
FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId = m.MechanicId
GROUP BY m.MechanicId,m.FirstName + ' ' + m.LastName
ORDER BY m.MechanicId