/****** Object:  Table [dbo].[sf_commnt_sf_commnt]    Script Date: 5/15/2018 12:01:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_commnt_sf_commnt](
	[content_id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[content_id2] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_commnt_sf_commnt] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_cmmnt_sf_cmmnt_cntnt_d2]    Script Date: 5/15/2018 12:01:27 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_cmmnt_sf_cmmnt_cntnt_d2] ON [dbo].[sf_commnt_sf_commnt]
(
	[content_id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_commnt_sf_commnt]  WITH CHECK ADD  CONSTRAINT [ref_sf_cmmnt_sf_cmmnt_B9C81E12] FOREIGN KEY([content_id2])
REFERENCES [dbo].[sf_commnt] ([content_id])
ALTER TABLE [dbo].[sf_commnt_sf_commnt] CHECK CONSTRAINT [ref_sf_cmmnt_sf_cmmnt_B9C81E12]
ALTER TABLE [dbo].[sf_commnt_sf_commnt]  WITH CHECK ADD  CONSTRAINT [ref_sf_cmmnt_sf_cmmnt_B9C81E1F] FOREIGN KEY([content_id])
REFERENCES [dbo].[sf_commnt] ([content_id])
ALTER TABLE [dbo].[sf_commnt_sf_commnt] CHECK CONSTRAINT [ref_sf_cmmnt_sf_cmmnt_B9C81E1F]
GO
