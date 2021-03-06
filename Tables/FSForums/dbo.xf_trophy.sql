/****** Object:  Table [dbo].[xf_trophy]    Script Date: 5/15/2018 12:00:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_trophy](
	[trophy_id] [bigint] IDENTITY(10,1) NOT NULL,
	[trophy_points] [bigint] NOT NULL,
	[user_criteria] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_trophy_trophy_id] PRIMARY KEY CLUSTERED 
(
	[trophy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
