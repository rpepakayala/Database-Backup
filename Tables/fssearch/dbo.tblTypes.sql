/****** Object:  Table [dbo].[tblTypes]    Script Date: 5/15/2018 12:01:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[tblTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[vcTypeName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[vcTypeLocation] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vcImageLocation] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_DigitalAssets.tblTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
