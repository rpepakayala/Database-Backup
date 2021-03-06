/****** Object:  Table [dbo].[ClassPictures]    Script Date: 5/15/2018 12:07:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ClassPictures](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Class] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NameLabel] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClassMonth] [int] NULL,
	[ClassYear] [int] NULL,
	[InfoLabel] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FileName] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Approved] [bit] NULL,
	[Posted] [datetime] NULL,
 CONSTRAINT [PK_ClassPhotos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
