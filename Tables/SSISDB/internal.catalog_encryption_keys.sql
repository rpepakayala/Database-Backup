/****** Object:  Table [internal].[catalog_encryption_keys]    Script Date: 5/15/2018 12:06:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[catalog_encryption_keys](
	[key_id] [bigint] IDENTITY(1,1) NOT NULL,
	[key_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[KEY] [varbinary](8000) NOT NULL,
	[IV] [varbinary](8000) NOT NULL,
 CONSTRAINT [PK_Encryption_Keys] PRIMARY KEY CLUSTERED 
(
	[key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
