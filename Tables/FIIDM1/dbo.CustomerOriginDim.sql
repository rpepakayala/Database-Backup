/****** Object:  Table [dbo].[CustomerOriginDim]    Script Date: 5/15/2018 11:59:50 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CustomerOriginDim](
	[OriginKey] [int] IDENTITY(1,1) NOT NULL,
	[OriginName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OriginNameForFuzzy]  AS ([OriginName]),
 CONSTRAINT [PK_CustomerOriginDim] PRIMARY KEY NONCLUSTERED 
(
	[OriginKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_CustomerOriginDim]    Script Date: 5/15/2018 11:59:50 AM ******/
CREATE CLUSTERED INDEX [IX_CustomerOriginDim] ON [dbo].[CustomerOriginDim]
(
	[OriginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
