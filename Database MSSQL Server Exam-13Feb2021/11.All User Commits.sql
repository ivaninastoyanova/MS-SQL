CREATE FUNCTION udf_AllUserCommits(@username VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @Result INT= (SELECT COUNT(*)
                      FROM Users AS u
                      JOIN Commits AS c ON c.ContributorId = u.Id
                      WHERE Username = @username)
RETURN @Result
END
