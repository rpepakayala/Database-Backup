/****** Object:  Table [dbo].[sf_prs_criterion]    Script Date: 5/15/2018 12:01:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_prs_criterion](
	[sf_prs_criterion_id] [int] NOT NULL,
	[is_negated] [tinyint] NOT NULL,
	[criterion_value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[criterion_title] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[criterion_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[criterion_display_value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_prs_criterion] PRIMARY KEY CLUSTERED 
(
	[sf_prs_criterion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
