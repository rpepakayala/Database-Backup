/****** Object:  Table [Estimate].[ShippingAddressDim]    Script Date: 5/15/2018 11:59:32 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[ShippingAddressDim](
	[ShippingAddressKey] [int] IDENTITY(1,1) NOT NULL,
	[ShippingAddressName] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ShippingAddressKey] PRIMARY KEY CLUSTERED 
(
	[ShippingAddressKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [Estimate].[ShippingAddressDim] ADD  CONSTRAINT [DF_ShippingAddress_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
