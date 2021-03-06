/****** Object:  Table [dbo].[Sub_TransactionStoreDetails]    Script Date: 5/15/2018 12:02:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sub_TransactionStoreDetails](
	[TransactionID] [int] NOT NULL,
	[WebNumber] [int] NOT NULL,
 CONSTRAINT [PK_Sub_StoresInTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC,
	[WebNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
