/****** Object:  Table [internal].[validations]    Script Date: 5/15/2018 12:06:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[validations](
	[validation_id] [bigint] NOT NULL,
	[environment_scope] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[validate_type] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[folder_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[project_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[project_lsn] [bigint] NULL,
	[use32bitruntime] [bit] NULL,
	[reference_id] [bigint] NULL,
 CONSTRAINT [PK_Validations] PRIMARY KEY CLUSTERED 
(
	[validation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [internal].[validations]  WITH CHECK ADD  CONSTRAINT [FK_Validations_ValidationId_Operations] FOREIGN KEY([validation_id])
REFERENCES [internal].[operations] ([operation_id])
ON DELETE CASCADE
ALTER TABLE [internal].[validations] CHECK CONSTRAINT [FK_Validations_ValidationId_Operations]
GO
