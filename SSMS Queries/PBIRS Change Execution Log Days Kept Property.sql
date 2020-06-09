/*
.SYNOPSIS
    Change the ExecutionLogDaysKept property value
	Reference: https://docs.microsoft.com/en-us/sql/reporting-services/tools/server-properties-advanced-page-reporting-services?view=sql-server-ver15
.DESCRIPTION
    This query is used to update at 365 days the retention policy for your PBIRS Execution logs.
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0
*/
USE [ReportServer_PBIRS]
GO
UPDATE ConfigurationInfo
SET Value = '365'
WHERE Name = 'ExecutionLogDaysKept'