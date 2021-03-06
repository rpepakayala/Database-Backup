/****** Object:  Table [dbo].[sf_dynmc_cntent_sf_permissions]    Script Date: 5/15/2018 12:01:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_dynmc_cntent_sf_permissions](
	[base_id] [uniqueidentifier] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_dynmc_cntnt_sf__A0DCFB00] PRIMARY KEY CLUSTERED 
(
	[base_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_dynmc_cntnt_sf_prmssns_]    Script Date: 5/15/2018 12:01:30 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_dynmc_cntnt_sf_prmssns_] ON [dbo].[sf_dynmc_cntent_sf_permissions]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_dynmc_cntent_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_dynmc_cntnt_sf_35AE9BBA] FOREIGN KEY([base_id])
REFERENCES [dbo].[sf_dynamic_content] ([base_id])
ALTER TABLE [dbo].[sf_dynmc_cntent_sf_permissions] CHECK CONSTRAINT [ref_sf_dynmc_cntnt_sf_35AE9BBA]
ALTER TABLE [dbo].[sf_dynmc_cntent_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_dynmc_cntnt_sf_50D77764] FOREIGN KEY([id])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_dynmc_cntent_sf_permissions] CHECK CONSTRAINT [ref_sf_dynmc_cntnt_sf_50D77764]
GO
