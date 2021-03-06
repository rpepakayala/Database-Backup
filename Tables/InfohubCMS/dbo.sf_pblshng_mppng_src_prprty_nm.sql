/****** Object:  Table [dbo].[sf_pblshng_mppng_src_prprty_nm]    Script Date: 5/15/2018 12:01:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pblshng_mppng_src_prprty_nm](
	[id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_pblshng_mppng_s_9C1F42DB] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_pblshng_mppng_src_prprt]    Script Date: 5/15/2018 12:01:55 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pblshng_mppng_src_prprt] ON [dbo].[sf_pblshng_mppng_src_prprty_nm]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_pblshng_mppng_src_prprty_nm]  WITH CHECK ADD  CONSTRAINT [ref_sf_pblshng_mppng__D4283994] FOREIGN KEY([id])
REFERENCES [dbo].[sf_publishing_mapping] ([id])
ALTER TABLE [dbo].[sf_pblshng_mppng_src_prprty_nm] CHECK CONSTRAINT [ref_sf_pblshng_mppng__D4283994]
GO
