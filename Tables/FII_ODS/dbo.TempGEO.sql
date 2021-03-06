/****** Object:  Table [dbo].[TempGEO]    Script Date: 5/15/2018 11:59:27 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TempGEO](
	[StoreNumber] [int] NOT NULL,
	[Lat] [float] NOT NULL,
	[Long] [float] NOT NULL,
	[GeoCode] [geography] NULL,
 CONSTRAINT [PK_Store_GEO] PRIMARY KEY CLUSTERED 
(
	[StoreNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
