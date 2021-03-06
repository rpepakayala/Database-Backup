/****** Object:  Table [dbo].[audit_collection_notes]    Script Date: 5/15/2018 12:00:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[audit_collection_notes](
	[ZW_Franchise_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Notes] [varchar](1023) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AsOfDate] [smalldatetime] NULL,
 CONSTRAINT [PK_audit_collection_notes] PRIMARY KEY CLUSTERED 
(
	[ZW_Franchise_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
