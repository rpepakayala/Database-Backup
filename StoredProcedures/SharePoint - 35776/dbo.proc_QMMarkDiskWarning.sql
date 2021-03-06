/****** Object:  StoredProcedure [dbo].[proc_QMMarkDiskWarning]    Script Date: 5/15/2018 12:12:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_QMMarkDiskWarning
    @dtLast datetime,
    @dtCur datetime
AS
UPDATE Sites SET
    DiskWarned = @dtCur
WHERE DiskWarned IS NOT NULL AND
    DiskWarned > @dtLast AND
    DiskWarned < @dtCur
UPDATE DiskWarningDate SET lastDiskWarningDate = @dtCur

GO
