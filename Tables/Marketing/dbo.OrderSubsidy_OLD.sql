/****** Object:  Table [dbo].[OrderSubsidy_OLD]    Script Date: 5/15/2018 12:02:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderSubsidy_OLD](
	[OrdSStoreId] [int] NOT NULL,
	[OrdHid] [int] NOT NULL,
	[OrdDId] [int] NOT NULL,
	[OrdSHId] [int] NOT NULL,
	[OrdSDType] [tinyint] NOT NULL,
	[OrdSHType] [int] NOT NULL,
	[OrdDPrdId] [int] NOT NULL,
	[OrdSAmount] [float] NULL,
 CONSTRAINT [PK_OrderSubsidy] PRIMARY KEY CLUSTERED 
(
	[OrdHid] ASC,
	[OrdDId] ASC,
	[OrdSHId] ASC,
	[OrdSDType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
