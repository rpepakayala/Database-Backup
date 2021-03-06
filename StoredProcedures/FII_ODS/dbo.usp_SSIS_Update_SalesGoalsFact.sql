/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_SalesGoalsFact]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_SalesGoalsFact]
AS 
    UPDATE
        F
    SET 
        [ID] = U.[ID] ,
        [MonthText] = U.[MonthText] ,
        [Month] = U.[Month] ,
        [Year] = U.[Year] ,
        [SalesTotal] = U.[SalesTotal] ,
        [SalesWIP1] = U.[SalesWIP1] ,
        [SalesWIP2] = U.[SalesWIP2] ,
        [SalesWIP3] = U.[SalesWIP3] ,
        [OLTP_InsertDate] = U.[OLTP_InsertDate] ,
        [OLTP_UpdateDate] = U.[OLTP_UpdateDate] ,
        [ZW_Franchise_ID] = U.[ZW_Franchise_ID] ,
        [YearOf] = U.[YearOf] ,
        [ModifiedDate] = U.[ModifiedDate] ,
        [UpdateCheckSum] = U.[UpdateCheckSum] ,
        [CenterKey] = U.[CenterKey]
    FROM
        [Staging].[dbo].[SalesGoalsFactUpdate] U
        JOIN [Store].[SalesGoalsFact] F ON F.SalesGoalsKey = u.SalesGoalsKey

    INSERT  INTO [Store].[SalesGoalsFact]
            ( [ID] ,
              [MonthText] ,
              [Month] ,
              [Year] ,
              [SalesTotal] ,
              [SalesWIP1] ,
              [SalesWIP2] ,
              [SalesWIP3] ,
              [OLTP_InsertDate] ,
              [OLTP_UpdateDate] ,
              [ZW_Franchise_ID] ,
              [YearOf] ,
              [ModifiedDate] ,
              [UpdateCheckSum] ,
              [CenterKey]
            )
            SELECT
                [ID] ,
                [MonthText] ,
                [Month] ,
                [Year] ,
                [SalesTotal] ,
                [SalesWIP1] ,
                [SalesWIP2] ,
                [SalesWIP3] ,
                [OLTP_InsertDate] ,
                [OLTP_UpdateDate] ,
                [ZW_Franchise_ID] ,
                [YearOf] ,
                [ModifiedDate] ,
                [UpdateCheckSum] ,
                [CenterKey]
            FROM
                [Staging].[dbo].[SalesGoalsFactUpdate]
            WHERE
                [SalesGoalsKey] = 0 

    TRUNCATE TABLE Staging.dbo.SalesGoalsFactUpdate 

GO
