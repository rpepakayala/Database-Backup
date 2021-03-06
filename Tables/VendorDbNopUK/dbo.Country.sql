/****** Object:  Table [dbo].[Country]    Script Date: 5/15/2018 12:08:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AllowsBilling] [bit] NOT NULL,
	[AllowsShipping] [bit] NOT NULL,
	[TwoLetterIsoCode] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThreeLetterIsoCode] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NumericIsoCode] [int] NOT NULL,
	[SubjectToVat] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_Country_DisplayOrder]    Script Date: 5/15/2018 12:08:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_Country_DisplayOrder] ON [dbo].[Country]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
