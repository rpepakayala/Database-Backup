/****** Object:  Table [Exceptions].[CustomerOrigin]    Script Date: 5/15/2018 11:59:55 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Exceptions].[CustomerOrigin](
	[CustomerType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InsertDate] [datetime] NULL
) ON [PRIMARY]

ALTER TABLE [Exceptions].[CustomerOrigin] ADD  CONSTRAINT [DF_CustomerOrigin_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
