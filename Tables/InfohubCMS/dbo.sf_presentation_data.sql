/****** Object:  Table [dbo].[sf_presentation_data]    Script Date: 5/15/2018 12:01:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_presentation_data](
	[theme] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[resource_assembly_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ownr] [uniqueidentifier] NULL,
	[nme] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NULL,
	[id] [uniqueidentifier] NOT NULL,
	[embedded_template_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_created] [datetime] NULL,
	[data_type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dta] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_class] [int] NOT NULL,
	[voa_version] [smallint] NOT NULL,
	[resource_class_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name_for_developers] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_different_from_embedded] [tinyint] NULL,
	[friendly_control_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[control_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_id] [uniqueidentifier] NULL,
	[condition] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[area_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id3] [uniqueidentifier] NULL,
	[id4] [uniqueidentifier] NULL,
	[id2] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_presentation_data] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_presentation_data]    Script Date: 5/15/2018 12:01:58 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_presentation_data] ON [dbo].[sf_presentation_data]
(
	[app_name] ASC,
	[embedded_template_name] ASC,
	[resource_assembly_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_presentation_data_id2]    Script Date: 5/15/2018 12:01:58 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_presentation_data_id2] ON [dbo].[sf_presentation_data]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_presentation_data_id4]    Script Date: 5/15/2018 12:01:58 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_presentation_data_id4] ON [dbo].[sf_presentation_data]
(
	[id4] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_prsntation_data_item_id]    Script Date: 5/15/2018 12:01:58 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_prsntation_data_item_id] ON [dbo].[sf_presentation_data]
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
