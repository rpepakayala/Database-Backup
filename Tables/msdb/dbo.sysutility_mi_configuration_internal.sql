/****** Object:  Table [dbo].[sysutility_mi_configuration_internal]    Script Date: 5/15/2018 12:03:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
CREATE TABLE [dbo].[sysutility_mi_configuration_internal](
	[configuration_id]  AS ((1)),
	[ucp_instance_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mdw_database_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sysutility_mi_configuration_internal_configuration_id] PRIMARY KEY CLUSTERED 
(
	[configuration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
