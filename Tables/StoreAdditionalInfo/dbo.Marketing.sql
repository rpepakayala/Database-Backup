/****** Object:  Table [dbo].[Marketing]    Script Date: 5/15/2018 12:06:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Marketing](
	[MediaRemaining] [int] NULL,
	[MediaGranted] [int] NULL,
	[MktgCatalog] [int] NULL,
	[MktgCountry] [int] NULL,
	[TSGranted] [int] NULL,
	[TSRemaining] [int] NULL,
	[YP_Pub_Date] [datetime] NULL,
	[Marketing_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Marketing_Id] PRIMARY KEY CLUSTERED 
(
	[Marketing_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
