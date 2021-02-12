SELECT * 
FROM Mechanics
WHERE FirstName = 'Ryan' AND LastName = 'Harnos'
--id = 3

UPDATE Jobs
SET Status = 'In Progress', MechanicId = 3
WHERE Status = 'Pending'