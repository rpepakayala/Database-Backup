/****** Object:  StoredProcedure [dbo].[proc_MSS_UpdateSpecialTerm]    Script Date: 5/15/2018 12:11:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_UpdateSpecialTerm
@ConsumerGpId NVARCHAR(50),
@SpecialTermID int,
@Term NVARCHAR(100),
@Definition NVARCHAR(500) = null,
@Contact NVARCHAR(50) = null,
@StartDate DATETIME,
@EndDate DATETIME = null,
@ReviewDate DATETIME = null AS

Update MSSSpecialTerms
set 
Term = @Term,
Definition = @Definition,
Contact = @Contact,
StartDate = @StartDate, 
EndDate = @EndDate,
ReviewDate = @ReviewDate
WHERE SpecialTermID = @SpecialTermId


GO
