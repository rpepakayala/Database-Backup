/****** Object:  Table [dbo].[TaxQuote]    Script Date: 5/15/2018 12:03:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TaxQuote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[TransactionId] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerId] [int] NOT NULL,
	[CartCount] [int] NOT NULL,
	[Amount] [decimal](18, 4) NOT NULL,
	[ShippingAmount] [decimal](18, 4) NOT NULL,
	[HandlingAmount] [decimal](18, 4) NOT NULL,
	[TaxRate] [decimal](19, 16) NOT NULL,
	[TaxAmount] [decimal](18, 4) NOT NULL,
	[AddressId] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
 CONSTRAINT [PK__TaxQuote__3214EC074336F4B9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_TaxQuote_StoreId]    Script Date: 5/15/2018 12:03:37 PM ******/
CREATE NONCLUSTERED INDEX [IX_TaxQuote_StoreId] ON [dbo].[TaxQuote]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[TaxQuote]  WITH CHECK ADD  CONSTRAINT [TaxQuote_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ALTER TABLE [dbo].[TaxQuote] CHECK CONSTRAINT [TaxQuote_Store]
GO
