/****** Object:  Table [dbo].[sf_mb_dynmc_mdl_sf_permissions]    Script Date: 5/15/2018 12:01:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_mb_dynmc_mdl_sf_permissions](
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_mb_dynmc_mdl_sf_9CDD90B2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_mb_dynmc_mdl_sf_prmssns]    Script Date: 5/15/2018 12:01:46 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_mb_dynmc_mdl_sf_prmssns] ON [dbo].[sf_mb_dynmc_mdl_sf_permissions]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_mb_dynmc_mdl_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_mb_dynmc_mdl_s_7521815B] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_mb_dynmc_mdl_sf_permissions] CHECK CONSTRAINT [ref_sf_mb_dynmc_mdl_s_7521815B]
ALTER TABLE [dbo].[sf_mb_dynmc_mdl_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_mb_dynmc_mdl_s_B717FC1D] FOREIGN KEY([id])
REFERENCES [dbo].[sf_mb_dynamic_module] ([id])
ALTER TABLE [dbo].[sf_mb_dynmc_mdl_sf_permissions] CHECK CONSTRAINT [ref_sf_mb_dynmc_mdl_s_B717FC1D]
GO
