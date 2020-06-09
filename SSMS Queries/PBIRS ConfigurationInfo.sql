/*
.SYNOPSIS
    List PBIRS configuration properties
.DESCRIPTION
    The query is used to list the properties of your PBIRS installation.
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0
*/
USE [ReportServer_PBIRS]
GO
SELECT Name, Value 
FROM ConfigurationInfo