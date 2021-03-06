/****** Object:  Table [dbo].[sf_notif_msg_job]    Script Date: 5/15/2018 12:01:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_notif_msg_job](
	[subsription_list_id] [uniqueidentifier] NULL,
	[sender_profile_name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sender_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sender_address] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[module_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[message_template_id] [uniqueidentifier] NULL,
	[last_activity_date] [datetime] NULL,
	[job_status] [int] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[failure_description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[clear_subscription_data] [tinyint] NOT NULL,
	[account_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_notif_msg_job] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
