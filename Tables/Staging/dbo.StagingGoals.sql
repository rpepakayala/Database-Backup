/****** Object:  Table [dbo].[StagingGoals]    Script Date: 5/15/2018 12:06:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[StagingGoals](
	[LocationId] [char](19) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MonthName] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year] [smallint] NULL,
	[Amount] [money] NULL
) ON [PRIMARY]

GO
