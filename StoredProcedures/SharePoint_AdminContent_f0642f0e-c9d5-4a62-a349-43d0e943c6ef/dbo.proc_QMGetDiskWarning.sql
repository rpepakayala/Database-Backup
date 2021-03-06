/****** Object:  StoredProcedure [dbo].[proc_QMGetDiskWarning]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_QMGetDiskWarning
    @dtLast datetime OUTPUT,
    @dtCur datetime OUTPUT
AS
SELECT @dtLast = lastDiskWarningDate FROM DiskWarningDate
SET @dtCur = GetUTCDate()
SELECT
    w.FullUrl,
    s.Id,
    u.tp_Email,
    w.Language
FROM Sites AS s
JOIN UserInfo AS u ON
    u.tp_SiteID = s.Id AND
    u.tp_SiteAdmin = 1 AND
    u.tp_Deleted = 0
JOIN Webs AS w ON
    w.SiteId = s.Id AND
    w.ParentWebId IS NULL
WHERE s.DiskWarned IS NOT NULL AND
    s.DiskWarned > @dtLast AND
    s.DiskWarned <= @dtCur
ORDER BY w.Language, s.Id

GO
