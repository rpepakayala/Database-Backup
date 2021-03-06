/****** Object:  Table [dbo].[sf_cntent_items_sf_permissions]    Script Date: 5/15/2018 12:01:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_cntent_items_sf_permissions](
	[content_id] [uniqueidentifier] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_cntnt_tms_sf_pr_01DD1D9B] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_cntnt_tms_sf_prmssns_id]    Script Date: 5/15/2018 12:01:26 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_cntnt_tms_sf_prmssns_id] ON [dbo].[sf_cntent_items_sf_permissions]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_cntent_items_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_cntnt_tms_sf_p_4D6FB4E1] FOREIGN KEY([id])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_cntent_items_sf_permissions] CHECK CONSTRAINT [ref_sf_cntnt_tms_sf_p_4D6FB4E1]
ALTER TABLE [dbo].[sf_cntent_items_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_cntnt_tms_sf_p_F10391D6] FOREIGN KEY([content_id])
REFERENCES [dbo].[sf_content_items] ([content_id])
ALTER TABLE [dbo].[sf_cntent_items_sf_permissions] CHECK CONSTRAINT [ref_sf_cntnt_tms_sf_p_F10391D6]
GO
