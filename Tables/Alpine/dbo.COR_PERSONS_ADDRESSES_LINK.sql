/****** Object:  Table [dbo].[COR_PERSONS_ADDRESSES_LINK]    Script Date: 5/15/2018 11:58:36 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_PERSONS_ADDRESSES_LINK](
	[PersonID] [bigint] NOT NULL,
	[AddressID] [bigint] NOT NULL,
 CONSTRAINT [PK_COR_PERSONS_ADDRESSES_LINK] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC,
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

GO
