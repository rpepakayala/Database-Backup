/****** Object:  Table [Store].[FastMailDim]    Script Date: 5/15/2018 11:59:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[FastMailDim](
	[CenterKey] [int] NOT NULL,
	[IS_OYB] [bit] NULL,
	[IsModified] [bit] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[ET_BUID] [int] NOT NULL,
	[ET_UserID] [int] NOT NULL,
	[FastMailGroupId] [int] NULL,
 CONSTRAINT [PK_CenmterKey] PRIMARY KEY CLUSTERED 
(
	[CenterKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Store].[FastMailDim] ADD  CONSTRAINT [DF_LastUpdated]  DEFAULT (getdate()) FOR [LastUpdated]
ALTER TABLE [Store].[FastMailDim] ADD  DEFAULT ((0)) FOR [ET_BUID]
ALTER TABLE [Store].[FastMailDim] ADD  DEFAULT ((0)) FOR [ET_UserID]
ALTER TABLE [Store].[FastMailDim]  WITH CHECK ADD  CONSTRAINT [FK_FastMailDim_StoreFact] FOREIGN KEY([CenterKey])
REFERENCES [Store].[StoreFact] ([CenterKey])
ALTER TABLE [Store].[FastMailDim] CHECK CONSTRAINT [FK_FastMailDim_StoreFact]
/****** Object:  Trigger [Store].[FastMailDim_Update]    Script Date: 5/15/2018 11:59:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [Store].[FastMailDim_Update]
  ON [Store].[FastMailDim] 
FOR INSERT,UPDATE
AS 
BEGIN
UPDATE Store.FastMailDim SET Store.FastMailDim.LastUpdated = GETDATE()
  FROM INSERTED
  WHERE INSERTED.Centerkey = Store.FastMailDim.CenterKey

END

GO
