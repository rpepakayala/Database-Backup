/****** Object:  Table [dbo].[user_types]    Script Date: 5/15/2018 12:04:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[user_types](
	[user_types_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_user_types_user_types_id] PRIMARY KEY CLUSTERED 
(
	[user_types_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[user_types] ADD  DEFAULT (NULL) FOR [name]
GO
