/****** Object:  Table [dbo].[sales_goal]    Script Date: 5/15/2018 12:04:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sales_goal](
	[sales_goal_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_year] [int] NOT NULL,
	[sales_month] [int] NOT NULL,
	[goal_amount] [decimal](10, 2) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime] NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_sales_goal] PRIMARY KEY CLUSTERED 
(
	[sales_goal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[sales_goal] ADD  DEFAULT (NULL) FOR [users_id]
ALTER TABLE [dbo].[sales_goal] ADD  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[sales_goal] ADD  DEFAULT (NULL) FOR [last_modified_by]
GO
