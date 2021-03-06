/****** Object:  View [dbo].[vw_Contact_List]    Script Date: 5/15/2018 12:13:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Contact_List
AS


Select
  c1.ACCOUNTNO As 'GoldmineId',
  Cast(c2.UVANNM As VARCHAR(40)) As 'CurrentGMVaintyName',
  Case When c2.UROM = 'Closed' Then 'TBD TBD' Else IsNull(c2.UROM, 'TBD TBD')
  End As 'Director',
  IsNull(c1.LASTNAME, '') As 'OwnerLastname',
  IsNull(c1.DEAR, '') As 'OwnerFirstDear',
  c1.CONTACT,
  c2.USTOREOPD As 'StoreOpenDate',
  c2.URESALEOPD As 'ResaleOpenDate',
  Case When IsNull(c2.USTORETYPE, '') = 'Closed' Or
    CharIndex('DEVELOPER', Upper(IsNull(c1.LASTNAME, ''))) > 0 Or
    CharIndex('TRAINING', Upper(IsNull(c1.DEAR, ''))) > 0 Or
    IsNull(c1.KEY4, '') = 'Closed' Or IsNull(c1.ADDRESS1, '') = 'Coming Soon!'
    Or IsNull(c2.USTORETYPE, '') = 'Training' Or
    IsNull(c2.USTORETYPE, '') = 'Master' Or
    IsNull(c1.CONTACT, '') = 'Catherine Monson' Then 0 Else 1 End As Status,
  IsNull(c1.ADDRESS1, '') As 'Address1',
  IsNull(c1.ADDRESS2, '') As 'Address2',
  IsNull(c1.CITY, '') As 'City',
  IsNull(c1.STATE, '') As 'State',
  IsNull(c1.ZIP, '') As 'Zip',
  IsNull(c1.COUNTRY, '') As 'Country',
  IsNull(c2.UREGION, '') As 'Region',
  IsNull(c1.PHONE1, '') As 'Phone1',
  IsNull(c1.EXT1, '') As 'Ext1',
  IsNull(c1.PHONE2, '') As 'Phone2',
  IsNull(c1.EXT2, '') As 'Ext2',
  IsNull(c1.FAX, '') As 'Fax',
  Cast(IsNull(cs.CONTSUPREF, '') + IsNull(cs.ADDRESS1, '') As VARCHAR(50)) As
  'Email',
  IsNull(cs2.CONTSUPREF, '') As 'WebsiteUrl',
  Convert(INT,IsNull(c1.KEY1, '0')) As 'StoreNumber',
  Case When c1.KEY2 = 'Closed' Then 'TBD TBD' Else IsNull(c1.KEY2, 'TBD TBD')
  End As 'FBC',
  IsNull(c2.UWEBNUMBER, '') As 'WebNumber',
  IsNull(c1.KEY4, '') As 'Operational',
  IsNull(c1.KEY5, '') As 'Compliance',
  Convert(MONEY,IsNull(c2.UROYALTYF, 0.0),2) As 'RoyaltyFIIpercent',
  IsNull(c2.UROYALTYF, '0.0') As 'Royalty_B',
  Convert(MONEY,IsNull(c2.UADV_FEE, 0.0),0) As 'RoyaltyNACpercent',
  IsNull(c2.UADV_FEE, 0.0) As 'AdvFee_B',
  Replace(IsNull(c2.USHARINTN1, 'None NA'), '/', ' ') As 'Shareholder1',
  Convert(MONEY,IsNull(c2.USHAREINT1, '0.0'),2) As 'Interest1_A',
  IsNull(c2.USHAREINT1, '0.0') As 'Interest1_B',
  IsNull(c2.USHARINTN2, '') As 'Shareholder2',
  Convert(MONEY,IsNull(c2.USHAREINT2, '0.0'),2) As 'Interest2_A',
  IsNull(c2.USHAREINT2, '0.0') As 'Interest2_B',
  IsNull(c2.USHARINTN3, '') As 'Shareholder3',
  Convert(MONEY,IsNull(c2.USHAREINT3, '0.0'),2) As 'Interest3_A',
  IsNull(c2.USHAREINT3, '0.0') As 'Interest3_B',
  IsNull(c2.USHARINTN4, '') As 'Shareholder4',
  Convert(MONEY,IsNull(c2.USHAREINT4, '0.0'),2) As 'Interest4_A',
  IsNull(c2.USHAREINT4, '0.0') As 'Interest4_B',
  IsNull(c2.USHARINTN5, '') As 'Shareholder5',
  Convert(MONEY,IsNull(c2.USHAREINT5, '0.0'),2) As 'Interest5_A',
  IsNull(c2.USHAREINT5, '0.0') As 'Interest5_B',
  IsNull(c2.USHARINTN6, '') As 'Shareholder6',
  Convert(MONEY,IsNull(c2.USHAREINT6, '0.0'),2) As 'Interest6_A',
  IsNull(c2.USHAREINT6, '0.0') As 'Interest6_B',
  IsNull(c2.UEMC, '') As STBLevel,
  Convert(BIT,Case When IsNull(c2.UASP, '') = 'Yes' Then 1 Else 0 End) As ASI,
  Convert(INT,IsNull(c2.UEQUIPPACK, '0')) As EquipmentPackage,
  Convert(BIT,Case When IsNull(c2.UEQUIPMNT, '') = 'Yes' Then 1 Else 0
  End) As Router,
  Case When IsNull(c2.ULASTCONV, '0') = 'None' Then 0
    Else Convert(INT,IsNull(c2.ULASTCONV, '0')) End As LastConvention,
  Convert(BIT,Case When IsNull(c2.USALESREP, '') = 'Yes' Then 1 Else 0
  End) As OutsideSalesRep,
  Convert(BIT,Case When IsNull(c2.ULUMINATE, '') = 'Yes' Then 1 Else 0
  End) As Luminate,
  IsNull(c2.ULOCTYPE, '') As LocationType,
  0 As TrafficCount,
  Convert(BIT,Case When IsNull(c2.UOWNERTYPE, '') = '' Then 1 Else 0
  End) As SingleOwner,
  Convert(INT,IsNull(c2.UOWNERCNT, '0')) As OwnerCount,
  Convert(BIT,Case When IsNull(c2.ULANDLORD, '') = 'Yes' Then 1 Else 0
  End) As Landlord,
  Convert(BIT,Case When IsNull(c2.UFAC, '') = 'Yes' Then 1 Else 0 End) As FAC,
  Convert(BIT,Case When IsNull(c2.UNAC, '') = 'Yes' Then 1 Else 0 End) As NAC,
  Convert(BIT,Case When IsNull(c2.UTAC, '') = 'Yes' Then 1 Else 0 End) As TAC,
  Convert(INT,Replace(IsNull(SF.SquareFeet, '0'), ',', '')) As SquareFeet,
  IsNull(c2.USTORETYPE, '') As StoreType,
  Alert = Case When CharIndex('Al', IsNull(c1.KEY5, '')) > 0 Then 1 Else 0 End,
  COD = Case When CharIndex('COD', IsNull(c1.KEY5, '')) > 0 Then 1 Else 0 End,
  LimitedServices = Case When CharIndex('Ltd', IsNull(c1.KEY5, '')) > 0 Or
    CharIndex('Srv', IsNull(c1.KEY5, '')) > 0 Then 1 Else 0 End,
  Pacesetter = Case When CharIndex('Pace', IsNull(c1.KEY4, '')) > 0 Then 1
    Else 0 End,
  Company = c1.COMPANY,
  Case When IsNull(c2.UNAPAGRDAT, '') <> '' Then 1 Else 0 End As NAPAgreement,
  Case When IsNull(c2.UNAPAGRDT2, '') <> '' Then 1 Else 0
  End As NAPDirectAgreement,
  Case When IsNull(c2.UNAPELECTR, '') <> '' Then 1 Else 0 End As NAPElectrical
From
  CONTACT1 c1
  Left Join CONTACT2 c2 On c1.ACCOUNTNO = c2.ACCOUNTNO
  Left Join CONTSUPP cs On c1.ACCOUNTNO = cs.ACCOUNTNO And (cs.RECTYPE = 'P' And
    cs.CONTACT = 'E-mail Address' And cs.ZIP Like '_1%')
  Left Join CONTSUPP cs2 On c1.ACCOUNTNO = cs2.ACCOUNTNO And (cs2.RECTYPE = 'P'
    And cs2.CONTACT = 'Web Site' And cs2.CONTSUPREF Like '%www%')
  Left Join (Select
    CS.ACCOUNTNO,
    Max(CS.COUNTRY) As SquareFeet
  From
    CONTSUPP CS Inner Join
    (Select
      CONTSUPP.ACCOUNTNO,
      Max(Convert(VARCHAR,CONTSUPP.LASTDATE,101) + ' ' + CONTSUPP.LASTTIME) As
      LastDate
    From
      CONTSUPP
    Where
      CONTSUPP.RECTYPE = 'P' And
      CONTSUPP.CONTACT = 'Building Information'
    Group By
      CONTSUPP.ACCOUNTNO) As CSD On CSD.ACCOUNTNO = CS.ACCOUNTNO
  Where
    CS.RECTYPE = 'P' And
    CS.CONTACT Like 'Building Information' And
    CS.COUNTRY Is Not Null And
    CSD.LastDate = Convert(VARCHAR,CS.LASTDATE,101) + ' ' + CS.LASTTIME
  Group By
    CS.ACCOUNTNO) As SF On c2.ACCOUNTNO = SF.ACCOUNTNO
Where
  IsNumeric(c1.KEY1) = 1 And
  Cast(c1.KEY1 As INT) > 0


--SELECT	a.*, b.*	
--FROM		#TempA a
--LEFT OUTER JOIN [dbo].[contact_list_update] b
--ON		a.CONTACT = b
GO
