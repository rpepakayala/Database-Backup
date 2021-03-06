/****** Object:  Table [dbo].[MaterialQtyIncrements]    Script Date: 5/15/2018 12:02:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MaterialQtyIncrements](
	[MatId] [int] NOT NULL,
	[MatIncId] [int] NOT NULL,
	[MatIncQty] [int] NULL,
 CONSTRAINT [PK_MaterialQtyIncrements] PRIMARY KEY CLUSTERED 
(
	[MatId] ASC,
	[MatIncId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
