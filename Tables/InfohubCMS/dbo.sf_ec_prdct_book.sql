/****** Object:  Table [dbo].[sf_ec_prdct_book]    Script Date: 5/15/2018 12:01:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_prdct_book](
	[id] [uniqueidentifier] NOT NULL,
	[release_date] [datetime] NULL,
	[Publisher] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[number_of_pages] [int] NULL,
	[i_s_b_n] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[author] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_ec_prdct_book] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sf_ec_prdct_book]  WITH CHECK ADD  CONSTRAINT [ref_sf_c_prdct_bk_sf__4ADEB946] FOREIGN KEY([id])
REFERENCES [dbo].[sf_ec_product] ([id])
ON DELETE CASCADE
ALTER TABLE [dbo].[sf_ec_prdct_book] CHECK CONSTRAINT [ref_sf_c_prdct_bk_sf__4ADEB946]
GO
