/****** Object:  Table [dbo].[HT_Cache]    Script Date: 5/15/2018 12:05:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HT_Cache](
	[TimeStamp] [smalldatetime] NOT NULL,
	[SiteId] [uniqueidentifier] NOT NULL,
	[DirName] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LeafName] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[TransName] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[JobType] [tinyint] NOT NULL,
	[STSDocVersion] [datetime] NOT NULL,
	[File] [image] NULL,
	[FileSize] [int] NOT NULL,
	[MainFile] [bit] NOT NULL,
 CONSTRAINT [HT_Cache_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[DirName] ASC,
	[LeafName] ASC,
	[TransName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[HT_Cache] ADD  DEFAULT ((0)) FOR [MainFile]
GO
