/****** Object:  Table [dbo].[SetupResponses]    Script Date: 5/15/2018 11:58:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SetupResponses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Lang] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PayloadId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartPageURL] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StatusCode] [int] NOT NULL,
	[StatusText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.SetupResponses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
