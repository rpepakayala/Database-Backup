/****** Object:  Table [dbo].[QueuedEmail]    Script Date: 5/15/2018 12:07:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[QueuedEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PriorityId] [int] NOT NULL,
	[From] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FromName] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[To] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ToName] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CC] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Bcc] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Subject] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Body] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AttachmentFilePath] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AttachmentFileName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[SentTries] [int] NOT NULL,
	[SentOnUtc] [datetime] NULL,
	[EmailAccountId] [int] NOT NULL,
	[ReplyTo] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReplyToName] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AttachedDownloadId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_QueuedEmail_CreatedOnUtc]    Script Date: 5/15/2018 12:07:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_QueuedEmail_CreatedOnUtc] ON [dbo].[QueuedEmail]
(
	[CreatedOnUtc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[QueuedEmail]  WITH CHECK ADD  CONSTRAINT [QueuedEmail_EmailAccount] FOREIGN KEY([EmailAccountId])
REFERENCES [dbo].[EmailAccount] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[QueuedEmail] CHECK CONSTRAINT [QueuedEmail_EmailAccount]
GO
