/****** Object:  Table [dbo].[dm_launch_group]    Script Date: 5/15/2018 12:04:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dm_launch_group](
	[launch_group_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[group_nm] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[start_dt] [date] NULL,
	[end_dt] [date] NULL,
 CONSTRAINT [PK_dm_launch_group_launch_group_id] PRIMARY KEY CLUSTERED 
(
	[launch_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[dm_launch_group] ADD  DEFAULT (NULL) FOR [group_nm]
ALTER TABLE [dbo].[dm_launch_group] ADD  DEFAULT (NULL) FOR [start_dt]
ALTER TABLE [dbo].[dm_launch_group] ADD  DEFAULT (NULL) FOR [end_dt]
GO
