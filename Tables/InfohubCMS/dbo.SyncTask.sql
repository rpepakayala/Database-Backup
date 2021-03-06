/****** Object:  Table [dbo].[SyncTask]    Script Date: 5/15/2018 12:02:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SyncTask](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Priority] [int] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[FirstExecution] [datetimeoffset](7) NOT NULL,
	[LastExecution] [datetimeoffset](7) NULL,
	[FinalExecution] [datetimeoffset](7) NULL,
	[Name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NextExecution] [datetimeoffset](7) NULL,
	[ExecutionCount] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[RecurrenceRule] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FatalityThreshold] [int] NOT NULL,
	[ConfigurationId] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_SyncTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
