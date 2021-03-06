/****** Object:  Table [dbo].[sysdac_instances_internal]    Script Date: 5/15/2018 12:03:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysdac_instances_internal](
	[instance_id] [uniqueidentifier] NOT NULL,
	[instance_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[type_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[type_version] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type_stream] [varbinary](max) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[created_by] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_sysdac_instances_internal] PRIMARY KEY CLUSTERED 
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_sysdac_instances_internal] UNIQUE NONCLUSTERED 
(
	[instance_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysdac_instances_internal] ADD  DEFAULT ('') FOR [description]
ALTER TABLE [dbo].[sysdac_instances_internal] ADD  DEFAULT (getdate()) FOR [date_created]
ALTER TABLE [dbo].[sysdac_instances_internal] ADD  DEFAULT ([dbo].[fn_sysdac_get_currentusername]()) FOR [created_by]
GO
