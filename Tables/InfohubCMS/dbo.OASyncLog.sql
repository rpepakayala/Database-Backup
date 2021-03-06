/****** Object:  Table [dbo].[OASyncLog]    Script Date: 5/15/2018 12:01:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OASyncLog](
	[Id] [int] NOT NULL,
	[Executed] [datetimeoffset](7) NOT NULL,
	[Action] [int] NOT NULL,
	[SourceId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DestinationId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BaseId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CorrelationId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BaseName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListSummary] [int] NULL,
 CONSTRAINT [pk_OASyncLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
