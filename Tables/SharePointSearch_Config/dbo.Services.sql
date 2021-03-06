/****** Object:  Table [dbo].[Services]    Script Date: 5/15/2018 12:06:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Services](
	[ServiceId] [uniqueidentifier] NOT NULL,
	[ClassId] [uniqueidentifier] NOT NULL,
	[ServerId] [uniqueidentifier] NOT NULL,
	[Instance] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[LastModified] [datetime] NOT NULL,
	[LastModifiedUser] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LastModifiedServer] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Status] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY NONCLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Services] ADD  DEFAULT ((0)) FOR [Status]
ALTER TABLE [dbo].[Services]  WITH NOCHECK ADD  CONSTRAINT [FK_Services_ServerId] FOREIGN KEY([ServerId])
REFERENCES [dbo].[Servers] ([ServerId])
ALTER TABLE [dbo].[Services] CHECK CONSTRAINT [FK_Services_ServerId]
GO
