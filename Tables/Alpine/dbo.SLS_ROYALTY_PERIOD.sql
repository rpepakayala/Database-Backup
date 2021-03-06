/****** Object:  Table [dbo].[SLS_ROYALTY_PERIOD]    Script Date: 5/15/2018 11:58:40 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_ROYALTY_PERIOD](
	[RoyaltyPeriodID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[StoreID] [bigint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[FiscalYear]  AS (case when datepart(month,[EndDate])>=(10) then datepart(year,[EndDate])+(1) else datepart(year,[EndDate]) end),
 CONSTRAINT [PK_SLS_ROYALTY_PERIOD] PRIMARY KEY CLUSTERED 
(
	[RoyaltyPeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_SLS_ROYALTY_PERIOD_StoreID_RoyaltyPeriodID_EndDate]    Script Date: 5/15/2018 11:58:40 AM ******/
CREATE NONCLUSTERED INDEX [IX_SLS_ROYALTY_PERIOD_StoreID_RoyaltyPeriodID_EndDate] ON [dbo].[SLS_ROYALTY_PERIOD]
(
	[StoreID] ASC
)
INCLUDE ( 	[RoyaltyPeriodID],
	[EndDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
