/****** Object:  Table [dbo].[ProofHistory]    Script Date: 5/15/2018 12:09:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProofHistory](
	[ProofHistoryId] [bigint] IDENTITY(1,1) NOT NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignImage] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignImageWatermark] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignImageThumb] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignType] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignHeight] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignWidth] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Annotations] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Comment] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProofId] [bigint] NOT NULL,
	[ProofStateId] [bigint] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[Estimate] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quantity] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[JobState] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_ProofVersion_Id] PRIMARY KEY CLUSTERED 
(
	[ProofHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_ProofHistory_58_752721734__K12_K1_2_3_4_5_6_7_8_9_10_11_13_14_15_16_17]    Script Date: 5/15/2018 12:09:02 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_ProofHistory_58_752721734__K12_K1_2_3_4_5_6_7_8_9_10_11_13_14_15_16_17] ON [dbo].[ProofHistory]
(
	[ProofId] ASC,
	[ProofHistoryId] ASC
)
INCLUDE ( 	[DateModified],
	[ModifiedBy],
	[SignImage],
	[SignImageWatermark],
	[SignImageThumb],
	[SignType],
	[SignHeight],
	[SignWidth],
	[Annotations],
	[Comment],
	[ProofStateId],
	[RowVersion],
	[Estimate],
	[Quantity],
	[JobState]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[ProofHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProofHistory_Proof] FOREIGN KEY([ProofId])
REFERENCES [dbo].[Proof] ([ProofId])
ALTER TABLE [dbo].[ProofHistory] CHECK CONSTRAINT [FK_ProofHistory_Proof]
ALTER TABLE [dbo].[ProofHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProofHistory_ProofState] FOREIGN KEY([ProofStateId])
REFERENCES [dbo].[ProofState] ([ProofStateId])
ALTER TABLE [dbo].[ProofHistory] CHECK CONSTRAINT [FK_ProofHistory_ProofState]
GO
