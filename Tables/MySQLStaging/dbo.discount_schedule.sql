/****** Object:  Table [dbo].[discount_schedule]    Script Date: 5/15/2018 12:04:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[discount_schedule](
	[discount_schedule_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discount_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[min_tier] [int] NOT NULL,
	[max_tier] [int] NOT NULL,
	[value] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_discount_schedule_discount_schedule_id] PRIMARY KEY CLUSTERED 
(
	[discount_schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [discount_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [discount_id] ON [dbo].[discount_schedule]
(
	[discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
