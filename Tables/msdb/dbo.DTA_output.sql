/****** Object:  Table [dbo].[DTA_output]    Script Date: 5/15/2018 12:02:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_output](
	[SessionID] [int] NOT NULL,
	[TuningResults] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StopTime] [datetime] NOT NULL,
	[FinishStatus] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DTA_output] ADD  DEFAULT (getdate()) FOR [StopTime]
ALTER TABLE [dbo].[DTA_output] ADD  DEFAULT ((0)) FOR [FinishStatus]
ALTER TABLE [dbo].[DTA_output]  WITH CHECK ADD FOREIGN KEY([SessionID])
REFERENCES [dbo].[DTA_input] ([SessionID])
ON DELETE CASCADE
GO
