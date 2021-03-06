/****** Object:  Table [dbo].[xf_session_admin]    Script Date: 5/15/2018 12:00:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_session_admin](
	[session_id] [varbinary](32) NOT NULL,
	[session_data] [varbinary](max) NOT NULL,
	[expiry_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_session_admin_session_id] PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [expiry_date]    Script Date: 5/15/2018 12:00:33 PM ******/
CREATE NONCLUSTERED INDEX [expiry_date] ON [dbo].[xf_session_admin]
(
	[expiry_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
