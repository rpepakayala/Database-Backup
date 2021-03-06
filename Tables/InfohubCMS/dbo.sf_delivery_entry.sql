/****** Object:  Table [dbo].[sf_delivery_entry]    Script Date: 5/15/2018 12:01:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_delivery_entry](
	[sf_delivery_entry_id] [int] NOT NULL,
	[subscriber_id] [uniqueidentifier] NULL,
	[delivery_status] [int] NOT NULL,
	[delivery_date] [datetime] NOT NULL,
	[campaign_id] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_delivery_entry] PRIMARY KEY CLUSTERED 
(
	[sf_delivery_entry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_delivery_entry_camp_subscr]    Script Date: 5/15/2018 12:01:29 PM ******/
CREATE NONCLUSTERED INDEX [idx_delivery_entry_camp_subscr] ON [dbo].[sf_delivery_entry]
(
	[campaign_id] ASC,
	[subscriber_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
