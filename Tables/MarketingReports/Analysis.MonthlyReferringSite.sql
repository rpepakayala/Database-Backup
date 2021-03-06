/****** Object:  Table [Analysis].[MonthlyReferringSite]    Script Date: 5/15/2018 12:02:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[MonthlyReferringSite](
	[Webnumber] [int] NOT NULL,
	[Month] [datetime] NOT NULL,
	[ReferringSites] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_ReferringSite]    Script Date: 5/15/2018 12:02:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReferringSite] ON [Analysis].[MonthlyReferringSite]
(
	[Webnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_ReferringSite_1]    Script Date: 5/15/2018 12:02:47 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReferringSite_1] ON [Analysis].[MonthlyReferringSite]
(
	[Month] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
