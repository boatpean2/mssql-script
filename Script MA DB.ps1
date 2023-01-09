# install module importexcel to Export to xlsx files #
Install-Module -Name ImportExcel
Import-Module SQLPS
Install-Module Pester -SkipPublisherCheck -Force -RequiredVersion 4.10.0
Import-Module Pester -Force -RequiredVersion 4.10.0

# list table and record count #
Get-DbaDbTable -SqlInstance "dmsxag1-db\dmsx,57623" -Database CONs_DB | Select-Object ComputerName,InstanceName,Database,FileGroup,Name,RowCount | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_TABLEROW.xlsx" -WorksheetName CONs_DB 
 
# list index fragmentation #
Get-DbaHelpIndex -SqlInstance 'dmsxag1-db\dmsx,57623' -Database ANSx_DB -IncludeFragmentation | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_FRAGMENT.xlsx" -WorksheetName ANSx_DB

# disk space #
Get-DbaDiskSpace -ComputerName DMSX-DB | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_DISKSPACE.xlsx" -WorksheetName DISKSPACE

# mssql and windows version
Invoke-Sqlcmd -ServerInstance 'dmsxag1-db\dmsx,57623' -Query "SELECT @@VERSION" | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_VERSION.xlsx" -WorksheetName MSSQL
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName DMSX-DB | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_VERSION.xlsx" -WorksheetName OS

# find unused/duplicate index
Find-DbaDbDuplicateIndex -SqlInstance 'dmsxag1-db\dmsx,57623' -Database ANSx_DB -IncludeOverlapping | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_DUPINDEX.xlsx" -WorksheetName ANSx_DB
Find-DbaDbUnusedIndex -SqlInstance 'dmsxag1-db\dmsx,57623' -Database ANSx_DB | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_UNUSEDINDEX.xlsx" -WorksheetName ANSx_DB


# Backup Using ola script that Create on SSMS


# Database Validation
Invoke-Sqlcmd -ServerInstance 'dmsxag1-db\dmsx,57623' -Query "DBCC CHECKDB (N'ISUDB')"
Get-DbaLastGoodCheckDb -SqlInstance "dmsxag1-db\dmsx,57623" | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_CHECKDB.xlsx" -WorksheetName CHECKDB_SUMMARY

# SQL Agent Job List
Get-DbaAgentJobHistory -SqlInstance 'dmsxag1-db\dmsx,57623' -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date) | Export-Excel "D:\MA-MSSQL\Q42022_DMSX-DB_JOBLIST.xlsx" -WorksheetName JOB
