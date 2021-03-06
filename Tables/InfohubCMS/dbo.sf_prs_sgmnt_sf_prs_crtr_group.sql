/****** Object:  Table [dbo].[sf_prs_sgmnt_sf_prs_crtr_group]    Script Date: 5/15/2018 12:02:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_prs_sgmnt_sf_prs_crtr_group](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[sf_prs_criteria_group_id] [int] NULL,
 CONSTRAINT [pk_sf_prs_sgmnt_sf_pr_5C3F8446] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_prs_sgmnt_sf_prs_crtr_g]    Script Date: 5/15/2018 12:02:00 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_prs_sgmnt_sf_prs_crtr_g] ON [dbo].[sf_prs_sgmnt_sf_prs_crtr_group]
(
	[sf_prs_criteria_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_prs_sgmnt_sf_prs_crtr_group]  WITH CHECK ADD  CONSTRAINT [ref_sf_prs_sgmnt_sf_p_8B779700] FOREIGN KEY([sf_prs_criteria_group_id])
REFERENCES [dbo].[sf_prs_criteria_group] ([sf_prs_criteria_group_id])
ALTER TABLE [dbo].[sf_prs_sgmnt_sf_prs_crtr_group] CHECK CONSTRAINT [ref_sf_prs_sgmnt_sf_p_8B779700]
ALTER TABLE [dbo].[sf_prs_sgmnt_sf_prs_crtr_group]  WITH CHECK ADD  CONSTRAINT [ref_sf_prs_sgmnt_sf_p_DCC8A1FE] FOREIGN KEY([id])
REFERENCES [dbo].[sf_prs_segment] ([id])
ALTER TABLE [dbo].[sf_prs_sgmnt_sf_prs_crtr_group] CHECK CONSTRAINT [ref_sf_prs_sgmnt_sf_p_DCC8A1FE]
GO
