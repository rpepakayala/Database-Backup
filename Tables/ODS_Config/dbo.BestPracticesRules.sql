/****** Object:  Table [dbo].[BestPracticesRules]    Script Date: 5/15/2018 12:04:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[BestPracticesRules](
	[RuleId] [uniqueidentifier] NOT NULL,
	[RuleName] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ViolationMessage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Recommendation] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RuleSeverity] [int] NOT NULL,
	[ReferenceUri] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[PathEvaluator] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Author] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateCreated] [datetime] NOT NULL,
	[AppliesTo] [uniqueidentifier] NULL,
	[ObjectTypeFilters] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PropertyNameFilters] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__BestPrac__110458E2D16F7981] PRIMARY KEY CLUSTERED 
(
	[RuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[BestPracticesRules] ADD  CONSTRAINT [DF__BestPract__IsEna__571DF1D5]  DEFAULT ((1)) FOR [IsEnabled]
ALTER TABLE [dbo].[BestPracticesRules] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
