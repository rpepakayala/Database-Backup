/****** Object:  Table [dbo].[sf_notif_subscriptions]    Script Date: 5/15/2018 12:01:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_notif_subscriptions](
	[subscriber_id] [uniqueidentifier] NULL,
	[list_id] [uniqueidentifier] NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_notif_subscriptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_ns_sn_list_subscriber]    Script Date: 5/15/2018 12:01:52 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_sf_ns_sn_list_subscriber] ON [dbo].[sf_notif_subscriptions]
(
	[list_id] ASC,
	[subscriber_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_ns_sn_subscriber]    Script Date: 5/15/2018 12:01:52 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_ns_sn_subscriber] ON [dbo].[sf_notif_subscriptions]
(
	[subscriber_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
