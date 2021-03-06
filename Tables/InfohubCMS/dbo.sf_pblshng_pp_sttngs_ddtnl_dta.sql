/****** Object:  Table [dbo].[sf_pblshng_pp_sttngs_ddtnl_dta]    Script Date: 5/15/2018 12:01:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pblshng_pp_sttngs_ddtnl_dta](
	[id] [uniqueidentifier] NOT NULL,
	[mapkey] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[val] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_pblshng_pp_sttn_2ED0E784] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[mapkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sf_pblshng_pp_sttngs_ddtnl_dta]  WITH CHECK ADD  CONSTRAINT [ref_sf_pblshng_pp_stt_8A8AB5D0] FOREIGN KEY([id])
REFERENCES [dbo].[sf_publishing_pipe_settings] ([id])
ALTER TABLE [dbo].[sf_pblshng_pp_sttngs_ddtnl_dta] CHECK CONSTRAINT [ref_sf_pblshng_pp_stt_8A8AB5D0]
GO
