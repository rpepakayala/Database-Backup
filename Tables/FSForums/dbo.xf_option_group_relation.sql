/****** Object:  Table [dbo].[xf_option_group_relation]    Script Date: 5/15/2018 12:00:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_option_group_relation](
	[option_id] [varbinary](50) NOT NULL,
	[group_id] [varbinary](50) NOT NULL,
	[display_order] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_option_group_relation_option_id] PRIMARY KEY CLUSTERED 
(
	[option_id] ASC,
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [group_id_display_order]    Script Date: 5/15/2018 12:00:28 PM ******/
CREATE NONCLUSTERED INDEX [group_id_display_order] ON [dbo].[xf_option_group_relation]
(
	[group_id] ASC,
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
