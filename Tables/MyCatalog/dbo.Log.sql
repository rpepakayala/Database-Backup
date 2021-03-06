/****** Object:  Table [dbo].[Log]    Script Date: 5/15/2018 12:03:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LogLevelId] [int] NOT NULL,
	[ShortMessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullMessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IpAddress] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerId] [int] NULL,
	[PageUrl] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReferrerUrl] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Log_CreatedOnUtc]    Script Date: 5/15/2018 12:03:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_Log_CreatedOnUtc] ON [dbo].[Log]
(
	[CreatedOnUtc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [Log_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [Log_Customer]
GO
