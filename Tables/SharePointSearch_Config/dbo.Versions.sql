/****** Object:  Table [dbo].[Versions]    Script Date: 5/15/2018 12:06:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Versions](
	[VersionId] [uniqueidentifier] NOT NULL,
	[Version] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TimeStamp] [datetime] NULL,
	[FinalizeTimeStamp] [datetime] NULL,
	[Mode] [int] NULL,
	[ModeStack] [int] NULL,
	[Updates] [int] NOT NULL,
	[Notes] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [Versions_PK] PRIMARY KEY CLUSTERED 
(
	[VersionId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Versions] ADD  DEFAULT ((0)) FOR [Updates]
GO
