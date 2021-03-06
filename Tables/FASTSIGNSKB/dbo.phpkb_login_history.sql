/****** Object:  Table [dbo].[phpkb_login_history]    Script Date: 5/15/2018 11:59:18 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_login_history](
	[login_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[ip_address] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_login] [smalldatetime] NOT NULL,
 CONSTRAINT [login_id] PRIMARY KEY CLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_login_history] ADD  DEFAULT ((0)) FOR [user_id]
GO
