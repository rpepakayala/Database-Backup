/****** Object:  Table [dbo].[backupfilegroup]    Script Date: 5/15/2018 12:02:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[backupfilegroup](
	[backup_set_id] [int] NOT NULL,
	[name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[filegroup_id] [int] NOT NULL,
	[filegroup_guid] [uniqueidentifier] NULL,
	[type] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[type_desc] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[is_default] [bit] NOT NULL,
	[is_readonly] [bit] NOT NULL,
	[log_filegroup_guid] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[backup_set_id] ASC,
	[filegroup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[backupfilegroup]  WITH CHECK ADD FOREIGN KEY([backup_set_id])
REFERENCES [dbo].[backupset] ([backup_set_id])
GO
