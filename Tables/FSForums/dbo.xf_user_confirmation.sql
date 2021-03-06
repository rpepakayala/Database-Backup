/****** Object:  Table [dbo].[xf_user_confirmation]    Script Date: 5/15/2018 12:00:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_confirmation](
	[user_id] [bigint] NOT NULL,
	[confirmation_type] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[confirmation_key] [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[confirmation_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_user_confirmation_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[confirmation_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [confirmation_date]    Script Date: 5/15/2018 12:00:39 PM ******/
CREATE NONCLUSTERED INDEX [confirmation_date] ON [dbo].[xf_user_confirmation]
(
	[confirmation_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
