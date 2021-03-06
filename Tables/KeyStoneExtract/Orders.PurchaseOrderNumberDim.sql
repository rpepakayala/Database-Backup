/****** Object:  Table [Orders].[PurchaseOrderNumberDim]    Script Date: 5/15/2018 12:02:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[PurchaseOrderNumberDim](
	[PurchaseOrderNumberKey] [int] NOT NULL,
	[PurchaseOrderNumberName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderNumberKey] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderNumberKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[PurchaseOrderNumberDim] ADD  CONSTRAINT [DF_PurchaseOrderNumber_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
