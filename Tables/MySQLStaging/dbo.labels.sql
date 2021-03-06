/****** Object:  Table [dbo].[labels]    Script Date: 5/15/2018 12:04:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[labels](
	[label_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[label] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_labels_label_id] PRIMARY KEY CLUSTERED 
(
	[label_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[labels] ADD  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[labels] ADD  DEFAULT (N'0') FOR [franchise_id]
GO
