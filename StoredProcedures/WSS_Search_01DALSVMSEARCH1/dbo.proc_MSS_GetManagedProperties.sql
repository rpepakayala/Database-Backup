/****** Object:  StoredProcedure [dbo].[proc_MSS_GetManagedProperties]    Script Date: 5/15/2018 12:13:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetManagedProperties
@ldate datetime = 0
AS
DECLARE @RetVal int  SET @RetVal = 0
Select  [PID], 
        [FriendlyName], 
        [ManagedType], 
        [FullTextQueriable], 
        [Retrievable], 
        [Scoped], 
        [RespectPriority], 
        [RemoveDuplicates], 
        [NoDelete], 
        [NoMap],                        
        [Hidden],                       
        [HasMultipleValues], 
        [NoWordBreaker], 
        [NameNormalized], 
        [IncludeInMD5], 
        [openbit1], 
        [openbit2],      
        [Mapped],         
        [QueryIndependentRank], 
        [WordBreakerOverride], 
        [Weight], 
        [LengthNormalization],
        [LastModified]  
    from [dbo].[MSSManagedProperties]
          where @ldate <= LastModified
return @RetVal

GO
