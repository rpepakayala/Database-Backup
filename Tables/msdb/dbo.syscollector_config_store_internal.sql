/****** Object:  Table [dbo].[syscollector_config_store_internal]    Script Date: 5/15/2018 12:03:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscollector_config_store_internal](
	[parameter_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parameter_value] [sql_variant] NULL,
 CONSTRAINT [PK_syscollector_config_store_internal_paremeter_name] PRIMARY KEY CLUSTERED 
(
	[parameter_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
