/****** Object:  Table [dbo].[sf_form_description_attrbutes]    Script Date: 5/15/2018 12:01:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_form_description_attrbutes](
	[content_id] [uniqueidentifier] NOT NULL,
	[mapkey] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[val] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_frm_dscrptn_ttr_61694FD8] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC,
	[mapkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sf_form_description_attrbutes]  WITH CHECK ADD  CONSTRAINT [ref_sf_frm_dscrptn_tt_A8F24C50] FOREIGN KEY([content_id])
REFERENCES [dbo].[sf_form_description] ([content_id])
ALTER TABLE [dbo].[sf_form_description_attrbutes] CHECK CONSTRAINT [ref_sf_frm_dscrptn_tt_A8F24C50]
GO
