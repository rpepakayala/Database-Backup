/****** Object:  Table [dbo].[MaterialLot]    Script Date: 5/15/2018 12:02:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MaterialLot](
	[MatId] [int] NOT NULL,
	[MatLotId] [int] NOT NULL,
	[MatLotDesc] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatLotVQOH] [int] NULL,
	[MatLotVQtyAllocated] [int] NULL,
	[MatLotSMatQtyAllocated] [int] NULL,
	[MatLotSMailQtyAllocated] [int] NULL,
	[MatLotQtyOnOrder] [int] NULL,
	[MatLotOriginalOrderAmount] [int] NULL,
	[MatLotUnitCost] [real] NULL,
	[MatLotUnitPrice] [real] NULL,
	[MatLotUnitSalePrice] [real] NULL,
	[MatLotDateAdded] [smalldatetime] NULL,
	[MatLotPDFFileName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatLotOwner] [tinyint] NULL,
	[MatLotStatus] [tinyint] NULL,
	[MatLotImageFile] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatLotImage] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatLotProofImageFile] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatLotProofImage] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_MaterialLot] PRIMARY KEY CLUSTERED 
(
	[MatId] ASC,
	[MatLotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
