/****** Object:  Table [dbo].[DTA_reports_query]    Script Date: 5/15/2018 12:02:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_query](
	[QueryID] [int] NOT NULL,
	[SessionID] [int] NOT NULL,
	[StatementType] [smallint] NOT NULL,
	[StatementString] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CurrentCost] [float] NOT NULL,
	[RecommendedCost] [float] NOT NULL,
	[Weight] [float] NOT NULL,
	[EventString] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EventWeight] [float] NOT NULL,
 CONSTRAINT [DTA_reports_query_pk] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC,
	[QueryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DTA_reports_query]  WITH NOCHECK ADD FOREIGN KEY([SessionID])
REFERENCES [dbo].[DTA_input] ([SessionID])
ON DELETE CASCADE
GO
