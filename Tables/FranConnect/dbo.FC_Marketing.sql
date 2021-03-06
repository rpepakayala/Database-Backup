/****** Object:  Table [dbo].[FC_Marketing]    Script Date: 5/15/2018 12:00:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Marketing](
	[referenceId] [bigint] NULL,
	[fimCbtContactTitle] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtFirstName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtLastName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimMarketing0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrGrandOpeningRequired] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdGrandOpeningCompletedDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrCouponRedemption] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtCampaignName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrCampaignParticipation] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtProgramName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrProgramParticipation] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtDMA] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaComments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_facebook941966077] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_twitter187456584] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_instagram516488236] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_linkedin451624149] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_googlePlus45315589] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_pinterest310044604] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_snapchat1039865362] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_otherSocial961300600] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
