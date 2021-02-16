SELECT TOP(5) r.Id ,
             r.Name,
	         COUNT(*) AS Commits
FROM RepositoriesContributors AS rc
JOIN Repositories AS r ON r.Id = rc.RepositoryId
JOIN Commits AS c ON c.RepositoryId = r.Id
GROUP BY r.Id ,r.Name
ORDER BY COUNT(*) DESC ,r.Id , r.Name