/****** Object:  Table [dbo].[OASyncImportSummary]    Script Date: 5/15/2018 12:01:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OASyncImportSummary](
	[Id] [int] NOT NULL,
	[ImportStatus] [int] NOT NULL,
	[ImportStart] [datetimeoffset](7) NOT NULL,
	[ImportEnd] [datetimeoffset](7) NULL,
	[ConfigurationName] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastErrorSynchronizationLog] [int] NULL,
 CONSTRAINT [pk_OASyncImportSummary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[OASyncImportSummary]  WITH CHECK ADD  CONSTRAINT [ref_OASyncImprtSmmry__80271C87] FOREIGN KEY([ConfigurationName])
REFERENCES [dbo].[OAImportConfigurations] ([Name])
ALTER TABLE [dbo].[OASyncImportSummary] CHECK CONSTRAINT [ref_OASyncImprtSmmry__80271C87]
GO
