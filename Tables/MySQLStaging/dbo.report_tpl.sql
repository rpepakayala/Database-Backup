/****** Object:  Table [dbo].[report_tpl]    Script Date: 5/15/2018 12:04:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[report_tpl](
	[tpl_id] [int] IDENTITY(2,1) NOT NULL,
	[master] [int] NULL,
	[franchise_id] [int] NULL,
	[name] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[height] [numeric](5, 1) NOT NULL,
	[width] [numeric](5, 1) NOT NULL,
	[margin_left] [numeric](6, 2) NOT NULL,
	[margin_right] [numeric](6, 2) NOT NULL,
	[margin_top] [numeric](6, 2) NOT NULL,
	[margin_bottom] [numeric](6, 2) NOT NULL,
	[creator] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[author] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[title] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subject] [nvarchar](124) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[auto_break] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_report_tpl_tpl_id] PRIMARY KEY CLUSTERED 
(
	[tpl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [master]    Script Date: 5/15/2018 12:04:28 PM ******/
CREATE NONCLUSTERED INDEX [master] ON [dbo].[report_tpl]
(
	[master] ASC,
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT (NULL) FOR [master]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT (NULL) FOR [franchise_id]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((279.0)) FOR [height]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((216.0)) FOR [width]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((0.00)) FOR [margin_left]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((0.00)) FOR [margin_right]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((0.00)) FOR [margin_top]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT ((0.00)) FOR [margin_bottom]
ALTER TABLE [dbo].[report_tpl] ADD  DEFAULT (N'false') FOR [auto_break]
GO
