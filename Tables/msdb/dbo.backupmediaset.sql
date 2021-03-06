/****** Object:  Table [dbo].[backupmediaset]    Script Date: 5/15/2018 12:02:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[backupmediaset](
	[media_set_id] [int] IDENTITY(1,1) NOT NULL,
	[media_uuid] [uniqueidentifier] NULL,
	[media_family_count] [tinyint] NULL,
	[name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[software_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[software_vendor_id] [int] NULL,
	[MTF_major_version] [tinyint] NULL,
	[mirror_count] [tinyint] NULL,
	[is_password_protected] [bit] NULL,
	[is_compressed] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[media_set_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [backupmediasetuuid]    Script Date: 5/15/2018 12:02:53 PM ******/
CREATE NONCLUSTERED INDEX [backupmediasetuuid] ON [dbo].[backupmediaset]
(
	[media_uuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
