/****** Object:  Table [Contact].[IndustryTypeDim]    Script Date: 5/15/2018 12:02:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[IndustryTypeDim](
	[IndustryTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[IndustryTypeName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
	[SIC] [int] NULL,
	[CleanedIndustry] [varchar](186) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateCreated] [smalldatetime] NULL,
 CONSTRAINT [PK_IndustryTypeKey] PRIMARY KEY CLUSTERED 
(
	[IndustryTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
