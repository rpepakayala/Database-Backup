/****** Object:  Table [dbo].[sf_scrty_rts_prmssnst_bjct_ttl]    Script Date: 5/15/2018 12:02:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_scrty_rts_prmssnst_bjct_ttl](
	[id] [uniqueidentifier] NOT NULL,
	[mapkey] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_scrty_rts_prmss_0539814E] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[mapkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_scrty_rts_prmssnst_bjct]    Script Date: 5/15/2018 12:02:02 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_scrty_rts_prmssnst_bjct] ON [dbo].[sf_scrty_rts_prmssnst_bjct_ttl]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_scrty_rts_prmssnst_bjct_ttl]  WITH CHECK ADD  CONSTRAINT [ref_sf_scrty_rts_prms_D96DAF71] FOREIGN KEY([id])
REFERENCES [dbo].[sf_security_roots] ([id])
ALTER TABLE [dbo].[sf_scrty_rts_prmssnst_bjct_ttl] CHECK CONSTRAINT [ref_sf_scrty_rts_prms_D96DAF71]
GO
