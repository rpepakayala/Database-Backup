/****** Object:  Table [dbo].[xf_user_alert_optout]    Script Date: 5/15/2018 12:00:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_alert_optout](
	[user_id] [bigint] NOT NULL,
	[alert] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_xf_user_alert_optout_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[alert] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
