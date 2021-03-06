/****** Object:  Table [dbo].[syspolicy_management_facets]    Script Date: 5/15/2018 12:03:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_management_facets](
	[management_facet_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[execution_mode] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[management_facet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
