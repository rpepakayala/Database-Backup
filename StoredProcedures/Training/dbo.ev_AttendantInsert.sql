/****** Object:  StoredProcedure [dbo].[ev_AttendantInsert]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE ev_AttendantInsert
(
	@AttendantRoleID int,
	@LocalBilling int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@BadgeName varchar(50),
	@City varchar(50),
	@State varchar(50),
	@Email varchar(255),
	@WebNumber int,
	@MealRequest varchar(50),
	@MealOtherRequirements varchar(500),
	@ThursBreakfast bit,
	@ThursLunch bit,
	@ThursCocktail bit,
	@FriBreakfast bit,
	@FriLunch bit,
	@Golf varchar(5),
	@GolfShirt varchar(5),
	@GolfShirtType varchar(20),
	@GolfShirtSize varchar(20),
	@StayFridayNight varchar(5),
	@ActivitiesOnSaturday varchar(5),
	@CardNumber varchar(50),
	@CardType varchar(50),
	@ExpMonth int,
	@ExpYear int,
	@NameOnCard varchar(50),
	@SubTotal money,
	@YearsOfService varchar(20)
)
AS

-- Local Billing = 1; user entered the payment manually
-- Local Billing = 0; user selected a card from the Payment Management Section in Support.Fastsigns.com

DECLARE 
	@locAttendantID int, 
	@locEventID int, 
	@locAttendantStatusID int,
	@locBillingStatusID int

SELECT @locEventID = 1
SELECT @locAttendantStatusID = 1
SELECT @locBillingStatusID = 1

INSERT INTO ev_Attendants(
	EventID, AttendantRoleID, AttendantStatusID, BillingStatusID, LocalBilling, 
	Firstname, LastName, BadgeName, City, State, Email, 
	WebNumber, FBCTradeOut, MealRequest, MealOtherRequirements, FirstTime, EntryDate, YearsOfService)
VALUES(
	@locEventID, @AttendantRoleID, @locAttendantStatusID, @locBillingStatusID, @LocalBilling, 
	@FirstName, @LastName, @BadgeName, @City, @State, @Email, 
	@WebNumber, null, @MealRequest, @MealOtherRequirements, null, getDate(), @YearsOfService)

SELECT @locAttendantID = @@IDENTITY

INSERT INTO ev_AttendantAgenda_OM05(
	AttendantID, ThursBreakfast, ThursLunch, ThursCocktail, FriBreakfast, FriLunch, Golf, 
	GolfShirt, GolfShirtType, GolfShirtSize, StayFridayNight, ActivitiesOnSaturday, EntryDate)
VALUES(
	@locAttendantID, @ThursBreakfast, @ThursLunch, @ThursCocktail, @FriBreakFast, @FriLunch, @Golf,
	@GolfShirt, @GolfShirtType, @GolfShirtSize, @StayFridayNight, @ActivitiesOnSaturday, getDate())

INSERT INTO ev_PaymentInfo(
	EventID, AttendantID, CardNumber, CardType, PID, ExpMonth, ExpYear, NameOnCard,
	Address1, Address2, City, State, Zip, Phone, SubTotal, EntryDate)
VALUES(
	@locEventID, @locAttendantID, @CardNumber, @CardType, null, @ExpMonth, @ExpYear, @NameOnCard,
	null, null, @City, @State, null, null, @SubTotal, getDate())
GO
