/****** Object:  Table [dbo].[StoreMediaAmounts]    Script Date: 5/15/2018 12:02:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[StoreMediaAmounts](
	[StoreMediaAmountID] [int] IDENTITY(1,1) NOT NULL,
	[WebNumber] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year] [smallint] NULL,
	[SubsidyAmount] [real] NULL,
 CONSTRAINT [PK_StoreMediaAmounts] PRIMARY KEY CLUSTERED 
(
	[StoreMediaAmountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
