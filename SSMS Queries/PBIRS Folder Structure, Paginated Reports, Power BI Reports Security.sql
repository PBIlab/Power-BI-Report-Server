/*
.SYNOPSIS
    PBIRS Folder Structure
.DESCRIPTION
    The query uses a CTE to retrieve your PBIRS folder structure.
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0
*/

USE [ReportServer_PBIRS]
GO
SELECT
	CASE WHEN E.Path = '' THEN '/' ELSE E.Path END AS Path, 
	CASE WHEN E.Name = '' THEN 'Home' ELSE E.Name END AS Name,
	UPPER(C.UserName) as UserName, 
	D.RoleName, 
	D.Description,
	E.Type
FROM dbo.PolicyUserRole A
INNER JOIN dbo.Policies B on A.PolicyID = B.PolicyID
INNER JOIN dbo.Users C on A.UserID = C.UserID
INNER JOIN dbo.Roles D on A.RoleID = D.RoleID
INNER JOIN dbo.Catalog E on A.PolicyID = E.PolicyID
WHERE E.Type in (1,2,13) --1: FOLDER, 13: PBI REPORT, 2: PAGINATED REPORT
AND E.Path not like '/68f0607b-9378-4bbb-9e70-4da3d7d66838%'
ORDER BY E.Path,E.Name,C.UserName