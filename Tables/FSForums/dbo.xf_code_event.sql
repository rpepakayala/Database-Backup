/****** Object:  Table [dbo].[xf_code_event]    Script Date: 5/15/2018 12:00:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_code_event](
	[event_id] [varbinary](50) NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_code_event_event_id] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_code_event] ADD  DEFAULT (0x) FOR [addon_id]
GO
