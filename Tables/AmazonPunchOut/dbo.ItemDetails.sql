/****** Object:  Table [dbo].[ItemDetails]    Script Date: 5/15/2018 11:58:43 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ItemDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassificationDomain] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClassificationValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DescriptionLanguage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DescriptionValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerPartId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitOfMeasure] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Currency] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_dbo.ItemDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
