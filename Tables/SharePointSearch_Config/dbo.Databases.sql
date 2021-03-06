/****** Object:  Table [dbo].[Databases]    Script Date: 5/15/2018 12:06:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Databases](
	[DatabaseId] [uniqueidentifier] NOT NULL,
	[VirtualServerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[UserId] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Password] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[SiteCount] [int] NOT NULL,
	[SiteCountWarning] [int] NOT NULL,
	[SiteCountLimit] [int] NOT NULL,
	[DatabaseServiceId] [uniqueidentifier] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[LastModifiedUser] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LastModifiedServer] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Status] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_Databases] PRIMARY KEY NONCLUSTERED 
(
	[DatabaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Databases_DatabaseServiceId_Name] UNIQUE NONCLUSTERED 
(
	[DatabaseServiceId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Databases] ADD  DEFAULT ((0)) FOR [SiteCount]
ALTER TABLE [dbo].[Databases] ADD  DEFAULT ((0)) FOR [Status]
ALTER TABLE [dbo].[Databases]  WITH NOCHECK ADD  CONSTRAINT [FK_Databases_DatabaseServiceId] FOREIGN KEY([DatabaseServiceId])
REFERENCES [dbo].[Services] ([ServiceId])
ALTER TABLE [dbo].[Databases] CHECK CONSTRAINT [FK_Databases_DatabaseServiceId]
ALTER TABLE [dbo].[Databases]  WITH NOCHECK ADD  CONSTRAINT [FK_Databases_VirtualServerId] FOREIGN KEY([VirtualServerId])
REFERENCES [dbo].[VirtualServers] ([VirtualServerId])
ON DELETE CASCADE
ALTER TABLE [dbo].[Databases] CHECK CONSTRAINT [FK_Databases_VirtualServerId]
ALTER TABLE [dbo].[Databases]  WITH CHECK ADD CHECK  (([SiteCountWarning]<=[SiteCountLimit]))
GO
