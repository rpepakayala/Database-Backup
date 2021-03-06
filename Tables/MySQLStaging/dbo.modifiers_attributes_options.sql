/****** Object:  Table [dbo].[modifiers_attributes_options]    Script Date: 5/15/2018 12:04:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[modifiers_attributes_options](
	[modifiers_attributes_options_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[modifiers_attributes_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] [decimal](10, 2) NULL,
	[order_no] [smallint] NOT NULL,
 CONSTRAINT [PK_modifiers_attributes_options_modifiers_attributes_options_id] PRIMARY KEY CLUSTERED 
(
	[modifiers_attributes_options_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [attr]    Script Date: 5/15/2018 12:04:20 PM ******/
CREATE NONCLUSTERED INDEX [attr] ON [dbo].[modifiers_attributes_options]
(
	[modifiers_attributes_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[modifiers_attributes_options] ADD  DEFAULT (NULL) FOR [value]
GO
