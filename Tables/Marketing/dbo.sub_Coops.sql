/****** Object:  Table [dbo].[sub_Coops]    Script Date: 5/15/2018 12:02:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sub_Coops](
	[CoopID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CountryID] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_sub_CoOps] PRIMARY KEY CLUSTERED 
(
	[CoopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
