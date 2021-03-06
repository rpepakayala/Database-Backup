/****** Object:  Table [dbo].[AdjustmentFactUpdate]    Script Date: 5/15/2018 12:06:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AdjustmentFactUpdate](
	[AdjustmentKey] [int] NOT NULL,
	[AdjustmentID] [int] NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderID] [int] NULL,
	[CustomerID] [int] NULL,
	[EstimateID] [int] NULL,
	[AdjustmentDate] [datetime] NULL,
	[AdjustedBy] [int] NULL,
	[Amount] [money] NULL,
	[ReasonKey] [int] NULL,
	[ReasonCodeKey] [int] NULL,
	[OrderStatus] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
	[CenterKey] [int] NULL
) ON [PRIMARY]

GO
