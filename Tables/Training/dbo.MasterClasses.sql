/****** Object:  Table [dbo].[MasterClasses]    Script Date: 5/15/2018 12:07:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MasterClasses](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Title] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Audience] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaxStudents] [int] NULL,
	[Duration] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Cost] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Objectives] [varchar](3000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Prerequisites] [varchar](3500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClassType] [int] NULL,
	[Agenda] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PreRequisite] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[ClassProvider] [int] NULL,
	[CancellationPolicy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AllowTradeOut] [bit] NOT NULL,
	[NoShowFee] [money] NOT NULL,
 CONSTRAINT [PK_MasterClasses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MasterClasses] ADD  CONSTRAINT [DF_MasterClasses_IsActive]  DEFAULT ((1)) FOR [IsActive]
ALTER TABLE [dbo].[MasterClasses] ADD  CONSTRAINT [DF_MasterClasses_CancellationPolicy]  DEFAULT ('24 hours') FOR [CancellationPolicy]
ALTER TABLE [dbo].[MasterClasses] ADD  CONSTRAINT [DF__MasterCla__Allow__7F80E8EA]  DEFAULT ('1') FOR [AllowTradeOut]
ALTER TABLE [dbo].[MasterClasses] ADD  CONSTRAINT [DF__MasterCla__NoSho__00750D23]  DEFAULT ((200)) FOR [NoShowFee]
ALTER TABLE [dbo].[MasterClasses]  WITH CHECK ADD  CONSTRAINT [FK_MasterClasses_ClassTypes] FOREIGN KEY([ClassType])
REFERENCES [dbo].[ClassTypes] ([ID])
ON UPDATE CASCADE
ALTER TABLE [dbo].[MasterClasses] CHECK CONSTRAINT [FK_MasterClasses_ClassTypes]
GO
