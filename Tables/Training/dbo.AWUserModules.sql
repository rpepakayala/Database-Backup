/****** Object:  Table [dbo].[AWUserModules]    Script Date: 5/15/2018 12:07:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AWUserModules](
	[UserID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[TotalTime] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastPage] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Menuvar] [varchar](90) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Score1] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Score2] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Comments] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
