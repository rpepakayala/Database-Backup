/****** Object:  Table [dbo].[CalendarLink]    Script Date: 5/15/2018 12:06:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CalendarLink](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[SortIndex] [int] NULL,
	[JournalID] [int] NULL,
	[JournalStoreID] [int] NULL,
	[JournalClassTypeID] [int] NULL,
	[CalendarID] [int] NULL,
	[CalendarStoreID] [int] NULL,
	[CalendarClassTypeID] [int] NULL,
	[RoleName] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [CalendarLink_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_CalendarLink_sidCalendarID]    Script Date: 5/15/2018 12:06:41 PM ******/
CREATE NONCLUSTERED INDEX [Index_CalendarLink_sidCalendarID] ON [dbo].[CalendarLink]
(
	[CalendarID] ASC,
	[CalendarStoreID] ASC,
	[CalendarClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_CalendarLink_sidJournalID]    Script Date: 5/15/2018 12:06:41 PM ******/
CREATE NONCLUSTERED INDEX [Index_CalendarLink_sidJournalID] ON [dbo].[CalendarLink]
(
	[JournalID] ASC,
	[JournalStoreID] ASC,
	[JournalClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
