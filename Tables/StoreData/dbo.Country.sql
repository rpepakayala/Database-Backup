/****** Object:  Table [dbo].[Country]    Script Date: 5/15/2018 12:06:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Country](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[Country] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryShortName] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryCode] [int] NULL,
	[PhoneFormatString] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneTemplate] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AddressFormatString] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AreaCodeDigits] [int] NULL,
	[ZipMaxDigits] [int] NULL,
	[ZipShortDigits] [int] NULL,
	[TranslationLanguage] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [Country_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_Country_Country]    Script Date: 5/15/2018 12:06:43 PM ******/
CREATE NONCLUSTERED INDEX [Index_Country_Country] ON [dbo].[Country]
(
	[Country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_Country]    Script Date: 5/15/2018 12:06:43 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_Country] ON [dbo].[Country]
(
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
