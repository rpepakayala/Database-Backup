/****** Object:  Table [dbo].[account_payments]    Script Date: 5/15/2018 12:03:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[account_payments](
	[entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[payment_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[amount] [decimal](11, 2) NOT NULL,
	[credit_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_account_payments_entity_id] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC,
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [credit_id]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [credit_id] ON [dbo].[account_payments]
(
	[credit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[account_payments] ADD  DEFAULT ((0.00)) FOR [amount]
ALTER TABLE [dbo].[account_payments] ADD  DEFAULT (NULL) FOR [credit_id]
GO
