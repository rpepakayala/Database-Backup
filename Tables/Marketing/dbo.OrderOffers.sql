/****** Object:  Table [dbo].[OrderOffers]    Script Date: 5/15/2018 12:02:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderOffers](
	[OrdOStoreId] [int] NOT NULL,
	[OrdHid] [int] NOT NULL,
	[OrdPSId] [int] NOT NULL,
	[OrdOffId] [int] NOT NULL,
	[PrdDPrdId] [int] NOT NULL,
	[OrdOffType] [tinyint] NULL,
	[OrdOffImage] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_OrderOffers] PRIMARY KEY CLUSTERED 
(
	[OrdHid] ASC,
	[OrdPSId] ASC,
	[OrdOffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
