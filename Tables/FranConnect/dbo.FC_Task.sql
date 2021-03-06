/****** Object:  Table [dbo].[FC_Task]    Script Date: 5/15/2018 12:00:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Task](
	[referenceId] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[assignBy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[assignTo] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[priority] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[duration] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[status] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[taskType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reminderTime] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[comments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
