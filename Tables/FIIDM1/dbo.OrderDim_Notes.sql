/****** Object:  Table [dbo].[OrderDim_Notes]    Script Date: 5/15/2018 11:59:53 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderDim_Notes](
	[OrderKey] [int] NOT NULL,
	[T_zw_franchise_id] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[T_OrderID] [int] NULL,
	[ShippingAddress] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InstallNotes] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DW_InsertDate] [datetime] NULL,
 CONSTRAINT [PK_OrderDim_Notes] PRIMARY KEY CLUSTERED 
(
	[OrderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[OrderDim_Notes] ADD  CONSTRAINT [DF_OrderDim_Notes_DW_InsertDate]  DEFAULT (getdate()) FOR [DW_InsertDate]
GO
