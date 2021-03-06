/****** Object:  Table [dbo].[sysmail_query_transfer]    Script Date: 5/15/2018 12:03:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmail_query_transfer](
	[uid] [uniqueidentifier] NOT NULL,
	[text_data] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[create_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysmail_query_transfer] ADD  DEFAULT (getdate()) FOR [create_date]
GO
