/****** Object:  Table [dbo].[AvailableDestinations]    Script Date: 5/15/2018 12:00:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AvailableDestinations](
	[concept_id] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[destination_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[num_consolidators] [tinyint] NULL,
	[approx_message_count] [int] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_AvailableDestinations_concept]    Script Date: 5/15/2018 12:00:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_AvailableDestinations_concept] ON [dbo].[AvailableDestinations]
(
	[concept_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
