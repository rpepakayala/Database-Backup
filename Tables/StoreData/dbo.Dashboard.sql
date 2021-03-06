/****** Object:  Table [dbo].[Dashboard]    Script Date: 5/15/2018 12:06:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Dashboard](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[DashboardName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DashboardType] [int] NULL,
	[DashboardTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShowOnMenu] [bit] NULL,
	[UserID] [int] NULL,
	[UserStoreID] [int] NULL,
	[UserClassTypeID] [int] NULL,
	[ColumnCount] [int] NULL,
	[DashboardXML] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsShared] [bit] NULL,
	[IsLocked] [bit] NULL,
	[IncludedFranchises] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExcludedFranchises] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [Dashboard_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
