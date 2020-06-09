/*
.SYNOPSIS
    Query the Execution logs for Paginated Reports and Power BI Reports
.DESCRIPTION
    This query is used to retrieve the Execution logs for the Paginated Reports and Power BI Reports in your PBIRS catalog.
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0
*/
USE [ReportServer_PBIRS]
GO
SELECT  [InstanceName]
		,reverse(left(reverse([ReportPath]), charindex('/', reverse([ReportPath])) -1)) Report
		,c.Description
		,c.ItemID
		,c.ParentID
	    ,Replace([UserName],'teckcominco\','') UserName
		,[RequestType]
		,TimeStart
	    ,TimeEnd
		,ByteCount
		,DATEADD(dd, DATEDIFF(dd, 0, TimeStart), 0) AccessDate
		,DatePart(MM, Timestart) MonthNumber
		,DateName(mm, TimeStart) Month
		,DatePart(yyyy, TimeStart) Year
		,DatePart(Dd, Timestart) Day
		,DatePart(dw, TimeStart) WeekDayNumber
		,datename(dw,TimeStart) WeekDay
		,1 as AccessCount
FROM [dbo].[ExecutionLog2] E
INNER JOIN [dbo].[Catalog] C on E.ReportPath = C.Path
WHERE C.[Type] in (2,13) 
ORDER BY TimeStart desc