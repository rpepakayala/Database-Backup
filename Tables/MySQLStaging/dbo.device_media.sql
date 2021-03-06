/****** Object:  Table [dbo].[device_media]    Script Date: 5/15/2018 12:04:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[device_media](
	[device_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[material_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_device_media_device_id] PRIMARY KEY CLUSTERED 
(
	[device_id] ASC,
	[material_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
