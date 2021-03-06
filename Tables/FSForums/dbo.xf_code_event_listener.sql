/****** Object:  Table [dbo].[xf_code_event_listener]    Script Date: 5/15/2018 12:00:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_code_event_listener](
	[event_listener_id] [bigint] IDENTITY(104,1) NOT NULL,
	[event_id] [varbinary](50) NOT NULL,
	[execute_order] [bigint] NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[callback_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[callback_method] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[active] [tinyint] NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
	[hint] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_code_event_listener_event_listener_id] PRIMARY KEY CLUSTERED 
(
	[event_listener_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [addon_id_event_id]    Script Date: 5/15/2018 12:00:18 PM ******/
CREATE NONCLUSTERED INDEX [addon_id_event_id] ON [dbo].[xf_code_event_listener]
(
	[addon_id] ASC,
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [event_id_execute_order]    Script Date: 5/15/2018 12:00:18 PM ******/
CREATE NONCLUSTERED INDEX [event_id_execute_order] ON [dbo].[xf_code_event_listener]
(
	[event_id] ASC,
	[execute_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_code_event_listener] ADD  DEFAULT (N'') FOR [hint]
GO
