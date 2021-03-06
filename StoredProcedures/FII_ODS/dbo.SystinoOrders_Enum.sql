/****** Object:  StoredProcedure [dbo].[SystinoOrders_Enum]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF


/*********************************************************************************************************/
/*							     datawarehouse.dbo.SystinoOrders_Enum									 */	   							
/*	CREATE DATE: UNKNOWN																				 */
/*  CREATED BY:  UNKNOWN																				 */
/*  NOTES:																								 */
/*																										 */
/*	MODIFIED DATE	MODIFIED BY		NOTES																 */
/*  11-21-2011		TODD PETERSON	Added following logic to WHERE clause to pad survey send date to     */
/*									allow customers to receive survey after product is shipped           */
/*									and not before.														 */
/*											and [od].[PickedUpDate] < getdate() - 3						 */
/*																										 */
/*	12-08-2011		Brent Farr		Expanded where clause to include UK country codes					 */
/*	01-05-2012		Todd Peterson	Ticket 63223. Commented out code that supported business logic       */
/*									dictatedwhen stored procedure was implemented.						 */
/*										WHERE [od].[PickedUpDate] > getdate() - 90 was changed to		 */
/*										WHERE [od].[PickedUpDate] > getdate() - 10.						 */
/*									The following in the where clause was commented out in its entirety: */
/*									    AND NOT EXISTS (SELECT [s].[email]								 */
/*														FROM [survey].[dbo].[Survey] s WITH(NOLOCK)	     */
/*														WHERE [od].[OrdererEmailAddress] = [s].[email]	 */
/*														AND [s].[SendDate] > getdate() - @HistoryInDays	 */
/*																										 */
/*	1-26-2012		Brent Farr		Expanded where clause to include AU country codes					 */
/*	3-08-2012		Praveen Ponugoti	Added condition to exclude opt-out emails	
--  8-05-2013       TAF Converted to ODS
--  2/18/2014		Converted for Keystone using the Union ALL	
--  7/16/2014       Keystoen needed left joins to work correctly.
--  7/18/2014       Had to remove TOP 100 in Keystone Join for Speed (Fixed indexes)				                                              */
/*********************************************************************************************************/
/*************************************************************
DEPLOYMENT DATE:	03/08/2011
DEPLOYER:			Todd Peterson
CHANGESET:			unk
SERVER/DB:			01DALSPRODSQL1..DataWarehouse
COMMENTS:		
*************************************************************/
CREATE PROCEDURE [dbo].[SystinoOrders_Enum] 
	-- Add the parameters for the stored procedure here
    @HistoryInDays INT = 90
AS
    BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE
            @GPickedUpDate DATETIME ,
            @LPickedUpDate DATETIME
        SET @GPickedUpDate = GETDATE() - 10
        SET @LPickedUpDate = GETDATE() - 3  
		
        DECLARE @Message VARCHAR(300)
		CREATE TABLE #L360Temp
            (
              [OrderID] [INT] NULL ,
              [StoreID] [BIGINT] NULL ,
              [StoreNumber] [BIGINT] NULL ,
              [PricingRatio] [FLOAT] NULL ,
              [OrderDescription] [VARCHAR](2000) NULL ,
              [status] [VARCHAR](15) NULL ,
              [NumberItems] [INT] NULL ,
              [CustomerID] [INT] NULL ,
              [ContactID] [INT] NULL ,
              [OrdererFirstName] [VARCHAR](50) NULL ,
              [OrdererLastName] [VARCHAR](50) NULL ,
              [OrdererTitle] [VARCHAR](50) NULL ,
              [OrdererPareaCode] [VARCHAR](25) NULL ,
              [OrdererPhoneNumber] [VARCHAR](25) NULL ,
              [OrdererPhoneExtention] [VARCHAR](25) NULL ,
              [OrdererFareaCode] [VARCHAR](25) NULL ,
              [OrdererFaxNumber] [VARCHAR](20) NULL ,
              [OrdererEmailAddress] [VARCHAR](100) NULL ,
              [OrderOriginID] [INT] NULL ,
              [InterestAmount] [MONEY] NULL ,
              [SalesTotal] [DECIMAL](38, 2) NULL ,
              [zw_franchise_id] [CHAR](7) NULL ,
              [OrdererEmailAddress1] [VARCHAR](100) NULL ,
              [PickedUpDate] [DATETIME] NULL ,
              [BillingAddress1] [VARCHAR](50) NULL ,
              [BillingAddress2] [VARCHAR](50) NULL ,
              [City] [VARCHAR](50) NULL ,
              [State] [VARCHAR](25) NULL ,
              [Zip] [VARCHAR](50) NULL ,
              [CompanyName] [VARCHAR](50) NULL ,
              [Country] [VARCHAR](50) NULL ,
              [StoreOpenDate] [DATE] NULL ,
              [SalesRegionName] [VARCHAR](50) NULL ,
              [CountryCode] [CHAR](2) NULL
            )
-- ODS

 SET @Message=CONVERT ( CHAR(20), GETDATE() ,114 )+'Start'
 RAISERROR(@Message, 0, 1) WITH NOWAIT
        INSERT  INTO #L360Temp
                EXEC SystinoOrders_Enum_ODS
                    @GPickedUpDate2 = @GPickedUpDate ,
                    @LPickedUpDate2 = @LPickedUpDate
 SET @Message=CONVERT ( CHAR(20), GETDATE() ,114 )+'ODS'
 RAISERROR(@Message, 0, 1) WITH NOWAIT

---- TAF Changes for Keystone follow

 --       INSERT  INTO #L360Temp
 --               EXEC SystinoOrders_Enum_Key
 --                   @GPickedUpDate2 = @GPickedUpDate ,
 --                   @LPickedUpDate2 = @LPickedUpDate
 --SET @Message=CONVERT ( CHAR(20), GETDATE() ,114 )+'Keystone'
 --RAISERROR(@Message, 0, 1) WITH NOWAIT

---- TAF Corebridge

        insert  into #l360temp
                exec systinoorders_enum_core
                    @gpickedupdate2 = @gpickedupdate ,
                    @lpickedupdate2 = @lpickedupdate
 SET @Message=CONVERT ( CHAR(20), GETDATE() ,114 )+'Core'
 RAISERROR(@Message, 0, 1) WITH NOWAIT

        SELECT DISTINCT
            *
        FROM
            #L360Temp;

        DROP TABLE #L360Temp
 SET @Message=CONVERT ( CHAR(20), GETDATE() ,114 )+'Finish'
 RAISERROR(@Message, 0, 1) WITH NOWAIT

--GRANT EXECUTE ON dbo.SystinoOrders_Enum to [FASTSIGNS\app_systino_prod]
 --PRINT CONVERT ( CHAR(20), GETDATE() ,114 )

    END

	
GO
