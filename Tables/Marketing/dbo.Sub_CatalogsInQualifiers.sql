/****** Object:  Table [dbo].[Sub_CatalogsInQualifiers]    Script Date: 5/15/2018 12:02:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sub_CatalogsInQualifiers](
	[QualifierID] [int] NOT NULL,
	[CatalogID] [int] NOT NULL,
 CONSTRAINT [PK_Sub_CatalogsInQualifiers] PRIMARY KEY CLUSTERED 
(
	[QualifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
