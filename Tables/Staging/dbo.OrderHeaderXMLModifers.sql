/****** Object:  Table [dbo].[OrderHeaderXMLModifers]    Script Date: 5/15/2018 12:06:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderHeaderXMLModifers](
	[OrderDetailKey] [int] NULL,
	[OrderDetailID] [int] NULL,
	[LineItemNumber] [int] NULL,
	[OrderID] [int] NULL,
	[zw_franchise_id] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AVTotal] [money] NULL,
	[ModifierXML] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[OrderHeaderXMLModifers] ADD  CONSTRAINT [DF_OrderHeaderXMLModifers_OrderDetailKey]  DEFAULT ((-255)) FOR [OrderDetailKey]
GO
