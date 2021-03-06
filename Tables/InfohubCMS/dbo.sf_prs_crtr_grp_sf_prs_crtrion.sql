/****** Object:  Table [dbo].[sf_prs_crtr_grp_sf_prs_crtrion]    Script Date: 5/15/2018 12:01:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_prs_crtr_grp_sf_prs_crtrion](
	[sf_prs_criteria_group_id] [int] NOT NULL,
	[seq] [int] NOT NULL,
	[sf_prs_criterion_id] [int] NULL,
 CONSTRAINT [pk_sf_prs_crtr_grp_sf_CF27D9C4] PRIMARY KEY CLUSTERED 
(
	[sf_prs_criteria_group_id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_prs_crtr_grp_sf_prs_crt]    Script Date: 5/15/2018 12:01:59 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_prs_crtr_grp_sf_prs_crt] ON [dbo].[sf_prs_crtr_grp_sf_prs_crtrion]
(
	[sf_prs_criterion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_prs_crtr_grp_sf_prs_crtrion]  WITH CHECK ADD  CONSTRAINT [ref_sf_prs_crtr_grp_s_3FD9548B] FOREIGN KEY([sf_prs_criterion_id])
REFERENCES [dbo].[sf_prs_criterion] ([sf_prs_criterion_id])
ALTER TABLE [dbo].[sf_prs_crtr_grp_sf_prs_crtrion] CHECK CONSTRAINT [ref_sf_prs_crtr_grp_s_3FD9548B]
ALTER TABLE [dbo].[sf_prs_crtr_grp_sf_prs_crtrion]  WITH CHECK ADD  CONSTRAINT [ref_sf_prs_crtr_grp_s_AA06D665] FOREIGN KEY([sf_prs_criteria_group_id])
REFERENCES [dbo].[sf_prs_criteria_group] ([sf_prs_criteria_group_id])
ALTER TABLE [dbo].[sf_prs_crtr_grp_sf_prs_crtrion] CHECK CONSTRAINT [ref_sf_prs_crtr_grp_s_AA06D665]
GO
