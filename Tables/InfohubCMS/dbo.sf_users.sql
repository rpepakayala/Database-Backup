/****** Object:  Table [dbo].[sf_users]    Script Date: 5/15/2018 12:02:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_users](
	[user_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[salt] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[password_question] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[password_format] [int] NOT NULL,
	[password_answer] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[passwd] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[manager_info] [uniqueidentifier] NULL,
	[last_password_changed_date] [datetime] NULL,
	[last_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NULL,
	[last_login_ip] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_login_date] [datetime] NULL,
	[last_lockout_date] [datetime] NULL,
	[last_activity_date] [datetime] NULL,
	[is_logged_in] [bit] NULL,
	[is_locked_out] [bit] NULL,
	[is_backend_user] [bit] NULL,
	[is_approved] [bit] NULL,
	[id] [uniqueidentifier] NOT NULL,
	[first_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fld_psswrd_ttempt_window_start] [datetime] NULL,
	[failed_password_attempt_count] [int] NOT NULL,
	[fld_psswrd_nswr_ttmpt_wndw_str] [datetime] NULL,
	[fld_psswrd_nswer_attempt_count] [int] NOT NULL,
	[email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[creation_date] [datetime] NULL,
	[commnt] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [userNameIndex]    Script Date: 5/15/2018 12:02:08 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [userNameIndex] ON [dbo].[sf_users]
(
	[user_name] ASC,
	[app_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
