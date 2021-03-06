/****** Object:  Table [dbo].[DocumentLinks]    Script Date: 5/15/2018 12:00:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DocumentLinks](
	[FRANCHISEE ID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Document Title] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Document file Name] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Exists On] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FTP File Path] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TAB NAME] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Document Id] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Uploaded] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
