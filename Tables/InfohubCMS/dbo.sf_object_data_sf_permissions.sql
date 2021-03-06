/****** Object:  Table [dbo].[sf_object_data_sf_permissions]    Script Date: 5/15/2018 12:01:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_object_data_sf_permissions](
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_bjct_dt_sf_prms_20DDAA71] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_bjct_dt_sf_prmssons_id2]    Script Date: 5/15/2018 12:01:53 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_bjct_dt_sf_prmssons_id2] ON [dbo].[sf_object_data_sf_permissions]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_object_data_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_bjct_dt_sf_prm_E825EAAE] FOREIGN KEY([id2])
REFERENCES [dbo].[sf_permissions] ([id])
ALTER TABLE [dbo].[sf_object_data_sf_permissions] CHECK CONSTRAINT [ref_sf_bjct_dt_sf_prm_E825EAAE]
ALTER TABLE [dbo].[sf_object_data_sf_permissions]  WITH CHECK ADD  CONSTRAINT [ref_sf_bjct_dt_sf_prm_F52EE9B1] FOREIGN KEY([id])
REFERENCES [dbo].[sf_object_data] ([id])
ALTER TABLE [dbo].[sf_object_data_sf_permissions] CHECK CONSTRAINT [ref_sf_bjct_dt_sf_prm_F52EE9B1]
GO
