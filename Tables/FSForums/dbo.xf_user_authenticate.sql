/****** Object:  Table [dbo].[xf_user_authenticate]    Script Date: 5/15/2018 12:00:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_authenticate](
	[user_id] [bigint] NOT NULL,
	[scheme_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[data] [varbinary](max) NOT NULL,
	[remember_key] [varbinary](40) NOT NULL,
 CONSTRAINT [PK_xf_user_authenticate_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
