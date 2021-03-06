/****** Object:  Table [dbo].[syspolicy_policy_execution_history_details_internal]    Script Date: 5/15/2018 12:03:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_policy_execution_history_details_internal](
	[detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[history_id] [bigint] NOT NULL,
	[target_query_expression] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[target_query_expression_with_id] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[execution_date] [datetime] NOT NULL,
	[result] [bit] NOT NULL,
	[result_detail] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[exception_message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[exception] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_syspolicy_policy_execution_history_details_id] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC,
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[syspolicy_policy_execution_history_details_internal] ADD  DEFAULT (getdate()) FOR [execution_date]
ALTER TABLE [dbo].[syspolicy_policy_execution_history_details_internal]  WITH CHECK ADD FOREIGN KEY([history_id])
REFERENCES [dbo].[syspolicy_policy_execution_history_internal] ([history_id])
ON DELETE CASCADE
GO
