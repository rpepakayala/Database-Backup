/****** Object:  Table [dbo].[sec_StoreSubscription]    Script Date: 5/15/2018 12:00:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sec_StoreSubscription](
	[store_subsc_id] [bigint] IDENTITY(2,1) NOT NULL,
	[store_number] [bigint] NULL,
	[state_id] [bigint] NULL,
	[date_transition] [datetime] NULL,
	[application_id] [bigint] NULL,
	[subsc_pwd] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_SubscriptionStoreState] PRIMARY KEY CLUSTERED 
(
	[store_subsc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_sec_StoreSubscription_25_437576597__K2_K5_1_3_4_6]    Script Date: 5/15/2018 12:00:05 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_sec_StoreSubscription_25_437576597__K2_K5_1_3_4_6] ON [dbo].[sec_StoreSubscription]
(
	[store_number] ASC,
	[application_id] ASC
)
INCLUDE ( 	[store_subsc_id],
	[state_id],
	[date_transition],
	[subsc_pwd]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[sec_StoreSubscription]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionStoreState_Applications] FOREIGN KEY([application_id])
REFERENCES [dbo].[sec_Applications] ([application_id])
ALTER TABLE [dbo].[sec_StoreSubscription] CHECK CONSTRAINT [FK_SubscriptionStoreState_Applications]
ALTER TABLE [dbo].[sec_StoreSubscription]  WITH NOCHECK ADD  CONSTRAINT [FK_SubscriptionStoreState_SubscriptionState] FOREIGN KEY([state_id])
REFERENCES [dbo].[sec_SubscriptionState] ([state_id])
ALTER TABLE [dbo].[sec_StoreSubscription] CHECK CONSTRAINT [FK_SubscriptionStoreState_SubscriptionState]
GO
