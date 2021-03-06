/****** Object:  Table [dbo].[xf_language]    Script Date: 5/15/2018 12:00:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_language](
	[language_id] [bigint] IDENTITY(2,1) NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[parent_list] [varbinary](100) NOT NULL,
	[title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[date_format] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[time_format] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[decimal_point] [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[thousands_separator] [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[phrase_cache] [varbinary](max) NOT NULL,
	[language_code] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[text_direction] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_language_language_id] PRIMARY KEY CLUSTERED 
(
	[language_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_language] ADD  DEFAULT (N'') FOR [language_code]
ALTER TABLE [dbo].[xf_language] ADD  DEFAULT (N'LTR') FOR [text_direction]
GO
