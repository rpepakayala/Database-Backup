/****** Object:  Table [Orders].[AdjustmentFact]    Script Date: 5/15/2018 11:59:34 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[AdjustmentFact](
	[AdjustmentKey] [int] IDENTITY(1,1) NOT NULL,
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
	[OrderKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[EstimateKey] [int] NULL,
	[AdjustedByKey] [int] NULL,
	[CenterKey] [int] NULL,
 CONSTRAINT [PK_AdjustmentFact] PRIMARY KEY CLUSTERED 
(
	[AdjustmentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Hint_Adjustmentfact_AdjustmentDate]    Script Date: 5/15/2018 11:59:34 AM ******/
CREATE NONCLUSTERED INDEX [Hint_Adjustmentfact_AdjustmentDate] ON [Orders].[AdjustmentFact]
(
	[AdjustmentDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
GO
