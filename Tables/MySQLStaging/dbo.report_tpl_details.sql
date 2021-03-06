/****** Object:  Table [dbo].[report_tpl_details]    Script Date: 5/15/2018 12:04:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[report_tpl_details](
	[tpl_id] [int] NOT NULL,
	[name] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[type] [nvarchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[x] [numeric](6, 2) NOT NULL,
	[y] [numeric](6, 2) NOT NULL,
	[x2] [numeric](6, 2) NOT NULL,
	[y2] [numeric](6, 2) NOT NULL,
	[font] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[size] [numeric](6, 2) NOT NULL,
	[mod] [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[align] [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[width] [numeric](6, 2) NOT NULL,
	[height] [numeric](6, 2) NOT NULL,
	[r] [smallint] NOT NULL,
	[g] [smallint] NOT NULL,
	[b] [smallint] NOT NULL,
	[prn_order] [smallint] NOT NULL,
 CONSTRAINT [PK_report_tpl_details_tpl_id] PRIMARY KEY CLUSTERED 
(
	[tpl_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT (N'text') FOR [type]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [x]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [y]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [x2]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [y2]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT (N'Arial') FOR [font]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((10.00)) FOR [size]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [width]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0.00)) FOR [height]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0)) FOR [r]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0)) FOR [g]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0)) FOR [b]
ALTER TABLE [dbo].[report_tpl_details] ADD  DEFAULT ((0)) FOR [prn_order]
GO
