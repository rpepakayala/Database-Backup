/****** Object:  StoredProcedure [dbo].[usp_FM_StoreBasedContactsIsModifiedUpdater]    Script Date: 5/15/2018 12:09:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Alex Montminy
-- Create date: 10/24/2013
-- Description:	Flips Contact IsModified when store IS_Modified changes
-- =============================================
CREATE PROCEDURE [dbo].[usp_FM_StoreBasedContactsIsModifiedUpdater]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		--create table
   declare @StoresToUpdate Table(
   StoreKeys int
   )
   --populate table
   insert into @StoresToUpdate(StoreKeys)
   Select
  Store.StoreFact.CenterKey
From
  Store.StoreFact Inner Join
  Store.FastMailDim On Store.FastMailDim.CenterKey = Store.StoreFact.CenterKey 
    where   Store.FastMailDim.IsModified = 1
    
   --update contacts
    update Contact.FastMailDim
    set IsModified =1
    From
  Contact.ContactFact Inner Join
  Contact.FastMailDim FastMailDim1 On FastMailDim1.ContactKey =
    Contact.ContactFact.ContactKey
    inner join 
    @StoresToUpdate STU on STU.StoreKeys = Contact.ContactFact.CenterKey
     
   
   ---update stores
   update Store.FastMailDim
   set IsModified=0 
   from
  Store.FastMailDim inner join @StoresToUpdate STU 
  on Store.FastMailDim.CenterKey = STU.StoreKeys 
   
   
   ------------------
END


GO
