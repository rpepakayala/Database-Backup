/****** Object:  Table [dbo].[sf_forum_groups_sf_permissions]    Script Date: 5/15/2018 12:01:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_forum_groups_sf_permissions](
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_frm_grps_sf_prm_3A6F3063] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_frm_grps_sf_prmssns_id2]    Script Date: 5/15/2018 12:01:40 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_frm_grps_sf_prmssns_id2] ON [dbo].[sf_forum_groups_sf_permissions]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_forum_groups_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_frm_grps_sf_pr_1257B58B] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_forum_groups_sf_permissions] CHECK CONSTRAINT [ref_sf_frm_grps_sf_pr_1257B58B]
ALTER TABLE [dbo].[sf_forum_groups_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_frm_grps_sf_pr_4F9A96B9] FOREIGN KEY([id])
REFERENCES [dbo].[sf_forum_groups] ([id])
ALTER TABLE [dbo].[sf_forum_groups_sf_permissions] CHECK CONSTRAINT [ref_sf_frm_grps_sf_pr_4F9A96B9]
GO
