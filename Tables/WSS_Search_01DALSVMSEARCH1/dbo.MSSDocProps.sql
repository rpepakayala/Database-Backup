/****** Object:  Table [dbo].[MSSDocProps]    Script Date: 5/15/2018 12:09:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSDocProps](
	[DocId] [int] NOT NULL,
	[Pid] [int] NOT NULL,
	[RowId] [smallint] NOT NULL,
	[llVal] [bigint] NULL,
	[strVal] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[binVal] [image] NULL,
	[fltVal] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_MSSDocProps]    Script Date: 5/15/2018 12:09:09 PM ******/
CREATE CLUSTERED INDEX [IX_MSSDocProps] ON [dbo].[MSSDocProps]
(
	[DocId] ASC,
	[Pid] ASC,
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_Int]    Script Date: 5/15/2018 12:09:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_Int] ON [dbo].[MSSDocProps]
(
	[Pid] ASC,
	[llVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_Str]    Script Date: 5/15/2018 12:09:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_Str] ON [dbo].[MSSDocProps]
(
	[Pid] ASC,
	[strVal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
