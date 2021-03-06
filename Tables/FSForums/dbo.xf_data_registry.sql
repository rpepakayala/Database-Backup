/****** Object:  Table [dbo].[xf_data_registry]    Script Date: 5/15/2018 12:00:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_data_registry](
	[data_key] [varbinary](25) NOT NULL,
	[data_value] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_data_registry_data_key] PRIMARY KEY CLUSTERED 
(
	[data_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
