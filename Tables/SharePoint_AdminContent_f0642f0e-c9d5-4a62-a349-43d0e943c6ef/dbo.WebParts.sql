/****** Object:  Table [dbo].[WebParts]    Script Date: 5/15/2018 12:06:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[WebParts](
	[tp_SiteId] [uniqueidentifier] NOT NULL,
	[tp_ID] [uniqueidentifier] NOT NULL,
	[tp_ListId] [uniqueidentifier] NULL,
	[tp_Type] [tinyint] NULL,
	[tp_Flags] [int] NULL,
	[tp_BaseViewID] [tinyint] NULL,
	[tp_DisplayName] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_Version] [int] NULL,
	[tp_PageUrlID] [uniqueidentifier] NOT NULL,
	[tp_PartOrder] [int] NULL,
	[tp_ZoneID] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_IsIncluded] [bit] NOT NULL,
	[tp_FrameState] [tinyint] NOT NULL,
	[tp_View] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_WebPartTypeId] [uniqueidentifier] NULL,
	[tp_AllUsersProperties] [image] NULL,
	[tp_PerUserProperties] [image] NULL,
	[tp_Cache] [image] NULL,
	[tp_UserID] [int] NULL,
	[tp_Source] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[tp_CreationTime] [datetime] NOT NULL,
	[tp_Size] [bigint] NOT NULL,
	[tp_Level] [tinyint] NOT NULL,
	[tp_Deleted] [bit] NOT NULL,
	[tp_HasFGP] [bit] NOT NULL,
	[tp_ContentTypeId] [dbo].[tContentTypeId] NOT NULL,
 CONSTRAINT [WebParts_PK] PRIMARY KEY NONCLUSTERED 
(
	[tp_SiteId] ASC,
	[tp_ID] ASC,
	[tp_Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [PageUrlID_FK]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE CLUSTERED INDEX [PageUrlID_FK] ON [dbo].[WebParts]
(
	[tp_SiteId] ASC,
	[tp_PageUrlID] ASC,
	[tp_Level] ASC,
	[tp_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [ListId_FK]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [ListId_FK] ON [dbo].[WebParts]
(
	[tp_ListId] ASC,
	[tp_UserID] ASC,
	[tp_Type] ASC,
	[tp_CreationTime] ASC,
	[tp_ID] ASC,
	[tp_Level] ASC,
	[tp_Flags] ASC,
	[tp_DisplayName] ASC,
	[tp_BaseViewID] ASC,
	[tp_ContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [WebParts_UserID]    Script Date: 5/15/2018 12:06:03 PM ******/
CREATE NONCLUSTERED INDEX [WebParts_UserID] ON [dbo].[WebParts]
(
	[tp_SiteId] ASC,
	[tp_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT ((1)) FOR [tp_IsIncluded]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT ((0)) FOR [tp_FrameState]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT (getutcdate()) FOR [tp_CreationTime]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT ((1)) FOR [tp_Level]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT ((0)) FOR [tp_Deleted]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT ((0)) FOR [tp_HasFGP]
ALTER TABLE [dbo].[WebParts] ADD  DEFAULT (0x) FOR [tp_ContentTypeId]
/****** Object:  Trigger [dbo].[trigger_OnDeleteWebParts]    Script Date: 5/15/2018 12:06:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_OnDeleteWebParts ON WebParts AFTER DELETE
As
    DECLARE @siteId uniqueidentifier
    DECLARE @cbDelta bigint
    DECLARE @cSave int
    SELECT
        @SiteId = tp_SiteId,
        @cbDelta = -(SUM(CAST((ISNULL(tp_Size, 0)) AS BIGINT)))
    FROM
        Deleted
    WHERE
        tp_Deleted = 0
    GROUP BY
        tp_SiteId
    SET @cSave = @@ROWCOUNT
    IF (1 = @cSave)
    BEGIN
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    END
    DELETE Personalization
    FROM
       Personalization
    JOIN
       Deleted
    On
       Personalization.tp_SiteId = Deleted.tp_SiteId AND
       Personalization.tp_WebPartID = Deleted.tp_ID AND
       (Deleted.tp_Level = 1 OR
       Deleted.tp_Level = 2 OR
       Deleted.tp_Level = 255 AND
       NOT EXISTS(
           SELECT
               *
           FROM
               WebParts
           WHERE
               tp_SiteId = Deleted.tp_SiteId AND
               tp_PageUrlID = Deleted.tp_PageUrlID AND
               tp_ID = Deleted.tp_ID AND              
               tp_Level <> 255))

GO
