/****** Object:  Table [dbo].[AdjustmentFact]    Script Date: 5/15/2018 12:06:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AdjustmentFact](
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AdjustmentID] [int] NOT NULL,
	[OrderID] [int] NULL,
	[CustomerID] [int] NULL,
	[EstimateID] [int] NULL,
	[AdjustmentDate] [datetime] NULL,
	[AdjustedBy] [int] NULL,
	[Amount] [money] NULL,
	[Reason] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReasonCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderStatus] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL,
	[UpdateCheckSum] [int] NOT NULL
) ON [PRIMARY]

GO
