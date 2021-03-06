/****** Object:  Table [dbo].[RecurringPaymentHistory]    Script Date: 5/15/2018 12:07:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RecurringPaymentHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecurringPaymentId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[RecurringPaymentHistory]  WITH CHECK ADD  CONSTRAINT [RecurringPaymentHistory_RecurringPayment] FOREIGN KEY([RecurringPaymentId])
REFERENCES [dbo].[RecurringPayment] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[RecurringPaymentHistory] CHECK CONSTRAINT [RecurringPaymentHistory_RecurringPayment]
GO
