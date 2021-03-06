/****** Object:  Table [dbo].[ar_ArtRevisionComments]    Script Date: 5/15/2018 12:02:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ar_ArtRevisionComments](
	[TransactionID] [int] NOT NULL,
	[Comment] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InputDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ar_ArtRevisionComments] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
