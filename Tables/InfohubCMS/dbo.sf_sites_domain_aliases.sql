/****** Object:  Table [dbo].[sf_sites_domain_aliases]    Script Date: 5/15/2018 12:02:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_sites_domain_aliases](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_sites_domain_aliases] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_stes_domain_aliases_val]    Script Date: 5/15/2018 12:02:03 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_stes_domain_aliases_val] ON [dbo].[sf_sites_domain_aliases]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_sites_domain_aliases]  WITH CHECK ADD  CONSTRAINT [ref_sf_sts_dmn_lss_sf_D75D2B5C] FOREIGN KEY([id])
REFERENCES [dbo].[sf_sites] ([id])
ALTER TABLE [dbo].[sf_sites_domain_aliases] CHECK CONSTRAINT [ref_sf_sts_dmn_lss_sf_D75D2B5C]
GO
