/****** Object:  Table [dbo].[ShippingByWeight]    Script Date: 5/15/2018 12:04:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ShippingByWeight](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[StateProvinceId] [int] NOT NULL,
	[Zip] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShippingMethodId] [int] NOT NULL,
	[From] [decimal](18, 2) NOT NULL,
	[To] [decimal](18, 2) NOT NULL,
	[AdditionalFixedCost] [decimal](18, 2) NOT NULL,
	[PercentageRateOfSubtotal] [decimal](18, 2) NOT NULL,
	[RatePerWeightUnit] [decimal](18, 2) NOT NULL,
	[LowerWeightLimit] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
