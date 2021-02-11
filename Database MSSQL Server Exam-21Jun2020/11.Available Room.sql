--PROBLEM 11

CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE , @People INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @roomToGive INT = (SELECT  TOP(1) r.Id
                            FROM Hotels AS h
                            JOIN Rooms AS r ON r.HotelId = h.Id
                            JOIN Trips AS t ON t.RoomId = r.Id
                            WHERE h.Id = @HotelId 
						          AND @Date NOT BETWEEN t.ArrivalDate AND t.ReturnDate
								  AND YEAR(@Date) = YEAR(t.ArrivalDate)
                                  AND t.CancelDate IS NULL
                            	  AND r.Beds >= @People
                            ORDER BY (r.Price + h.BaseRate) DESC)
IF(@roomToGive IS NULL)
RETURN 'No rooms available'

DECLARE @roomPrice DECIMAL(18,2) = (SELECT Price 
                                    FROM Rooms AS r 
					                 WHERE r.Id = @roomToGive)
DECLARE @roomType VARCHAR(100) = (SELECT r.Type 
                             FROM Rooms AS r 
					         WHERE r.Id = @roomToGive)
DECLARE @bedsCount INT = (SELECT r.Beds 
                             FROM Rooms AS r 
					         WHERE r.Id = @roomToGive)
DECLARE @hotelBaseRate DECIMAL(18,2) = (SELECT BaseRate 
                                        FROM Hotels AS h 
						                WHERE @HotelId = h.Id) 

DECLARE @totalPrice DECIMAL(18,2) = (@hotelBaseRate + @roomPrice)* @People;


RETURN 'Room ' + CONVERT(VARCHAR, @roomToGive) + ': ' +
       CONVERT(VARCHAR, @roomType) + ' (' + CONVERT(VARCHAR, @bedsCount)
	   +' beds) ' + '- $' + CONVERT(VARCHAR, @totalPrice)
END


