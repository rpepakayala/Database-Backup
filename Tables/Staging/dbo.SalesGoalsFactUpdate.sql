/****** Object:  Table [dbo].[SalesGoalsFactUpdate]    Script Date: 5/15/2018 12:06:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SalesGoalsFactUpdate](
	[SalesGoalsKey] [int] NULL,
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

GO
