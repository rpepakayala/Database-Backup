/****** Object:  Table [dbo].[Picture]    Script Date: 5/15/2018 12:07:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Picture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PictureBinary] [varbinary](max) NULL,
	[MimeType] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SeoFilename] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsNew] [bit] NOT NULL,
	[TitleAttribute] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AltAttribute] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
