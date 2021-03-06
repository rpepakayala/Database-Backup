/****** Object:  Table [dbo].[ItemOuts]    Script Date: 5/15/2018 11:58:43 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ItemOuts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SupplierPartAuxiliaryID] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SupplierPartID] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineNumber] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Currency] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountingName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineItemCost] [decimal](18, 2) NOT NULL,
	[ItemDetails_Id] [int] NULL,
	[OrderRequest_Id] [int] NULL,
 CONSTRAINT [PK_dbo.ItemOuts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ItemDetails_Id]    Script Date: 5/15/2018 11:58:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_ItemDetails_Id] ON [dbo].[ItemOuts]
(
	[ItemDetails_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_OrderRequest_Id]    Script Date: 5/15/2018 11:58:43 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderRequest_Id] ON [dbo].[ItemOuts]
(
	[OrderRequest_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ItemOuts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ItemOuts_dbo.ItemDetails_ItemDetails_Id] FOREIGN KEY([ItemDetails_Id])
REFERENCES [dbo].[ItemDetails] ([Id])
ALTER TABLE [dbo].[ItemOuts] CHECK CONSTRAINT [FK_dbo.ItemOuts_dbo.ItemDetails_ItemDetails_Id]
ALTER TABLE [dbo].[ItemOuts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ItemOuts_dbo.OrderRequests_OrderRequest_Id] FOREIGN KEY([OrderRequest_Id])
REFERENCES [dbo].[OrderRequests] ([Id])
ALTER TABLE [dbo].[ItemOuts] CHECK CONSTRAINT [FK_dbo.ItemOuts_dbo.OrderRequests_OrderRequest_Id]
GO
