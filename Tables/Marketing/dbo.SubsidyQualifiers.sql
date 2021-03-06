/****** Object:  Table [dbo].[SubsidyQualifiers]    Script Date: 5/15/2018 12:02:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SubsidyQualifiers](
	[SubsidyQualifierID] [int] IDENTITY(1,1) NOT NULL,
	[SubDID] [int] NULL,
	[QualifierName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_SubsidyGroups] PRIMARY KEY CLUSTERED 
(
	[SubsidyQualifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
