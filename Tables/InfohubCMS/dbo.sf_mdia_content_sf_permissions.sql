/****** Object:  Table [dbo].[sf_mdia_content_sf_permissions]    Script Date: 5/15/2018 12:01:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_mdia_content_sf_permissions](
	[content_id] [uniqueidentifier] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_md_cntnt_sf_prm_BB882621] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_md_cntnt_sf_prmssons_id]    Script Date: 5/15/2018 12:01:47 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_md_cntnt_sf_prmssons_id] ON [dbo].[sf_mdia_content_sf_permissions]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_mdia_content_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_md_cntnt_sf_pr_39D160B5] FOREIGN KEY([content_id])
REFERENCES [dbo].[sf_media_content] ([content_id])
ALTER TABLE [dbo].[sf_mdia_content_sf_permissions] CHECK CONSTRAINT [ref_sf_md_cntnt_sf_pr_39D160B5]
ALTER TABLE [dbo].[sf_mdia_content_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_md_cntnt_sf_pr_C6D2D223] FOREIGN KEY([id])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_mdia_content_sf_permissions] CHECK CONSTRAINT [ref_sf_md_cntnt_sf_pr_C6D2D223]
GO
