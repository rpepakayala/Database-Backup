/****** Object:  Table [dbo].[SSISPackageAlertList]    Script Date: 5/15/2018 12:04:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SSISPackageAlertList](
	[AlertID] [int] NOT NULL,
	[AlertCode] [int] NULL,
	[CompareAction] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AlertKeywords] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AlertDescription] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FilterThisAlert] [bit] NOT NULL,
 CONSTRAINT [PK__SSISPack__EBB16AED25869641] PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
