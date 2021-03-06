/****** Object:  Table [dbo].[MIPTombstones]    Script Date: 5/15/2018 12:05:10 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MIPTombstones](
	[ObjectId] [uniqueidentifier] NOT NULL,
	[Version] [bigint] NOT NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_MIPTombstones] PRIMARY KEY NONCLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
