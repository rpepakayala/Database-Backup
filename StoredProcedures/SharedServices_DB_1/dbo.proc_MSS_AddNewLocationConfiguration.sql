/****** Object:  StoredProcedure [dbo].[proc_MSS_AddNewLocationConfiguration]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddNewLocationConfiguration(
     @InternalName nvarchar(60),
     @DisplayName nvarchar(60),
     @AdminDescription nvarchar(256),
     @LocationType tinyint,
     @Author nvarchar(60),
     @Version nvarchar(50),
     @IsDeletable bit,
     @IsPrefixPattern bit,
     @QueryReformatPattern ntext,
     @PropertySchema ntext,
     @QueryRestriction nvarchar(512),
     @KindsOfResults ntext,
     @Languages ntext,
     @IsRestricted bit,
     @AllowedSiteCollectionGuids ntext,
     @Type tinyint,
     @Data ntext,
     @ConnectionUrlTemplate nvarchar(2048),
     @MoreUrlTemplate nvarchar(2048),
     @CreationDate datetime OUTPUT,
     @LastModifiedDate datetime OUTPUT,
     @LocationDescription ntext,
     @LocationId int OUTPUT

)
 AS

SET NOCOUNT ON

DECLARE @Id int
DECLARE @LastError int
DECLARE @IsLongQueryReformatPattern bit
DECLARE @ConnectionUrlType tinyint
DECLARE @MoreUrlType tinyint

DECLARE @ModificationDate datetime

SET @ConnectionUrlType = 0
SET @MoreUrlType = 1

SET @ModificationDate = GETUTCDATE()
SET @CreationDate = @ModificationDate
SET @LastModifiedDate = @ModificationDate

if (datalength(@QueryReformatPattern) > col_length('dbo.MSSLocations', 'QueryReformatPatternl')) set @IsLongQueryReformatPattern = 1 else set @IsLongQueryReformatPattern = 0

BEGIN TRAN

   INSERT INTO dbo.MSSLocations
      (InternalName, DisplayName, AdminDescription, LocationType,
       Author, Version, IsDeletable, IsPrefixPattern,
       QueryReformatPattern,
       QueryReformatPatternBig,
       PropertySchema, QueryRestriction, KindsOfResults, Languages, IsRestricted, AllowedSiteCollectionGuids, CreationDate, LastModifiedDate)
   VALUES
      ( @InternalName, @DisplayName, @AdminDescription, @LocationType,
        @Author, @Version, @IsDeletable, @IsPrefixPattern,
      case when (@IsLongQueryReformatPattern = 0) then  @QueryReformatPattern else null end,
      case when (@IsLongQueryReformatPattern = 1) then  @QueryReformatPattern else null end,
      @PropertySchema, @QueryRestriction,  @KindsOfResults, @Languages, @IsRestricted, @AllowedSiteCollectionGuids,@CreationDate, @LastModifiedDate)

   SELECT @LastError = @@ERROR
   IF (@LastError <> 0) Or (@@Rowcount != 1)
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END

   SET @LocationId = @@Identity

   INSERT INTO dbo.MSSLocationUrlTemplates
      (LocationId, UrlTemplate, TemplateType)
   VALUES
      (@LocationId, @ConnectionUrlTemplate, @ConnectionUrlType)

   SELECT @LastError = @@ERROR
   IF (@LastError <> 0) Or (@@Rowcount != 1)
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END

   INSERT INTO dbo.MSSLocationUrlTemplates
      (LocationId, UrlTemplate, TemplateType)
   VALUES
      (@LocationId, @MoreUrlTemplate, @MoreUrlType)

   SELECT @LastError = @@ERROR
   IF (@LastError <> 0) Or (@@Rowcount != 1)
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END

   INSERT INTO dbo.MSSLocationAuthentication
      (LocationId, Type, Data)
   VALUES
      (@LocationId, @Type, @Data)

   SELECT @LastError = @@ERROR
   IF (@LastError <> 0) Or (@@Rowcount != 1)
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END

   INSERT INTO dbo.MSSLocationXml
      (LocationId, Xml)
   VALUES
      (@LocationId, @LocationDescription)

   SELECT @LastError = @@ERROR
   IF (@LastError <> 0) Or (@@Rowcount != 1)
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END

   EXEC @LastError = dbo.proc_MSS_UpdateCacheInformation

   SELECT @LastError = @@ERROR
   IF @LastError <> 0
   BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
   END
COMMIT TRAN

RETURN 0

GO
