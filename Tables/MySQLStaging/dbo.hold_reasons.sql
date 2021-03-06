/****** Object:  Table [dbo].[hold_reasons]    Script Date: 5/15/2018 12:04:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[hold_reasons](
	[hold_reason_id] [int] NOT NULL,
	[reason] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_hold_reasons_hold_reason_id] PRIMARY KEY CLUSTERED 
(
	[hold_reason_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
