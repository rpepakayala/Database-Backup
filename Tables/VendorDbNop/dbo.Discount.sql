/****** Object:  Table [dbo].[Discount]    Script Date: 5/15/2018 12:07:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Discount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DiscountTypeId] [int] NOT NULL,
	[UsePercentage] [bit] NOT NULL,
	[DiscountPercentage] [decimal](18, 4) NOT NULL,
	[DiscountAmount] [decimal](18, 4) NOT NULL,
	[StartDateUtc] [datetime] NULL,
	[EndDateUtc] [datetime] NULL,
	[RequiresCouponCode] [bit] NOT NULL,
	[CouponCode] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiscountLimitationId] [int] NOT NULL,
	[LimitationTimes] [int] NOT NULL,
	[MaximumDiscountedQuantity] [int] NULL,
	[MaximumDiscountAmount] [decimal](18, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
