# Power BI Report Server a Deep Dive support material

Sample code and demo material from our presentation Power BI Report Server: a Deep Dive.

## Sections

This repository contains four sections/folders:
* Power BI Reports
* PowerShell Scripts
* SSMS Queries
* Slide Deck

### Power BI Reports

In the Power BI Reports folder you can find an example of an Usage Log PBIRS Power BI report.
This report can be used to show the Report Server usage Log and the list of Power BI reports data sources.

The report connects two different data sources:
* **SQL Server database connection to PBIRS database catalog** - localhost;ReportServer_PBIRS (change the server and database name to point at your PBIRS database catalog)
* **OData API to PBIRS** - http(s)://pbilabrs1/Reports_PBIRS/api/v2.0 (change the report server name to point at your PBIRS portal) 

### PowerShell Scripts

In the PowerShell Scripts folder you can find some examples of how you can use PowerShell to manage your Power BI Report Server:

* **Create-New-Folder.ps1**: simple script that can be used to check if a folder exists and create a subfolder inside it  - it uses the ReportingServicesTools PowerShell Module
* **Add User With Permission.ps1**: simple script that can be used to add an user to a specific PBIRS folder with a specific role
* **Update-PowerBiSecurity.ps1**: simple script that can be used to update massively the PBIRS security policy of specific folders

PowerShell Modeule used: **ReportingServicesTools**. The module provides extra functionality for SSRS (SQL Server Reporting Services) and Power BI Report Server. The Create-New-Folder script is just a basic example of what you can do using this module. The module includes the ability to deploy SSRS Reports, Datasets, and DataSources; as well as Power BI Reports.

### SSMS Queries

In the SSMS Queries folder you can find some examples of SQL Queries you could use to manage your PBIRS:

* **PBIRS ConfigurationInfo.sql**: simple query to list the properties of your PBIRS
* **PBIRS Change Execution Log Days Kept Property.sql**: simple query to change the retention policy of your PBIRS execution logs
* **PBIRS Execution Log.sql**: simple query to retrieve the execution logs for your Paginated Reports and Power BI reports
* **PBIRS Folder Structure.sql**: simple query with CTE to verify your PBIRS folder structure
* **PBIRS Folder Structure, Paginated Reports, Power BI Reports Security.sql**: simple query to check the security policies of your PBIRS Folders, Paginated Reports and Power BI reports

### Slide Deck

In the Slide Deck folder you can find the presentation file in a pdf format.

## Built With

* [Power BI Desktop Optimized for Report Server](https://www.microsoft.com/en-us/download/details.aspx?id=56722) - The Power BI Report Desktop May 2020 authoring tool used
* [Power BI Report Server](https://www.microsoft.com/en-us/download/details.aspx?id=56722) - The Power BI Report Server May 2020 edition
* [ReportingServicesTools](https://www.powershellgallery.com/packages/ReportingServicesTools/0.0.5.6) - PowerShell module used
* [PBIRS API v2.0](https://app.swaggerhub.com/apis/microsoft-rs/PBIRS/2.0) - PBIRS API used 

## Authors

* **Luca Gualtieri** - [LinkedIn](https://www.linkedin.com/in/lucagualtieri/)
* **PBI Lab Inc.** - [PBI Lab](https://www.pbilab.com)

## License

This repository is licensed under the GNU GPL v3.0 License - see the [LICENSE.md](LICENSE.md) file for details.