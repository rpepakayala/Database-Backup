/****** Object:  Table [dbo].[FC_Complaint]    Script Date: 5/15/2018 12:06:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Complaint](
	[referenceId] [bigint] NULL,
	[fimDdComplaintDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtComplaint] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbComplaintType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdIncidentDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaSummary] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaActionTaken] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtComplaintBy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbOtherComplaintType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimComplaint0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_typeOfComment2033434397] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_received1939496283] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_action1074965057] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_followUp1835329322] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
