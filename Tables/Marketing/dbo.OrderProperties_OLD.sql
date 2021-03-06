/****** Object:  Table [dbo].[OrderProperties_OLD]    Script Date: 5/15/2018 12:02:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderProperties_OLD](
	[OrdHId] [int] NOT NULL,
	[OrdPId] [int] NOT NULL,
	[OrdPEstShipDate] [smalldatetime] NULL,
	[OrdPActShipDate] [smalldatetime] NULL,
 CONSTRAINT [PK_OrderProperties] PRIMARY KEY CLUSTERED 
(
	[OrdPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
