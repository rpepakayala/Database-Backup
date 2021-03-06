/****** Object:  Table [dbo].[sec_AuthenticatedUsers]    Script Date: 5/15/2018 12:00:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sec_AuthenticatedUsers](
	[username] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_id] [bigint] IDENTITY(3,1) NOT NULL,
	[parent_user_id] [bigint] NULL,
	[user_type] [bigint] NOT NULL,
	[first_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_AuthenticatedUsers] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_sec_AuthenticatedUsers_25_1154103152__K1_2]    Script Date: 5/15/2018 12:00:05 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_sec_AuthenticatedUsers_25_1154103152__K1_2] ON [dbo].[sec_AuthenticatedUsers]
(
	[username] ASC
)
INCLUDE ( 	[user_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
