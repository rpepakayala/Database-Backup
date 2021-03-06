/****** Object:  Table [dbo].[Job]    Script Date: 5/15/2018 12:09:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Job](
	[JobId] [bigint] IDENTITY(1,1) NOT NULL,
	[PGUID] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvoiceNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CustomerNotification] [bit] NULL,
	[JobDescription] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailSubject] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailSignature] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CenterSettingId] [bigint] NOT NULL,
	[JobStateId] [bigint] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Company] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShowWatermark] [bit] NOT NULL,
	[ContactEmail] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShowAvancedVersion] [bit] NOT NULL,
	[SendEmailForEveryProof] [bit] NOT NULL,
 CONSTRAINT [PK_ProofGroup_Id] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_Job_33_2132202646__K12_K1_K13_K4_2_3_6_15_2533]    Script Date: 5/15/2018 12:09:01 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Job_33_2132202646__K12_K1_K13_K4_2_3_6_15_2533] ON [dbo].[Job]
(
	[CenterSettingId] ASC,
	[JobId] ASC,
	[JobStateId] ASC,
	[LastUpdated] ASC
)
INCLUDE ( 	[PGUID],
	[DateCreated],
	[InvoiceNumber],
	[Company]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_CenterSettingId_inc_JobId_InvoiceNumber_Company]    Script Date: 5/15/2018 12:09:01 PM ******/
CREATE NONCLUSTERED INDEX [Hint_CenterSettingId_inc_JobId_InvoiceNumber_Company] ON [dbo].[Job]
(
	[CenterSettingId] ASC
)
INCLUDE ( 	[JobId],
	[InvoiceNumber],
	[Company]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_JobStateId_inc_Large]    Script Date: 5/15/2018 12:09:01 PM ******/
CREATE NONCLUSTERED INDEX [Hint_JobStateId_inc_Large] ON [dbo].[Job]
(
	[JobStateId] ASC
)
INCLUDE ( 	[JobId],
	[PGUID],
	[DateCreated],
	[LastUpdated],
	[InvoiceNumber],
	[CenterSettingId],
	[Company]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [UI_Jobs_PGuid]    Script Date: 5/15/2018 12:09:01 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UI_Jobs_PGuid] ON [dbo].[Job]
(
	[PGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_ProofGroup_PGUID]  DEFAULT (newid()) FOR [PGUID]
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_ShowWatermark]  DEFAULT ((0)) FOR [ShowWatermark]
ALTER TABLE [dbo].[Job] ADD  CONSTRAINT [DF_Job_ShowAdvancedVersion]  DEFAULT ((1)) FOR [ShowAvancedVersion]
ALTER TABLE [dbo].[Job] ADD  DEFAULT ('0') FOR [SendEmailForEveryProof]
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_JobState] FOREIGN KEY([JobStateId])
REFERENCES [dbo].[JobState] ([JobStateId])
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_JobState]
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_ProofGroup_FastsignsCenter] FOREIGN KEY([CenterSettingId])
REFERENCES [dbo].[CenterSetting] ([CenterSettingId])
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_ProofGroup_FastsignsCenter]
GO
