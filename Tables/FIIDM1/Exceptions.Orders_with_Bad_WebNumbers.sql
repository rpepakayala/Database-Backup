/****** Object:  Table [Exceptions].[Orders_with_Bad_WebNumbers]    Script Date: 5/15/2018 11:59:56 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Exceptions].[Orders_with_Bad_WebNumbers](
	[OrderKey] [int] NULL,
	[DateKey] [int] NULL,
	[SalesAmt] [money] NULL,
	[T_WebNumber] [smallint] NULL,
	[T_OrderID] [int] NULL,
	[T_CustomerID] [int] NULL,
	[T_ContactID] [int] NULL,
	[T_OrderDate] [datetime] NULL,
	[T_StoreID] [int] NULL
) ON [PRIMARY]

GO
