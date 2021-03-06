/****** Object:  Table [dbo].[spt_monitor]    Script Date: 5/15/2018 12:02:51 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[spt_monitor](
	[lastrun] [datetime] NOT NULL,
	[cpu_busy] [int] NOT NULL,
	[io_busy] [int] NOT NULL,
	[idle] [int] NOT NULL,
	[pack_received] [int] NOT NULL,
	[pack_sent] [int] NOT NULL,
	[connections] [int] NOT NULL,
	[pack_errors] [int] NOT NULL,
	[total_read] [int] NOT NULL,
	[total_write] [int] NOT NULL,
	[total_errors] [int] NOT NULL
) ON [PRIMARY]

GO
