/****** Object:  StoredProcedure [dbo].[proc_GetSubImageUrls]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetSubImageUrls(
    @Url nvarchar(260),
    @ThumbnailDirName nvarchar(256) OUTPUT,
    @WebImageDirName nvarchar(256) OUTPUT,
    @SubImgLeafName nvarchar(128) OUTPUT)
AS
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @FileBaseName nvarchar(128)
    DECLARE @FileExtension nvarchar(128)
    DECLARE @idx int
    EXEC proc_SplitUrl
        @Url,
        @DirName OUTPUT,
        @LeafName OUTPUT
    EXEC proc_SplitLeafName @LeafName,
        @FileBaseName OUTPUT,
        @FileExtension OUTPUT
    SET @SubImgLeafName = @FileBaseName + N'_' + @FileExtension + N'.jpg'
    SET @ThumbnailDirName = CASE WHEN (DATALENGTH(@DirName) = 0) THEN N'_t' WHEN (DATALENGTH(N'_t') = 0) THEN @DirName ELSE @DirName + N'/' + N'_t' END
    SET @WebImageDirName = CASE WHEN (DATALENGTH(@DirName) = 0) THEN N'_w' WHEN (DATALENGTH(N'_w') = 0) THEN @DirName ELSE @DirName + N'/' + N'_w' END

GO
