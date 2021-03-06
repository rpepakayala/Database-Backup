/****** Object:  Table [dbo].[OAConflicts]    Script Date: 5/15/2018 12:02:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OAConflicts](
	[Id] [int] NOT NULL,
	[BaseName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Occured] [datetimeoffset](7) NOT NULL,
	[SourceId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DestinationId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BaseId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CorrelationId] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ConfigurationName] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [pk_OAConflicts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[OAConflicts]  WITH CHECK ADD  CONSTRAINT [ref_OACnflcts_OAImprt_87EE1F07] FOREIGN KEY([ConfigurationName])
REFERENCES [dbo].[OAImportConfigurations] ([Name])
ALTER TABLE [dbo].[OAConflicts] CHECK CONSTRAINT [ref_OACnflcts_OAImprt_87EE1F07]
GO
