/****** Object:  Table [dbo].[InvoiceLineItem]    Script Date: 5/15/2018 11:58:41 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvoiceLineItem](
	[OrderId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitCost] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalCost] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Tax] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_dbo.InvoiceLineItem] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[InvoiceLineItem]  WITH CHECK ADD  CONSTRAINT [FK_dbo.InvoiceLineItem_dbo.InvoiceModel_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[InvoiceModel] ([OrderId])
ON DELETE CASCADE
ALTER TABLE [dbo].[InvoiceLineItem] CHECK CONSTRAINT [FK_dbo.InvoiceLineItem_dbo.InvoiceModel_OrderId]
GO
