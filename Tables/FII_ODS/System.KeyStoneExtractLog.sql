/****** Object:  Table [System].[KeyStoneExtractLog]    Script Date: 5/15/2018 11:59:47 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[KeyStoneExtractLog](
	[LogKey] [int] IDENTITY(1,1000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[StoreNumber] [int] NOT NULL,
	[DateCompleted] [datetime] NOT NULL,
	[ExcelLink] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_KeyStoneExtractLog] PRIMARY KEY CLUSTERED 
(
	[LogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [System].[KeyStoneExtractLog] ADD  CONSTRAINT [DF_KeyStoneExtractLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
