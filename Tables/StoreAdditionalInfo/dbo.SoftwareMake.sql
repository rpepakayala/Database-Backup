/****** Object:  Table [dbo].[SoftwareMake]    Script Date: 5/15/2018 12:06:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SoftwareMake](
	[VendorName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SoftwareMake_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SoftwareMake_Id] PRIMARY KEY CLUSTERED 
(
	[SoftwareMake_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
