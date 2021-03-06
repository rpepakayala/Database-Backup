/****** Object:  Table [dbo].[sub_Subsidies]    Script Date: 5/15/2018 12:02:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sub_Subsidies](
	[SubsidyID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[PercentageMatched] [int] NOT NULL,
	[BaseAmount] [money] NOT NULL,
	[Active] [bit] NOT NULL,
	[SubsidyTypeEnum] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_sub_Subsidies] PRIMARY KEY CLUSTERED 
(
	[SubsidyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
