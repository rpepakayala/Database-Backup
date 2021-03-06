/****** Object:  Table [dbo].[Country]    Script Date: 5/15/2018 11:58:49 AM ******/
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
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
