/****** Object:  Table [dbo].[FII_ESSO_ExternalApplications]    Script Date: 5/15/2018 12:00:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FII_ESSO_ExternalApplications](
	[ExternalAppID] [int] IDENTITY(1000001,1) NOT NULL,
	[ExternalAppName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalAppLoginURI] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalAppDescription] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalAppImageFile] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ControllerPage] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalAppWebsiteURI] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ExternalSites] PRIMARY KEY CLUSTERED 
(
	[ExternalAppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FII_ESSO_ExternalApplications] ADD  CONSTRAINT [DF_ExternalApplications_Active]  DEFAULT ((1)) FOR [Active]
ALTER TABLE [dbo].[FII_ESSO_ExternalApplications] ADD  CONSTRAINT [DF_ExternalApplications_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
ALTER TABLE [dbo].[FII_ESSO_ExternalApplications] ADD  CONSTRAINT [DF_ExternalApplications_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
