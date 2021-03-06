/****** Object:  Table [dbo].[sf_ec_prdct_generalproduct]    Script Date: 5/15/2018 12:01:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_prdct_generalproduct](
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_ec_prdct_generalproduct] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sf_ec_prdct_generalproduct]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_gnrlpr_1BF9D988] FOREIGN KEY([id])
REFERENCES [dbo].[sf_ec_product] ([id])
ON DELETE CASCADE
ALTER TABLE [dbo].[sf_ec_prdct_generalproduct] CHECK CONSTRAINT [ref_sf_c_prdct_gnrlpr_1BF9D988]
GO
