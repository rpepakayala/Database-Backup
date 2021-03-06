/****** Object:  Table [dbo].[Address]    Script Date: 5/15/2018 12:06:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Address](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[StreetAddress1] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StreetAddress2] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[County] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalCode] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FormattedText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxClassID] [int] NULL,
	[IsValidated] [bit] NULL,
	[ValidatedAddress] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HasValidationError] [bit] NULL,
	[ValidationError] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [Address_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Indexs_Address]    Script Date: 5/15/2018 12:06:41 PM ******/
CREATE NONCLUSTERED INDEX [Indexs_Address] ON [dbo].[Address]
(
	[City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
