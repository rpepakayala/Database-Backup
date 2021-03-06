/****** Object:  Table [dbo].[returned_fund]    Script Date: 5/15/2018 12:04:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[returned_fund](
	[returned_fund_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[account_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequence] [int] NOT NULL,
	[amount] [decimal](12, 2) NOT NULL,
	[transaction_fee] [decimal](12, 2) NULL,
	[notes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified_on] [datetime2](0) NULL,
 CONSTRAINT [PK_returned_fund_returned_fund_id] PRIMARY KEY CLUSTERED 
(
	[returned_fund_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [returned_fund$returned_fund_id_UNIQUE] UNIQUE NONCLUSTERED 
(
	[returned_fund_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[returned_fund] ADD  DEFAULT (NULL) FOR [user_id]
ALTER TABLE [dbo].[returned_fund] ADD  DEFAULT (NULL) FOR [job_id]
ALTER TABLE [dbo].[returned_fund] ADD  DEFAULT (NULL) FOR [transaction_fee]
ALTER TABLE [dbo].[returned_fund] ADD  DEFAULT (NULL) FOR [last_modified_by]
ALTER TABLE [dbo].[returned_fund] ADD  DEFAULT (NULL) FOR [last_modified_on]
GO
