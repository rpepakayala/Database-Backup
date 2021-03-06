/****** Object:  Table [dbo].[SEC_NAVIGATION]    Script Date: 5/15/2018 11:59:13 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SEC_NAVIGATION](
	[NavID] [numeric](18, 0) NOT NULL,
	[PageID] [numeric](18, 0) NULL,
	[Text] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentNavID] [numeric](18, 0) NULL,
	[ListOrder] [numeric](18, 0) NULL,
	[Icon] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
