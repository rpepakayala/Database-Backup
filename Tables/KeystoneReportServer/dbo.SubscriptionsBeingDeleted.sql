/****** Object:  Table [dbo].[SubscriptionsBeingDeleted]    Script Date: 5/15/2018 12:02:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SubscriptionsBeingDeleted](
	[SubscriptionID] [uniqueidentifier] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SubscriptionsBeingDeleted] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
