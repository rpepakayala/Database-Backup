/****** Object:  Table [dbo].[sec_AuthenticatedSessions]    Script Date: 5/15/2018 12:00:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sec_AuthenticatedSessions](
	[auth_session_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[expires] [datetime] NULL,
	[guid_id] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created] [datetime] NULL,
 CONSTRAINT [PK_AuthenticatedSessions] PRIMARY KEY CLUSTERED 
(
	[auth_session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_sec_AuthenticatedSessions_25_754101727__K2_K3_4]    Script Date: 5/15/2018 12:00:05 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_sec_AuthenticatedSessions_25_754101727__K2_K3_4] ON [dbo].[sec_AuthenticatedSessions]
(
	[user_id] ASC,
	[expires] ASC
)
INCLUDE ( 	[guid_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_sec_AuthenticatedSessions_25_754101727__K4_K3_K2]    Script Date: 5/15/2018 12:00:05 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_sec_AuthenticatedSessions_25_754101727__K4_K3_K2] ON [dbo].[sec_AuthenticatedSessions]
(
	[guid_id] ASC,
	[expires] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sec_AuthenticatedSessions]  WITH CHECK ADD  CONSTRAINT [FK_AuthenticatedSessions_AuthenticatedUsers] FOREIGN KEY([user_id])
REFERENCES [dbo].[sec_AuthenticatedUsers] ([user_id])
ALTER TABLE [dbo].[sec_AuthenticatedSessions] CHECK CONSTRAINT [FK_AuthenticatedSessions_AuthenticatedUsers]
GO
