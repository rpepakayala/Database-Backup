/****** Object:  Table [dbo].[sf_cntnt_tms_pblshd_trnsltions]    Script Date: 5/15/2018 12:01:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_cntnt_tms_pblshd_trnsltions](
	[content_id] [uniqueidentifier] NOT NULL,
	[seq] [int] NOT NULL,
	[val] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_cntnt_tms_pblsh_1C0E917D] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_cntnt_tms_pblshd_trnslt]    Script Date: 5/15/2018 12:01:26 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_cntnt_tms_pblshd_trnslt] ON [dbo].[sf_cntnt_tms_pblshd_trnsltions]
(
	[val] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sf_cntnt_tms_pblshd_trnsltions]  WITH CHECK ADD  CONSTRAINT [ref_sf_cntnt_tms_pbls_64AAB6C3] FOREIGN KEY([content_id])
REFERENCES [dbo].[sf_content_items] ([content_id])
ALTER TABLE [dbo].[sf_cntnt_tms_pblshd_trnsltions] CHECK CONSTRAINT [ref_sf_cntnt_tms_pbls_64AAB6C3]
GO
