/****** Object:  Table [dbo].[ContentTypes]    Script Date: 5/15/2018 12:05:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ContentTypes](
	[SiteId] [uniqueidentifier] NOT NULL,
	[Class] [tinyint] NOT NULL,
	[Scope] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ContentTypeId] [dbo].[tContentTypeId] NOT NULL,
	[Version] [int] NOT NULL,
	[NextChildByte] [tinyint] NOT NULL,
	[Size] [int] NOT NULL,
	[Definition] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ResourceDir] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[IsFromFeature] [bit] NOT NULL,
 CONSTRAINT [ContentType_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[Class] ASC,
	[Scope] ASC,
	[ContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[ContentTypes] ADD  DEFAULT ((16)) FOR [Size]
ALTER TABLE [dbo].[ContentTypes] ADD  DEFAULT ((0)) FOR [IsFromFeature]
/****** Object:  Trigger [dbo].[trigger_OnDeleteContentTypes]    Script Date: 5/15/2018 12:05:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_OnDeleteContentTypes ON ContentTypes AFTER DELETE
AS
    DECLARE @siteId uniqueidentifier
    DECLARE @cbDelta bigint
    DECLARE @cSave int
    SELECT
        @SiteId = SiteId,
        @cbDelta = -(ISNULL((SUM(CAST((Size) AS BIGINT))),0))
    FROM
        Deleted
    GROUP BY
        SiteId
    SET @cSave = @@ROWCOUNT
    IF (1 = @cSave)
    BEGIN
        EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 0
    END

GO
