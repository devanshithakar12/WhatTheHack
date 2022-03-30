RENAME OBJECT FACTINTERNETSALESREASON TO FACTINTERNETSALESREASON_OLD
GO

CREATE TABLE [DBO].[FACTINTERNETSALESREASON]
(
	[SALESORDERNUMBER] [NVARCHAR](20) NOT NULL,
	[SALESORDERLINENUMBER] [SMALLINT] NOT NULL,
	[SALESREASONKEY] [INT] NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [SALESORDERNUMBER] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO

INSERT INTO [FACTINTERNETSALESREASON]
SELECT  
	[SALESORDERNUMBER]
	, [SALESORDERLINENUMBER]
	, ABS(CHECKSUM(NEWID())) % 10 + 1 [SALESREASONKEY]
FROM FACTINTERNETSALES 
GO
