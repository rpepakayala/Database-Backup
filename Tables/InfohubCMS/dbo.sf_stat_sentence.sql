/****** Object:  Table [dbo].[sf_stat_sentence]    Script Date: 5/15/2018 12:02:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_stat_sentence](
	[verb] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[time_stamp] [datetime] NOT NULL,
	[subject_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_string_meta_field5] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_string_meta_field4] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_string_meta_field3] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_string_meta_field2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_string_meta_field1] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_provider] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_key] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject_int_meta_field] [int] NOT NULL,
	[subject_id] [uniqueidentifier] NULL,
	[subject_double_meta_field] [float] NOT NULL,
	[subject_decimal_meta_field] [numeric](20, 10) NOT NULL,
	[subject_date_time_meta_field] [datetime] NOT NULL,
	[subject_bool_meta_field] [tinyint] NOT NULL,
	[object_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_string_meta_field5] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_string_meta_field4] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_string_meta_field3] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_string_meta_field2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_string_meta_field1] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_provider] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_key] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[object_int_meta_field] [int] NOT NULL,
	[object_id] [uniqueidentifier] NULL,
	[object_double_meta_field] [float] NOT NULL,
	[object_decimal_meta_field] [numeric](20, 10) NOT NULL,
	[object_date_time_meta_field] [datetime] NOT NULL,
	[object_bool_meta_field] [tinyint] NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pk_sf_stat_sentence] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_sf_stat_sntnc_subject_key]    Script Date: 5/15/2018 12:02:04 PM ******/
CREATE NONCLUSTERED INDEX [IX_sf_stat_sntnc_subject_key] ON [dbo].[sf_stat_sentence]
(
	[subject_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
