/****** Object:  Table [dbo].[EmployeeContact]    Script Date: 5/15/2018 12:06:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[EmployeeContact](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[Notes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Position] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MainPhoneNumberID] [int] NULL,
	[MainFaxNumberID] [int] NULL,
	[EmployeeID] [int] NULL,
	[PrimaryNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriNumberTypeID] [int] NULL,
	[PriNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecNumberTypeID] [int] NULL,
	[SecNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThirdNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThirdNumberTypeID] [int] NULL,
	[ThirdNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [EmployeeContact_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_EmployeeContact_EmployeeID]    Script Date: 5/15/2018 12:06:45 PM ******/
CREATE NONCLUSTERED INDEX [Index_EmployeeContact_EmployeeID] ON [dbo].[EmployeeContact]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Indexes_EmployeeContact]    Script Date: 5/15/2018 12:06:45 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_EmployeeContact] ON [dbo].[EmployeeContact]
(
	[FirstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
