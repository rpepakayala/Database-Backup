/****** Object:  Table [dbo].[Sites]    Script Date: 5/15/2018 12:06:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sites](
	[SiteId] [uniqueidentifier] NOT NULL,
	[DatabaseId] [uniqueidentifier] NOT NULL,
	[UrlPath] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[LastModifiedUser] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LastModifiedServer] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Status] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_Sites] PRIMARY KEY NONCLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Sites] ADD  DEFAULT ((0)) FOR [Status]
ALTER TABLE [dbo].[Sites]  WITH NOCHECK ADD  CONSTRAINT [FK_Sites_DatabaseId] FOREIGN KEY([DatabaseId])
REFERENCES [dbo].[Databases] ([DatabaseId])
ON DELETE CASCADE
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_DatabaseId]
GO
