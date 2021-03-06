/****** Object:  Table [dbo].[CategoryTemplate]    Script Date: 5/15/2018 12:08:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CategoryTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ViewPath] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
