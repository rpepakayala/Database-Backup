/****** Object:  Table [dbo].[StoreSubsidy]    Script Date: 5/15/2018 12:02:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[StoreSubsidy](
	[StoreSId] [int] NOT NULL,
	[StoreSubYear] [smallint] NOT NULL,
	[StoreSubHId] [int] NOT NULL,
	[StoreSubType] [tinyint] NOT NULL,
	[StoreSubStartingAmount] [float] NULL,
	[StoreSubRemainingAmount] [float] NULL,
 CONSTRAINT [PK_StoreSubsidy] PRIMARY KEY CLUSTERED 
(
	[StoreSId] ASC,
	[StoreSubYear] ASC,
	[StoreSubHId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
