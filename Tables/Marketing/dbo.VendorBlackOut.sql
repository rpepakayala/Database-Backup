/****** Object:  Table [dbo].[VendorBlackOut]    Script Date: 5/15/2018 12:02:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[VendorBlackOut](
	[VendorId] [int] NOT NULL,
	[VboMonth] [tinyint] NOT NULL,
	[VboDay] [tinyint] NOT NULL,
	[VboDisabled] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_VendorBlackOut] PRIMARY KEY CLUSTERED 
(
	[VendorId] ASC,
	[VboMonth] ASC,
	[VboDay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
