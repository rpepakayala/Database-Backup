/****** Object:  Table [dbo].[RecurringActivity]    Script Date: 5/15/2018 12:06:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RecurringActivity](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[Month] [int] NULL,
	[Day] [int] NULL,
	[Interval] [int] NULL,
	[RecurrenceType] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndType] [int] NULL,
	[EndInterval] [int] NULL,
	[EndDate] [datetime] NULL,
	[LookAheadCount] [int] NULL,
	[TemplateID] [int] NULL,
	[LastScheduled] [datetime] NULL,
	[NextScheduled] [datetime] NULL,
	[TemplateClassTypeID] [int] NULL,
	[DayInDaySet] [int] NULL,
	[MonthlyInterval] [int] NULL
) ON [PRIMARY]

/****** Object:  Index [RecurringActivity_PK]    Script Date: 5/15/2018 12:06:53 PM ******/
CREATE UNIQUE CLUSTERED INDEX [RecurringActivity_PK] ON [dbo].[RecurringActivity]
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
