/****** Object:  Table [Store].[SalesGoalsFact]    Script Date: 5/15/2018 11:59:45 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[SalesGoalsFact](
	[ID] [int] NOT NULL,
	[MonthText] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month] [smallint] NULL,
	[Year] [smallint] NULL,
	[SalesTotal] [money] NULL,
	[SalesWIP1] [money] NULL,
	[SalesWIP2] [money] NULL,
	[SalesWIP3] [money] NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[YearOf] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
	[CenterKey] [int] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IDX_SalesGoal_Month_Year]    Script Date: 5/15/2018 11:59:45 AM ******/
CREATE NONCLUSTERED INDEX [IDX_SalesGoal_Month_Year] ON [Store].[SalesGoalsFact]
(
	[Month] ASC,
	[Year] ASC
)
INCLUDE ( 	[SalesTotal],
	[ZW_Franchise_ID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [Store].[SalesGoalsFact] ADD  CONSTRAINT [DF_SalesGoalsFact_CenterKey]  DEFAULT ((0)) FOR [CenterKey]
GO
