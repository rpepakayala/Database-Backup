/****** Object:  Table [dbo].[quickbooks_accounts]    Script Date: 5/15/2018 12:04:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[quickbooks_accounts](
	[quickbooks_account_id] [bigint] NOT NULL,
	[name] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[account_type] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[balance_type] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[method_call] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_quickbooks_accounts_quickbooks_account_id] PRIMARY KEY CLUSTERED 
(
	[quickbooks_account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [name]    Script Date: 5/15/2018 12:04:28 PM ******/
CREATE NONCLUSTERED INDEX [name] ON [dbo].[quickbooks_accounts]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[quickbooks_accounts] ADD  DEFAULT (NULL) FOR [account_type]
ALTER TABLE [dbo].[quickbooks_accounts] ADD  DEFAULT (NULL) FOR [balance_type]
ALTER TABLE [dbo].[quickbooks_accounts] ADD  DEFAULT (NULL) FOR [method_call]
GO
