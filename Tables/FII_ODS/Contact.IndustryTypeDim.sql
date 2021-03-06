/****** Object:  Table [Contact].[IndustryTypeDim]    Script Date: 5/15/2018 11:59:23 AM ******/
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

SET ANSI_PADDING ON

/****** Object:  Index [IndustryTypeDim_IndustryTypeName]    Script Date: 5/15/2018 11:59:23 AM ******/
CREATE NONCLUSTERED INDEX [IndustryTypeDim_IndustryTypeName] ON [Contact].[IndustryTypeDim]
(
	[IndustryTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Contact].[IndustryTypeDim] ADD  CONSTRAINT [DF_IndustryType_IsValid]  DEFAULT ((0)) FOR [IsValid]
ALTER TABLE [Contact].[IndustryTypeDim] ADD  CONSTRAINT [DF_IndustryTypeDim_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
