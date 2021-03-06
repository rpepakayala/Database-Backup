/****** Object:  Table [dbo].[INSLimits]    Script Date: 5/15/2018 12:06:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[INSLimits](
	[Insurance_Id] [bigint] NOT NULL,
	[Type] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Date] [datetime] NULL,
	[INSLimits_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_INSLimits_Id] PRIMARY KEY CLUSTERED 
(
	[INSLimits_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[INSLimits]  WITH CHECK ADD  CONSTRAINT [FK_INSLimits_Insurance] FOREIGN KEY([Insurance_Id])
REFERENCES [dbo].[Insurance] ([Insurance_Id])
ALTER TABLE [dbo].[INSLimits] CHECK CONSTRAINT [FK_INSLimits_Insurance]
GO
