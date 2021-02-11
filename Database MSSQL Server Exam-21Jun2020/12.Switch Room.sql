--PROBLEM 12

CREATE PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
BEGIN

DECLARE @tripHotelId INT = (SELECT TOP(1) r.HotelId 
                            FROM Trips AS t
						    JOIN Rooms AS r ON r.Id = t.RoomId
							WHERE @TripId = t.Id)

DECLARE @targetRoomHotelId INT= (SELECT TOP(1) h.Id
                                FROM Hotels AS h
								JOIN Rooms as r ON r.HotelId = h.Id
								WHERE @TargetRoomId = r.Id)

IF(@tripHotelId != @targetRoomHotelId)
THROW 50001 , 'Target room is in another hotel!' , 1

DECLARE @targetRoomBedsCount INT = (SELECT r.Beds
                                    FROM Rooms AS r
									WHERE r.Id= @TargetRoomId)

DECLARE @tripRoomBedsCount INT = (SELECT COUNT(AccountId) 
                                  FROM AccountsTrips AS ac
								  WHERE ac.TripId = @TripId)

IF(@targetRoomBedsCount < @tripRoomBedsCount)
THROW 50002 , 'Not enough beds in target room!' , 1

UPDATE Trips
SET RoomId = @TargetRoomId
WHERE Id = @TripId

END


