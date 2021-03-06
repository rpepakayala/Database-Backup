/****** Object:  Table [dbo].[InstalledWebPartPackages]    Script Date: 5/15/2018 12:06:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InstalledWebPartPackages](
	[WPPId] [int] NOT NULL,
	[URL] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[IISInstance] [int] NOT NULL,
	[ServerId] [uniqueidentifier] NOT NULL,
	[GlobalInstall] [bit] NOT NULL,
 CONSTRAINT [InstalledWebPartPackages_PK] PRIMARY KEY CLUSTERED 
(
	[WPPId] ASC,
	[IISInstance] ASC,
	[ServerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
