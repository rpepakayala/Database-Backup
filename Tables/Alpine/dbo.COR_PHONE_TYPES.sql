/****** Object:  Table [dbo].[COR_PHONE_TYPES]    Script Date: 5/15/2018 11:58:36 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_PHONE_TYPES](
	[PhoneType] [bigint] NOT NULL,
	[FullName] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_COR_PHONE_TYPES] PRIMARY KEY CLUSTERED 
(
	[PhoneType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

GO
