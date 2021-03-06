/****** Object:  Table [dbo].[ContactDim]    Script Date: 5/15/2018 11:59:50 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ContactDim](
	[ContactKey] [int] IDENTITY(1,1) NOT NULL,
	[ContactName]  AS (case [FirstName] when 'Unknown' then 'Unknown' else ([FirstName]+' ')+[LastName] end),
	[IsRowCurrent] [bit] NULL,
	[FirstName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneExtention] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FaxNumber] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneAreaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FaxAreaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BirthMonth] [int] NULL,
	[BirthDay] [int] NULL,
	[IsActive] [bit] NULL,
	[InsertDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[T_WebNumber] [smallint] NULL,
	[T_ContactID] [int] NULL,
	[T_StoreID] [int] NULL,
	[T_CustomerID] [int] NULL,
	[T_ZW_Franchise_ID] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ContactDim] PRIMARY KEY CLUSTERED 
(
	[ContactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_ContactDim_ContactLookup]    Script Date: 5/15/2018 11:59:50 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContactDim_ContactLookup] ON [dbo].[ContactDim]
(
	[T_WebNumber] ASC,
	[T_ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ContactDim] ADD  CONSTRAINT [DF_ContactDim_IsRowCurrent]  DEFAULT ((1)) FOR [IsRowCurrent]
GO
