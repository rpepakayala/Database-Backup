/****** Object:  Table [dbo].[sysssispackages]    Script Date: 5/15/2018 12:03:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysssispackages](
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[createdate] [datetime] NOT NULL,
	[folderid] [uniqueidentifier] NOT NULL,
	[ownersid] [varbinary](85) NOT NULL,
	[packagedata] [image] NOT NULL,
	[packageformat] [int] NOT NULL,
	[packagetype] [int] NOT NULL,
	[vermajor] [int] NOT NULL,
	[verminor] [int] NOT NULL,
	[verbuild] [int] NOT NULL,
	[vercomments] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[verid] [uniqueidentifier] NOT NULL,
	[isencrypted] [bit] NOT NULL,
	[readrolesid] [varbinary](85) NULL,
	[writerolesid] [varbinary](85) NULL,
 CONSTRAINT [pk_sysssispackages] PRIMARY KEY NONCLUSTERED 
(
	[folderid] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysssispackages] ADD  CONSTRAINT [DF__sysssispackages]  DEFAULT ((0)) FOR [packagetype]
ALTER TABLE [dbo].[sysssispackages] ADD  CONSTRAINT [DF__sysssispackages_2]  DEFAULT ((0)) FOR [isencrypted]
GO
