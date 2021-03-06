/****** Object:  Table [dbo].[QualifierIncrementIDs]    Script Date: 5/15/2018 12:02:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[QualifierIncrementIDs](
	[SubsidyQualifierID] [int] NOT NULL,
 CONSTRAINT [PK_QualifierIncrementIDs] PRIMARY KEY CLUSTERED 
(
	[SubsidyQualifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
