/****** Object:  Table [dbo].[Download]    Script Date: 5/15/2018 12:03:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Download](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UseDownloadUrl] [bit] NOT NULL,
	[DownloadUrl] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DownloadBinary] [varbinary](max) NULL,
	[ContentType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Filename] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Extension] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsNew] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
