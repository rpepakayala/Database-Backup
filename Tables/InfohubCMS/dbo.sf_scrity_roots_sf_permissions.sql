/****** Object:  Table [dbo].[sf_scrity_roots_sf_permissions]    Script Date: 5/15/2018 12:02:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_scrity_roots_sf_permissions](
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_scrty_rts_sf_pr_062DEA6B] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_scrty_rts_sf_prmssns_d2]    Script Date: 5/15/2018 12:02:02 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_scrty_rts_sf_prmssns_d2] ON [dbo].[sf_scrity_roots_sf_permissions]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_scrity_roots_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_scrty_rts_sf_p_6763D88D] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_scrity_roots_sf_permissions] CHECK CONSTRAINT [ref_sf_scrty_rts_sf_p_6763D88D]
ALTER TABLE [dbo].[sf_scrity_roots_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_scrty_rts_sf_p_85D52DD2] FOREIGN KEY([id])
REFERENCES [dbo].[sf_security_roots] ([id])
ALTER TABLE [dbo].[sf_scrity_roots_sf_permissions] CHECK CONSTRAINT [ref_sf_scrty_rts_sf_p_85D52DD2]
GO
