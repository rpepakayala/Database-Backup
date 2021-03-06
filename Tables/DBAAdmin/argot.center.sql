/****** Object:  Table [argot].[center]    Script Date: 5/15/2018 11:59:07 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [argot].[center](
	[center_id] [int] IDENTITY(1,1) NOT NULL,
	[center_number] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[region] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_center] PRIMARY KEY CLUSTERED 
(
	[center_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
