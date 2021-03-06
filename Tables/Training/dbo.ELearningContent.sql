/****** Object:  Table [dbo].[ELearningContent]    Script Date: 5/15/2018 12:07:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ELearningContent](
	[ELearningContentID] [int] IDENTITY(1,1) NOT NULL,
	[ELearningTypeID] [int] NOT NULL,
	[Title] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WorkingFolder] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartFile] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Thumbnail] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Duration] [int] NULL,
	[DownloadLink] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ELearningContent] PRIMARY KEY CLUSTERED 
(
	[ELearningContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ELearningContent]  WITH CHECK ADD  CONSTRAINT [FK_ELearningContent_ELearningType] FOREIGN KEY([ELearningTypeID])
REFERENCES [dbo].[ELearningType] ([ELearningTypeID])
ALTER TABLE [dbo].[ELearningContent] CHECK CONSTRAINT [FK_ELearningContent_ELearningType]
GO
