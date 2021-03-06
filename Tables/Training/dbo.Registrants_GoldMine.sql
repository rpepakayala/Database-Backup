/****** Object:  Table [dbo].[Registrants_GoldMine]    Script Date: 5/15/2018 12:07:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Registrants_GoldMine](
	[RegistrantID] [int] NOT NULL,
 CONSTRAINT [PK_Registrants_GoldMine] PRIMARY KEY CLUSTERED 
(
	[RegistrantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Registrants_GoldMine]  WITH NOCHECK ADD  CONSTRAINT [FK_Registrants_GoldMine_Registrants] FOREIGN KEY([RegistrantID])
REFERENCES [dbo].[Registrants] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[Registrants_GoldMine] CHECK CONSTRAINT [FK_Registrants_GoldMine_Registrants]
GO
