/****** Object:  Table [dbo].[Sub_Providers]    Script Date: 5/15/2018 12:02:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sub_Providers](
	[ProviderID] [int] NOT NULL,
	[Name] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProviderEnum] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_sub_providers] PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
