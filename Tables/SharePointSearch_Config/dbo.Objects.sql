/****** Object:  Table [dbo].[Objects]    Script Date: 5/15/2018 12:06:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Objects](
	[Id] [uniqueidentifier] NOT NULL,
	[ClassId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Status] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_Objects] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Objects_Version]    Script Date: 5/15/2018 12:06:07 PM ******/
CREATE CLUSTERED INDEX [IX_Objects_Version] ON [dbo].[Objects]
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_Objects_ClassId_ParentId_Name]    Script Date: 5/15/2018 12:06:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Objects_ClassId_ParentId_Name] ON [dbo].[Objects]
(
	[ClassId] ASC,
	[ParentId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Objects]  WITH CHECK ADD  CONSTRAINT [FK_Objects_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
ALTER TABLE [dbo].[Objects] CHECK CONSTRAINT [FK_Objects_Classes]
ALTER TABLE [dbo].[Objects]  WITH CHECK ADD  CONSTRAINT [FK_Objects_Objects] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Objects] ([Id])
ALTER TABLE [dbo].[Objects] CHECK CONSTRAINT [FK_Objects_Objects]
/****** Object:  Trigger [dbo].[trigger_OnDeleteObjects]    Script Date: 5/15/2018 12:06:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_OnDeleteObjects ON Objects FOR DELETE
AS
    INSERT INTO
        Tombstones (Id)
    SELECT
        Id
    FROM
        Deleted   

/****** Object:  Trigger [dbo].[trigger_OnTouchObjects]    Script Date: 5/15/2018 12:06:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_OnTouchObjects ON Objects FOR DELETE, UPDATE, INSERT
AS
    UPDATE
        LastUpdate
    SET
        Value = 0
    WHERE
        Value = 0
    IF (@@ROWCOUNT < 1)
    BEGIN
        INSERT INTO LastUpdate (Value) VALUES(0)
    END

GO
