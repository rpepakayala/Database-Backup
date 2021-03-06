/****** Object:  Table [dbo].[Language]    Script Date: 5/15/2018 12:03:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LanguageCulture] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UniqueSeoCode] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FlagImageFileName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Published] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_Language_DisplayOrder]    Script Date: 5/15/2018 12:03:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_Language_DisplayOrder] ON [dbo].[Language]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
