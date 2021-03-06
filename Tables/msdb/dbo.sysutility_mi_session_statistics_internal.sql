/****** Object:  Table [dbo].[sysutility_mi_session_statistics_internal]    Script Date: 5/15/2018 12:03:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysutility_mi_session_statistics_internal](
	[collection_time] [datetimeoffset](7) NOT NULL,
	[session_id] [int] NOT NULL,
	[dac_instance_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[database_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[login_time] [datetime] NOT NULL,
	[cumulative_cpu_ms] [int] NOT NULL,
 CONSTRAINT [PK_sysutility_mi_session_statistics_internal] PRIMARY KEY CLUSTERED 
(
	[collection_time] ASC,
	[session_id] ASC,
	[dac_instance_name] ASC,
	[database_name] ASC,
	[login_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
