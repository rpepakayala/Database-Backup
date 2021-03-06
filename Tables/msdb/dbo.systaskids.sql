/****** Object:  Table [dbo].[systaskids]    Script Date: 5/15/2018 12:03:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[systaskids](
	[task_id] [int] IDENTITY(1,1) NOT NULL,
	[job_id] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:13 PM ******/
CREATE CLUSTERED INDEX [clust] ON [dbo].[systaskids]
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
