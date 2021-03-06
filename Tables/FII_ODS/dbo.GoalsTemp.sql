/****** Object:  Table [dbo].[GoalsTemp]    Script Date: 5/15/2018 11:59:25 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GoalsTemp](
	[ZW_Franchise_ID] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MonthText] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month] [int] NOT NULL,
	[Year] [smallint] NULL,
	[SalesTotal] [money] NULL,
	[CoreDate] [date] NULL,
	[OLTP_InsertDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
