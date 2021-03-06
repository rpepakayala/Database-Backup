/****** Object:  Table [dbo].[AllDocVersions]    Script Date: 5/15/2018 12:05:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AllDocVersions](
	[SiteId] [uniqueidentifier] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[Version] [int] NOT NULL,
	[TimeCreated] [datetime] NULL,
	[DocFlags] [int] NOT NULL,
	[MetaInfoSize] [int] NULL,
	[Size] [int] NULL,
	[MetaInfo] [image] NULL,
	[Content] [image] NULL,
	[CheckinComment] [nvarchar](1023) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Level] [tinyint] NOT NULL,
	[DraftOwnerId] [int] NULL,
	[DeleteTransactionId] [varbinary](16) NOT NULL,
	[VirusVendorID] [int] NULL,
	[VirusStatus] [int] NULL,
	[VirusInfo] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [AllDocVersions_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[Id] ASC,
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[AllDocVersions] ADD  DEFAULT ((1)) FOR [Level]
ALTER TABLE [dbo].[AllDocVersions] ADD  DEFAULT (0x) FOR [DeleteTransactionId]
/****** Object:  Trigger [dbo].[trigger_OnDeleteDocVersions]    Script Date: 5/15/2018 12:05:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_OnDeleteDocVersions ON AllDocVersions AFTER DELETE
As
    DECLARE @siteId uniqueidentifier
    DECLARE @cbDelta bigint
    DECLARE @cSave int
    SELECT
        @SiteId = SiteId,
        @cbDelta = -(SUM(CAST((ISNULL(Size, 0) + ISNULL(MetaInfoSize, 0)) AS BIGINT)))
    FROM
        DELETED
    WHERE
        DeleteTransactionId = 0x
    GROUP BY
        SiteId
    SET @cSave = @@ROWCOUNT
    IF (@cSave = 1)
    BEGIN
        EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 0
    END

GO
