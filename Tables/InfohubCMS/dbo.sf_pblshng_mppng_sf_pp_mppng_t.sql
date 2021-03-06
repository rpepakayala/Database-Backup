/****** Object:  Table [dbo].[sf_pblshng_mppng_sf_pp_mppng_t]    Script Date: 5/15/2018 12:01:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pblshng_mppng_sf_pp_mppng_t](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[id2] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_pblshng_mppng_s_9695ECE0] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_pblshng_mppng_sf_pp_mpp]    Script Date: 5/15/2018 12:01:55 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pblshng_mppng_sf_pp_mpp] ON [dbo].[sf_pblshng_mppng_sf_pp_mppng_t]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_pblshng_mppng_sf_pp_mppng_t]  WITH CHECK ADD  CONSTRAINT [ref_sf_pblshng_mppng__423E25FB] FOREIGN KEY([id])
REFERENCES [dbo].[sf_publishing_mapping] ([id])
ALTER TABLE [dbo].[sf_pblshng_mppng_sf_pp_mppng_t] CHECK CONSTRAINT [ref_sf_pblshng_mppng__423E25FB]
ALTER TABLE [dbo].[sf_pblshng_mppng_sf_pp_mppng_t]  WITH CHECK ADD  CONSTRAINT [ref_sf_pblshng_mppng__99FB3F80] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_pipe_mapping_translation] ([id])
ALTER TABLE [dbo].[sf_pblshng_mppng_sf_pp_mppng_t] CHECK CONSTRAINT [ref_sf_pblshng_mppng__99FB3F80]
GO
