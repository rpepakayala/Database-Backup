/****** Object:  Table [dbo].[Payments Database]    Script Date: 5/15/2018 12:00:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Payments Database](
	[PaymentID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[OrderID] [int] NULL,
	[PaymentAmount] [money] NULL,
	[EnteredByID] [int] NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentMethod] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentMethodType] [int] NULL,
	[TrackingNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreditCardExpDate] [datetime] NULL,
	[Voided] [bit] NULL,
	[VoidDate] [datetime] NULL,
	[VoidAmount] [money] NULL,
	[Reason] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentOnOrder] [bit] NULL,
	[Refund] [bit] NULL,
	[TakenForStoreID] [int] NULL,
	[TakenForOrderID] [int] NULL,
	[TakenForCustomerInfo] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[IsCCEncrypted] [bit] NULL,
	[CCNumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VCode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NameOnCard] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TroutD] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessID] [int] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Payments Database] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_FranchiseID]    Script Date: 5/15/2018 12:00:54 PM ******/
CREATE NONCLUSTERED INDEX [IX_FranchiseID] ON [dbo].[Payments Database]
(
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_OrderID]    Script Date: 5/15/2018 12:00:54 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderID] ON [dbo].[Payments Database]
(
	[OrderID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
