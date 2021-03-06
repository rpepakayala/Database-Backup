/****** Object:  Table [dbo].[CheckoutAttributeValue]    Script Date: 5/15/2018 12:07:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CheckoutAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CheckoutAttributeId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ColorSquaresRgb] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[CheckoutAttributeValue]  WITH CHECK ADD  CONSTRAINT [CheckoutAttributeValue_CheckoutAttribute] FOREIGN KEY([CheckoutAttributeId])
REFERENCES [dbo].[CheckoutAttribute] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[CheckoutAttributeValue] CHECK CONSTRAINT [CheckoutAttributeValue_CheckoutAttribute]
GO
