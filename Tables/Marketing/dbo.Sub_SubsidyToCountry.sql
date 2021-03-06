/****** Object:  Table [dbo].[Sub_SubsidyToCountry]    Script Date: 5/15/2018 12:02:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sub_SubsidyToCountry](
	[SubsidyID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
 CONSTRAINT [PK_Sub_SubsidyToCountry] PRIMARY KEY CLUSTERED 
(
	[SubsidyID] ASC,
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
