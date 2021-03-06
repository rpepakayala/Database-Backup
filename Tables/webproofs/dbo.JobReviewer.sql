/****** Object:  Table [dbo].[JobReviewer]    Script Date: 5/15/2018 12:09:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[JobReviewer](
	[JobReviewerId] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_ProofGroupReviewer] PRIMARY KEY CLUSTERED 
(
	[JobReviewerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_ProofGroupReviewer]    Script Date: 5/15/2018 12:09:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProofGroupReviewer] ON [dbo].[JobReviewer]
(
	[JobId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[JobReviewer]  WITH CHECK ADD  CONSTRAINT [FK_ProofGroupReviewer_ProofGroup] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([JobId])
ALTER TABLE [dbo].[JobReviewer] CHECK CONSTRAINT [FK_ProofGroupReviewer_ProofGroup]
GO
