Find-DbaDbDuplicateIndex -SqlInstance "ddoc-db\dds,62149" -Database DDS_DB -IncludeOverlapping -Verbose | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table
Find-DbaDbUnusedIndex -SqlInstance "ddoc-db\dds,62149" -Database DDS_DB -Verbose | Select-Object Table,IndexName,KeyColumns,RowCount | Format-Table -AutoSize
Find-DbaDbUnusedIndex -SqlInstance "dmsxag1-db\dmsx,57623" -Database DmsDB -Verbose | Select-Object Table,IndexName,KeyColumns,RowCount
Find-DbaDbUnusedIndex -SqlInstance "dmsxag1-db\dmsx,57623" -Database InsDB -Verbose | Select-Object Table,IndexName,KeyColumns,RowCount

Find-DbaDbDuplicateIndex -SqlInstance "dmsxag1-db\dmsx,57623" -Database DmsDB -IncludeOverlapping -Verbose | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table -AutoSize
Find-DbaDbDuplicateIndex -SqlInstance "dmsxag1-db\dmsx,57623" -Database InsDB -IncludeOverlapping -Verbose | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table -AutoSize


Copy-DbaDbTableData -SqlInstance ptcdb -Destination "ucubedb\ucube,53571" -Database MDB_Integration -DestinationDatabase UCUBE_PEA -Table [dbo].[PTC_AMOUNT] -DestinationTable [dbo].[PEA_DAY_PTC_AMOUNT] -Verbose
Get-DbaDbTable -SqlInstance ptcdb -Database MDB_Integration -Table  | Copy-DbaDbTableData -Destination sql2

Get-DbaLastGoodCheckDb -SqlInstance "dmsxag1-db\dmsx,57623" | Format-Table -AutoSize -Verbose
Invoke-DbaDbDbccCheckConstraint -SqlInstance "dmsxag1-db\dmsx,57623" -Verbose


Invoke-DbaBalanceDataFiles -SqlInstance "dmsxag1-db\dmsx,57623"  -Database DmsDB -Verbose
Invoke-DbaBalanceDataFiles -SqlInstance hq-smilefb-ag1  -Database AnalyzeDB -Verbose

Invoke-DbaBalanceDataFiles -SqlInstance "ddoc-db\dds,62149"  -Database DDS_DB -Verbose

Invoke-DbaDbShrink -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Database ISUDB -PercentFreeSpace 80 -FileType Data -StepSize 25MB -verbose



Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENT3RD_2021.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENT3RD_2020.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENT3RD_2019.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENT3RD_2018.archive] ## Success

Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENTBPM_2018.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENTBPM_2019.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENTBPM_2020.archive] ## Success
Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination "ECSDB-2020\CSERVICE_2020,59356" -Database ISUDB -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENTBPM_2021.archive] ## Success


Copy-DbaDbTableData -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Destination can-db -Database dpa -DestinationDatabase ISUDB_2020 -Table [CA].[PAYMENTBPM_2021.archive] ## Success

Install-DbaMaintenanceSolution -SqlInstance "ECSDB01-VM\CSERVICE,63001" -Database master -Force -ReplaceExisting -InstallJobs

Copy-DbaAgentJob -Source ptcdb-old -Destination ptcdb -Verbose


Find-DbaDbDuplicateIndex -SqlInstance hq-smilefb-ag1 -Database AnalyzeDB  -IncludeOverlapping -Verbose | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table -AutoSize


Install-DbaFirstResponderKit -SqlInstance ptcdb -Database master

Find-DbaDbDuplicateIndex -SqlInstance "ptcdb\ptc,1433" -Database MDB_Integration -Verbose -IncludeOverlapping | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table

Find-DbaDbUnusedIndex -SqlInstance "SMARTPLUS2-DB3\SMARTPLUS,59156" -Database PEASmartPlus2 -Verbose | Select-Object Table,IndexName,KeyColumns,RowCount | Format-Table -AutoSize
Find-DbaDbDuplicateIndex -SqlInstance "SMARTPLUS2-DB3\SMARTPLUS,59156" -Database PEASmartPlus2 -Verbose -IncludeOverlapping | Select-Object TableName,IndexName,KeyColumns,RowCount,IsDisabled | Format-Table

Invoke-DbaDbShrink -SqlInstance "SMARTPLUS2-DB3\SMARTPLUS,59156" -Database PEASmartPlus2 -FileType Data -StepSize 25MB -verbose
Test-DbaMigrationConstraint -Source "ucubedb02\ucube,53572" -Destination "ucubedb02\ucube,53572" -Verbose
Start-DbaMigration  -Source "ucubedb02\ucube,53572" - -Destination "ucubedb02\ucube,53572" -Verbose

Copy-DbaDbTableData -SqlInstance emi-md-db -Destination emi-md-db -Database PLMS -DestinationDatabase PLMS-RC -Verbose ## Success

Copy-DbaAgentJob -Source "dmsxag1-db\dmsx,57623" -Destination "ECSDB01-VM\CSERVICE,63001" -Job "04-DmsDB LOG BACKUP" -Verbose
