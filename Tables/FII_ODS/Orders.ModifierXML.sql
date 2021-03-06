/****** Object:  Table [Orders].[ModifierXML]    Script Date: 5/15/2018 11:59:36 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[ModifierXML](
	[XMLModifierKey] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[OrderDetailID] [int] NULL,
	[AVID] [int] NULL,
	[OrderID] [int] NULL,
	[Answer] [int] NULL,
	[Price] [float] NULL,
	[PriceOverridden] [int] NULL,
	[CalcPrice] [int] NULL,
	[DetailKey] [int] NULL,
	[XMLLineNumber] [int] NULL,
 CONSTRAINT [PK_ModifierXML] PRIMARY KEY CLUSTERED 
(
	[XMLModifierKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
