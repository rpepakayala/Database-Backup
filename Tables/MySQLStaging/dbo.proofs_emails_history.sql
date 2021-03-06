/****** Object:  Table [dbo].[proofs_emails_history]    Script Date: 5/15/2018 12:04:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[proofs_emails_history](
	[proofs_emails_history_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[proofs_email_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[recorded_on] [datetime2](0) NOT NULL,
	[action] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_proofs_emails_history_proofs_emails_history_id] PRIMARY KEY CLUSTERED 
(
	[proofs_emails_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [proofs_email_id]    Script Date: 5/15/2018 12:04:27 PM ******/
CREATE NONCLUSTERED INDEX [proofs_email_id] ON [dbo].[proofs_emails_history]
(
	[proofs_email_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[proofs_emails_history] ADD  DEFAULT (N'viewed') FOR [action]
GO
