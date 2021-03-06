/****** Object:  Table [dbo].[CustomerIndustryDim]    Script Date: 5/15/2018 11:59:50 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CustomerIndustryDim](
	[IndustryKey] [int] IDENTITY(59,1) NOT NULL,
	[IndustryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryNameForFuzzy]  AS ([IndustryName]),
 CONSTRAINT [PK_CustomerIndustryDim] PRIMARY KEY NONCLUSTERED 
(
	[IndustryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_CustomerIndustryDim]    Script Date: 5/15/2018 11:59:50 AM ******/
CREATE CLUSTERED INDEX [IX_CustomerIndustryDim] ON [dbo].[CustomerIndustryDim]
(
	[IndustryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
