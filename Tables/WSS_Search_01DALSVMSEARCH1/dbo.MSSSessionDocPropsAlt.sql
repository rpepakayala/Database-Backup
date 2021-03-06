/****** Object:  Table [dbo].[MSSSessionDocPropsAlt]    Script Date: 5/15/2018 12:09:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSSessionDocPropsAlt](
	[CatalogId] [smallint] NOT NULL,
	[DocId] [int] NOT NULL,
	[Pid] [int] NOT NULL,
	[RowId] [smallint] NOT NULL,
	[llVal] [bigint] NULL,
	[strVal] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[binVal] [image] NULL,
	[fltVal] [float] NULL,
	[RecordExists] [bit] NOT NULL,
	[llValChanged] [bit] NOT NULL,
	[strValChanged] [bit] NOT NULL,
	[fltValChanged] [bit] NOT NULL,
	[binValChanged] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_MSSSessionDocPropsAlt]    Script Date: 5/15/2018 12:09:12 PM ******/
CREATE CLUSTERED INDEX [IX_MSSSessionDocPropsAlt] ON [dbo].[MSSSessionDocPropsAlt]
(
	[DocId] ASC,
	[Pid] ASC,
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[MSSSessionDocPropsAlt] ADD  DEFAULT ((0)) FOR [RecordExists]
ALTER TABLE [dbo].[MSSSessionDocPropsAlt] ADD  DEFAULT ((0)) FOR [llValChanged]
ALTER TABLE [dbo].[MSSSessionDocPropsAlt] ADD  DEFAULT ((0)) FOR [strValChanged]
ALTER TABLE [dbo].[MSSSessionDocPropsAlt] ADD  DEFAULT ((0)) FOR [fltValChanged]
ALTER TABLE [dbo].[MSSSessionDocPropsAlt] ADD  DEFAULT ((0)) FOR [binValChanged]
GO
