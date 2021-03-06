/****** Object:  Table [dbo].[entity_types]    Script Date: 5/15/2018 12:04:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[entity_types](
	[entity_type_id] [int] IDENTITY(6,1) NOT NULL,
	[name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_entity_types_entity_type_id] PRIMARY KEY CLUSTERED 
(
	[entity_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
