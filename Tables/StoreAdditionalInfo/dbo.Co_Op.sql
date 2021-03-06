/****** Object:  Table [dbo].[Co_Op]    Script Date: 5/15/2018 12:06:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Co_Op](
	[CoOpInfo] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Date] [datetime] NULL,
	[DMA] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Term] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Co_Op_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Co_Op_Id] PRIMARY KEY CLUSTERED 
(
	[Co_Op_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
