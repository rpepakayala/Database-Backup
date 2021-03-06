/****** Object:  Table [dbo].[SEC_PAGES]    Script Date: 5/15/2018 11:59:13 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SEC_PAGES](
	[PageID] [int] NOT NULL,
	[URL] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Parameters] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccessCode] [int] NOT NULL,
	[DateCreated] [datetime] NULL,
	[DateLastModified] [datetime] NULL,
	[AvailableRights] [int] NULL,
	[Background] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BackgroundStyle] [tinyint] NULL
) ON [PRIMARY]

GO
