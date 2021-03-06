/****** Object:  Table [dbo].[ELearningCategory]    Script Date: 5/15/2018 12:07:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ELearningCategory](
	[ELearningCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ELearningDepartmentID] [int] NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_ELearningCategory] PRIMARY KEY CLUSTERED 
(
	[ELearningCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ELearningCategory] ADD  DEFAULT ((1)) FOR [ELearningDepartmentID]
ALTER TABLE [dbo].[ELearningCategory] ADD  CONSTRAINT [DF_ELearningCategory_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
ALTER TABLE [dbo].[ELearningCategory]  WITH CHECK ADD  CONSTRAINT [FK_ELearningCategory_ELearningDepartment] FOREIGN KEY([ELearningDepartmentID])
REFERENCES [dbo].[ELearningDepartment] ([ELearningDepartmentID])
ALTER TABLE [dbo].[ELearningCategory] CHECK CONSTRAINT [FK_ELearningCategory_ELearningDepartment]
GO
