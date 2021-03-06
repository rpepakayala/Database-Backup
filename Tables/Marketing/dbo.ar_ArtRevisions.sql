/****** Object:  Table [dbo].[ar_ArtRevisions]    Script Date: 5/15/2018 12:02:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ar_ArtRevisions](
	[WebNumber] [int] NOT NULL,
	[ArtTypeID] [int] NOT NULL,
	[ArtRevisionStatusID] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[TransactionID] [int] NULL,
 CONSTRAINT [PK_ar_ArtRevisions] PRIMARY KEY CLUSTERED 
(
	[WebNumber] ASC,
	[ArtTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
