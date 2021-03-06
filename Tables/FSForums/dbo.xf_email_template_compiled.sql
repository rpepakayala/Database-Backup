/****** Object:  Table [dbo].[xf_email_template_compiled]    Script Date: 5/15/2018 12:00:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_email_template_compiled](
	[language_id] [bigint] NOT NULL,
	[title] [varbinary](50) NOT NULL,
	[template_compiled] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_email_template_compiled_title] PRIMARY KEY CLUSTERED 
(
	[title] ASC,
	[language_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
