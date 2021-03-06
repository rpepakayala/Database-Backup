/****** Object:  Table [Exceptions].[CustomerIndustry]    Script Date: 5/15/2018 11:59:55 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Exceptions].[CustomerIndustry](
	[CountryCode] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryTypeID] [int] NULL,
	[IndustryType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InsertDate] [datetime] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_CustomerIndustry]    Script Date: 5/15/2018 11:59:55 AM ******/
CREATE CLUSTERED INDEX [IX_CustomerIndustry] ON [Exceptions].[CustomerIndustry]
(
	[IndustryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [Exceptions].[CustomerIndustry] ADD  CONSTRAINT [DF_CustomerIndustry_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
