/****** Object:  Table [Contact].[CompanyNameDim]    Script Date: 5/15/2018 11:59:21 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[CompanyNameDim](
	[CompanyNameKey] [int] IDENTITY(1,1) NOT NULL,
	[CompanyNameName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_CompanyNameKey] PRIMARY KEY CLUSTERED 
(
	[CompanyNameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [CompanyNameDim_CompanyNameName]    Script Date: 5/15/2018 11:59:21 AM ******/
CREATE NONCLUSTERED INDEX [CompanyNameDim_CompanyNameName] ON [Contact].[CompanyNameDim]
(
	[CompanyNameName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Contact].[CompanyNameDim] ADD  CONSTRAINT [DF_CompanyName_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
