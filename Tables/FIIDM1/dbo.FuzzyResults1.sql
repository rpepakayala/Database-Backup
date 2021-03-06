/****** Object:  Table [dbo].[FuzzyResults1]    Script Date: 5/15/2018 11:59:52 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FuzzyResults1](
	[CustomerKey] [int] NULL,
	[CustomerName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManualOverride_CustomerIndustry] [bit] NULL,
	[CustomerIndustryName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T_WebNumber] [smallint] NULL,
	[T_CustomerID] [int] NULL,
	[T_StoreID] [int] NULL,
	[T_IndustryTypeID] [int] NULL,
	[T_IndustryType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T_PrelimCustomerIndustry] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T_Country] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryDetail] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerIndustryName NEW] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_Similarity] [real] NULL,
	[_Confidence] [real] NULL,
	[_Similarity_CountryCode] [real] NULL,
	[_Similarity_CustomerIndustryName] [real] NULL
) ON [PRIMARY]

GO
