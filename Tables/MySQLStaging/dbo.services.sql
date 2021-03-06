/****** Object:  Table [dbo].[services]    Script Date: 5/15/2018 12:04:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[services](
	[service_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[service_category_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[code] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[price] [decimal](8, 2) NULL,
	[taxable] [smallint] NOT NULL,
	[active] [smallint] NOT NULL,
	[duration] [bigint] NULL,
	[corporate_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[revenue_location_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[royalty_exempt] [smallint] NULL,
	[tax_code_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_services_service_id] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [services$franchise_id] UNIQUE NONCLUSTERED 
(
	[franchise_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [clinic_id]    Script Date: 5/15/2018 12:04:30 PM ******/
CREATE NONCLUSTERED INDEX [clinic_id] ON [dbo].[services]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [corporate_id]    Script Date: 5/15/2018 12:04:30 PM ******/
CREATE NONCLUSTERED INDEX [corporate_id] ON [dbo].[services]
(
	[corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [revenue_location_id]    Script Date: 5/15/2018 12:04:30 PM ******/
CREATE NONCLUSTERED INDEX [revenue_location_id] ON [dbo].[services]
(
	[revenue_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [service_category_id]    Script Date: 5/15/2018 12:04:30 PM ******/
CREATE NONCLUSTERED INDEX [service_category_id] ON [dbo].[services]
(
	[service_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[services] ADD  DEFAULT (N'0') FOR [franchise_id]
ALTER TABLE [dbo].[services] ADD  DEFAULT (NULL) FOR [service_category_id]
ALTER TABLE [dbo].[services] ADD  DEFAULT (NULL) FOR [code]
ALTER TABLE [dbo].[services] ADD  DEFAULT (N'') FOR [name]
ALTER TABLE [dbo].[services] ADD  DEFAULT (NULL) FOR [price]
ALTER TABLE [dbo].[services] ADD  DEFAULT ((0)) FOR [taxable]
ALTER TABLE [dbo].[services] ADD  DEFAULT ((1)) FOR [active]
ALTER TABLE [dbo].[services] ADD  DEFAULT (NULL) FOR [duration]
ALTER TABLE [dbo].[services] ADD  DEFAULT (NULL) FOR [corporate_id]
ALTER TABLE [dbo].[services] ADD  DEFAULT (N'e623b73a301bd9a98e108a63e385c990') FOR [revenue_location_id]
ALTER TABLE [dbo].[services] ADD  DEFAULT ((0)) FOR [royalty_exempt]
ALTER TABLE [dbo].[services] ADD  DEFAULT (N'1') FOR [tax_code_id]
GO
