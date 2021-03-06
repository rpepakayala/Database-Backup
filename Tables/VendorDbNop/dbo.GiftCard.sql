/****** Object:  Table [dbo].[GiftCard]    Script Date: 5/15/2018 12:07:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GiftCard](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchasedWithOrderItemId] [int] NULL,
	[GiftCardTypeId] [int] NOT NULL,
	[Amount] [decimal](18, 4) NOT NULL,
	[IsGiftCardActivated] [bit] NOT NULL,
	[GiftCardCouponCode] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RecipientName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RecipientEmail] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SenderName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SenderEmail] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsRecipientNotified] [bit] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[GiftCard]  WITH CHECK ADD  CONSTRAINT [GiftCard_PurchasedWithOrderItem] FOREIGN KEY([PurchasedWithOrderItemId])
REFERENCES [dbo].[OrderItem] ([Id])
ALTER TABLE [dbo].[GiftCard] CHECK CONSTRAINT [GiftCard_PurchasedWithOrderItem]
GO
