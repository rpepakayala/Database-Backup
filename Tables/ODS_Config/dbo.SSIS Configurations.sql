/****** Object:  Table [dbo].[SSIS Configurations]    Script Date: 5/15/2018 12:04:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SSIS Configurations](
	[ConfigurationFilter] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ConfiguredValue] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackagePath] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ConfiguredValueType] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
