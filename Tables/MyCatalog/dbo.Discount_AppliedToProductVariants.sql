/****** Object:  Table [dbo].[Discount_AppliedToProductVariants]    Script Date: 5/15/2018 12:03:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Discount_AppliedToProductVariants](
	[Discount_Id] [int] NOT NULL,
	[ProductVariant_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Discount_Id] ASC,
	[ProductVariant_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Discount_AppliedToProductVariants]  WITH CHECK ADD  CONSTRAINT [Discount_AppliedToProductVariants_Source] FOREIGN KEY([Discount_Id])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Discount_AppliedToProductVariants] CHECK CONSTRAINT [Discount_AppliedToProductVariants_Source]
ALTER TABLE [dbo].[Discount_AppliedToProductVariants]  WITH CHECK ADD  CONSTRAINT [Discount_AppliedToProductVariants_Target] FOREIGN KEY([ProductVariant_Id])
REFERENCES [dbo].[ProductVariant] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Discount_AppliedToProductVariants] CHECK CONSTRAINT [Discount_AppliedToProductVariants_Target]
GO
