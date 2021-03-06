/****** Object:  Table [dbo].[ContactActivity]    Script Date: 5/15/2018 12:06:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ContactActivity](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[AllDayEvent] [bit] NULL,
	[AutoRollOver] [bit] NULL,
	[AutoRun] [bit] NULL,
	[Color] [int] NULL,
	[ContactActivityType] [int] NULL,
	[ContactActivityTypeText] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactCallType] [int] NULL,
	[ContactCallTypeText] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedByID] [int] NULL,
	[CreatedDateTime] [datetime] NULL,
	[ImageID] [int] NULL,
	[IsFromRecurring] [bit] NULL,
	[IsTimeless] [bit] NULL,
	[Location] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OriginalScheduledDateTime] [datetime] NULL,
	[Priority] [int] NULL,
	[PriorityText] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrivateEvent] [bit] NULL,
	[RecurringActivityID] [int] NULL,
	[RunWithoutPrompting] [bit] NULL,
	[ScheduledEndDateTime] [datetime] NULL,
	[ScheduledStartDateTime] [datetime] NULL,
	[Result] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValidStatus] [int] NULL,
	[TransPartID] [int] NULL,
	[TransPartStoreID] [int] NULL,
	[TransPartClassTypeID] [int] NULL,
	[PartInstanceID] [int] NULL,
	[IsLocked] [bit] NULL,
	[LocationID] [int] NULL,
	[LocationStoreID] [int] NULL,
	[LocationClassTypeID] [int] NULL,
 CONSTRAINT [ContactActivity_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_ContactActivity_siLocationID]    Script Date: 5/15/2018 12:06:43 PM ******/
CREATE NONCLUSTERED INDEX [Index_ContactActivity_siLocationID] ON [dbo].[ContactActivity]
(
	[LocationID] ASC,
	[LocationStoreID] ASC,
	[LocationClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_ContactActivity]    Script Date: 5/15/2018 12:06:43 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_ContactActivity] ON [dbo].[ContactActivity]
(
	[ContactActivityType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
