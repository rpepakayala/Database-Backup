/****** Object:  Table [dbo].[OrderConsolidated]    Script Date: 5/15/2018 11:59:03 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderConsolidated](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderId] [int] NULL,
	[LocationId] [int] NULL,
	[ProductionFacilityId] [int] NULL,
	[AccountId] [int] NULL,
	[ShippingContactId] [int] NULL,
	[InvoiceContactId] [int] NULL,
	[OrderContactId] [int] NULL,
	[ShippingAddressId] [int] NULL,
	[InvoiceAddressId] [int] NULL,
	[IsUpdate] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
 CONSTRAINT [PK_OrderConsolidated] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_OrderConsolidated_CompanyLocationId_OrderId]    Script Date: 5/15/2018 11:59:03 AM ******/
CREATE NONCLUSTERED INDEX [Hint_OrderConsolidated_CompanyLocationId_OrderId] ON [dbo].[OrderConsolidated]
(
	[CompanyLocationId] ASC,
	[OrderId] ASC
)
INCLUDE ( 	[AccountId],
	[ShippingContactId],
	[OrderContactId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [OrderConsolidated_CompanyLocationId_OrderContactId]    Script Date: 5/15/2018 11:59:03 AM ******/
CREATE NONCLUSTERED INDEX [OrderConsolidated_CompanyLocationId_OrderContactId] ON [dbo].[OrderConsolidated]
(
	[CompanyLocationId] ASC,
	[OrderContactId] ASC
)
INCLUDE ( 	[OrderId],
	[AccountId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[OrderConsolidated] ADD  CONSTRAINT [DF_OrderConsolidated_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
GO
