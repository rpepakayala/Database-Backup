/****** Object:  Table [dbo].[xf_template_compiled]    Script Date: 5/15/2018 12:00:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_template_compiled](
	[style_id] [bigint] NOT NULL,
	[language_id] [bigint] NOT NULL,
	[title] [varbinary](50) NOT NULL,
	[template_compiled] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_template_compiled_style_id] PRIMARY KEY CLUSTERED 
(
	[style_id] ASC,
	[language_id] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
