/****** Object:  StoredProcedure [dbo].[proc_MSS_AddBestBetLink]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddBestBetLink
@SpecialTermId INT,
@BestBetId INT,
@Order INT AS

    INSERT INTO MSSBestBetsLink VALUES (@SpecialTermId, @BestBetId, @Order)


GO
