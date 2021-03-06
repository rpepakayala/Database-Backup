/****** Object:  Table [dbo].[UpdatePickedUPandClosed]    Script Date: 5/15/2018 11:59:28 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[UpdatePickedUPandClosed](
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrderID] [int] NULL,
	[DatePickedUpUsingGL] [date] NULL,
	[GLClosedDate] [date] NULL,
	[OrderDate] [datetime] NULL,
	[DispositionOnCompletion] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PickedUpDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL
) ON [PRIMARY]

GO
