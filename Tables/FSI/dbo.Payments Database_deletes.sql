/****** Object:  Table [dbo].[Payments Database_deletes]    Script Date: 5/15/2018 12:00:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Payments Database_deletes](
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
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NULL,
	[sys_du] [datetime] NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] NOT NULL,
	[IsCCEncrypted] [bit] NULL,
	[CCNumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VCode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NameOnCard] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TroutD] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessID] [int] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
