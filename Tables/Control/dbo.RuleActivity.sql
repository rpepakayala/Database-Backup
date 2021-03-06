/****** Object:  Table [dbo].[RuleActivity]    Script Date: 5/15/2018 11:58:55 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RuleActivity](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[AutoRollOver] [bit] NULL,
	[AutoRun] [bit] NULL,
	[Color] [int] NULL,
	[CreatedByID] [int] NULL,
	[CreatedDateTime] [datetime] NULL,
	[ImageID] [int] NULL,
	[IsFromRecurring] [bit] NULL,
	[IsTimeless] [bit] NULL,
	[OriginalScheduledDateTime] [datetime] NULL,
	[Priority] [int] NULL,
	[PriorityText] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrivateEvent] [bit] NULL,
	[RecurringActivityID] [int] NULL,
	[RunWithoutPrompting] [bit] NULL,
	[ScheduledEndDateTime] [datetime] NULL,
	[ScheduledStartDateTime] [datetime] NULL,
	[RuleID] [int] NULL,
	[RuleStoreID] [int] NULL,
	[RuleClassTypeID] [int] NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_RuleActivity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
