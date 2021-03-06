/****** Object:  Table [dbo].[SSISPackageVariableLog]    Script Date: 5/15/2018 12:04:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SSISPackageVariableLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionID] [uniqueidentifier] NOT NULL,
	[VariableName] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SourceID] [uniqueidentifier] NULL,
	[VariableValue] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LogDateTime] [datetime] NULL,
 CONSTRAINT [PK__SSISPack__5E5499A87F60ED59] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_SSISPackageVariableLog_ExecutionID]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISPackageVariableLog_ExecutionID] ON [dbo].[SSISPackageVariableLog]
(
	[ExecutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
