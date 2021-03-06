/****** Object:  Table [dbo].[Currency]    Script Date: 5/15/2018 12:03:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Currency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CurrencyCode] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Rate] [decimal](18, 4) NOT NULL,
	[DisplayLocale] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomFormatting] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Published] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_Currency_50_1954822026__K2_K8_K1_K9_3_4_5_6_7_10_11]    Script Date: 5/15/2018 12:03:42 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Currency_50_1954822026__K2_K8_K1_K9_3_4_5_6_7_10_11] ON [dbo].[Currency]
(
	[StoreId] ASC,
	[Published] ASC,
	[Id] ASC,
	[DisplayOrder] ASC
)
INCLUDE ( 	[Name],
	[CurrencyCode],
	[Rate],
	[DisplayLocale],
	[CustomFormatting],
	[CreatedOnUtc],
	[UpdatedOnUtc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [ix_Currency_StoreId]    Script Date: 5/15/2018 12:03:42 PM ******/
CREATE NONCLUSTERED INDEX [ix_Currency_StoreId] ON [dbo].[Currency]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Currency] ADD  DEFAULT ((0)) FOR [StoreId]
GO
