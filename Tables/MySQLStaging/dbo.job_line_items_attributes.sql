/****** Object:  Table [dbo].[job_line_items_attributes]    Script Date: 5/15/2018 12:04:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[job_line_items_attributes](
	[job_line_item_id] [int] NOT NULL,
	[attribute_id] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_job_line_items_attributes_job_line_item_id] PRIMARY KEY CLUSTERED 
(
	[job_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[job_line_items_attributes] ADD  DEFAULT (NULL) FOR [attribute_id]
GO
