/****** Object:  Table [dbo].[sf_pckgng_addns_stts]    Script Date: 5/15/2018 12:01:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pckgng_addns_stts](
	[strctr_stts] [int] NULL,
	[site_id] [uniqueidentifier] NOT NULL,
	[dta_stts] [int] NULL,
	[addn_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_pckgng_addns_stts] PRIMARY KEY CLUSTERED 
(
	[addn_id] ASC,
	[site_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_pckgng_ddns_stts_ddn_id]    Script Date: 5/15/2018 12:01:56 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pckgng_ddns_stts_ddn_id] ON [dbo].[sf_pckgng_addns_stts]
(
	[addn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
