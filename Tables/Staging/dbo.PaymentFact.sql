/****** Object:  Table [dbo].[PaymentFact]    Script Date: 5/15/2018 12:06:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PaymentFact](
	[PaymentID] [int] NOT NULL,
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
	[TakenForCustomerInfo] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UpdateCheckSum] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
