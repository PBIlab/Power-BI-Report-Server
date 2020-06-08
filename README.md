# Power BI Report Server a Deep Dive support material

Sample code and demo material from our presentation Power BI Report Server: a Deep Dive

## Sections

This repository contains two sections/folders:
* Power BI Reports
* PowerShell Scripts
* SSMS Queries
* Slide Deck

### Power BI Reports

In the Power BI Reports folder you can find an example of an Usage Log PBIRS Power BI report.
This report can be used to show the Report Server usage Log and the list of power bi reports data sources.

The report connects two different data sources:
* SQL Server database connection to PBIRS database catalog - localhost;ReportServer_PBIRS (change the server and database name to point at your PBIRS database catalog)
* OData API to PBIRS - http(s)://pbilabrs1/Reports_PBIRS/api/v2.0 (change the report server name to point at your PBIRS portal) 

### PowerShell Scripts

In the Power Shell Scripts folder you can find some example....

PowerShell Modeule used: ReportingServicesTools
Provides extra functionality for SSRS (SQL Server Reporting Services) and Power BI Report Server.  Includes the ability to deploy SSRS Reports, Datasets, and DataSources; as well as Power BI Reports.

### SSMS Queries

### Slide Deck

### PowerShell Scripts

## Built With

* [Power BI Desktop Optimized for Report Server](https://www.microsoft.com/en-us/download/details.aspx?id=56722) - The Power BI Report Desktop May 2020 authoring tool used
* [Power BI Report Server API](https://www.microsoft.com/en-us/download/details.aspx?id=56722) - The Power BI Report Server May 2020 edition
* [ReportingServicesTools](https://www.powershellgallery.com/packages/ReportingServicesTools/0.0.5.6) - PowerShell module used
* [PBIRS API v2.0](https://app.swaggerhub.com/apis/microsoft-rs/PBIRS/2.0) - PBIRS API used 

## Authors

* **Luca Gualtieri** - [LinkedIn](https://www.linkedin.com/in/lucagualtieri/)
* **PBI Lab Inc.** - [PBI Lab](https://www.pbilab.com)

## License

This repository is licensed under the GNU GPL v3.0 License - see the [LICENSE.md](LICENSE.md) file for details.