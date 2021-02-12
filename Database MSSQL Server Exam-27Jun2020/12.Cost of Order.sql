CREATE FUNCTION udf_GetCost(@JobId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
DECLARE @Result DECIMAL(18,2) = (SELECT SUM(op.Quantity * p.Price)
                                 FROM Jobs AS j
                                 LEFT JOIN Orders AS o ON o.JobId = j.JobId
                                 LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
                                 LEFT JOIN Parts AS p ON p.PartId = op.PartId
                                 WHERE j.JobId = @JobId
                                 GROUP BY j.JobId )
IF(@Result IS NULL)
RETURN 0
						  
RETURN @Result
END