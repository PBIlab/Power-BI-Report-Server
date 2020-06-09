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
;WITH items AS (
    SELECT 
	 [ItemID]
    ,CAST(case when [Path] = '' then 'Home' else 'Home'+ [Path] end AS VARCHAR(255)) as [Path]
	,CAST('0' as VARCHAR) as [Level]
    ,CAST('Level 0' + ' - ' +CAST(case when [Path] = '' then 'Home' else 'Home'+ [Path] end AS VARCHAR(255)) AS VARCHAR(255)) as [LevelPath]
    FROM [Catalog] 
    WHERE [ParentID] IS NULL

    UNION ALL

    SELECT 
	 i.[ItemID]
    ,CAST(case when i.[Path] = '' then 'Home' else 'Home'+ i.[Path] end AS VARCHAR(255))
	,CAST([Level]+1 as VARCHAR)
    ,CAST('Level ' + CAST([Level] + 1 AS VARCHAR) + ' - ' +case when i.[Path] = '' then 'Home' else 'Home'+ i.[Path] end AS VARCHAR(255))
    FROM [Catalog] i
    INNER JOIN items itms ON itms.[ItemID] = i.[ParentID]
	WHERE isnull(i.[Hidden],1) = 0
	AND i.[Type] = 1
)
SELECT * FROM items ORDER BY Path