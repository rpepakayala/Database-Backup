/****** Object:  Table [dbo].[Notifications]    Script Date: 5/15/2018 12:02:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [uniqueidentifier] NOT NULL,
	[SubscriptionID] [uniqueidentifier] NOT NULL,
	[ActivationID] [uniqueidentifier] NULL,
	[ReportID] [uniqueidentifier] NOT NULL,
	[SnapShotDate] [datetime] NULL,
	[ExtensionSettings] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Locale] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Parameters] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ProcessStart] [datetime] NULL,
	[NotificationEntered] [datetime] NOT NULL,
	[ProcessAfter] [datetime] NULL,
	[Attempt] [int] NULL,
	[SubscriptionLastRunTime] [datetime] NOT NULL,
	[DeliveryExtension] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[SubscriptionOwnerID] [uniqueidentifier] NOT NULL,
	[IsDataDriven] [bit] NOT NULL,
	[BatchID] [uniqueidentifier] NULL,
	[ProcessHeartbeat] [datetime] NULL,
	[Version] [int] NOT NULL,
	[ReportZone] [int] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Notifications]    Script Date: 5/15/2018 12:02:21 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications] ON [dbo].[Notifications]
(
	[ProcessAfter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Notifications2]    Script Date: 5/15/2018 12:02:21 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications2] ON [dbo].[Notifications]
(
	[ProcessStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Notifications3]    Script Date: 5/15/2018 12:02:21 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications3] ON [dbo].[Notifications]
(
	[NotificationEntered] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [ReportZone]
ALTER TABLE [dbo].[Notifications]  WITH NOCHECK ADD  CONSTRAINT [FK_Notifications_Subscriptions] FOREIGN KEY([SubscriptionID])
REFERENCES [dbo].[Subscriptions] ([SubscriptionID])
ON DELETE CASCADE
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Subscriptions]
GO
