/****** Object:  View [dbo].[vw_GoldminetoAlpine]    Script Date: 5/15/2018 12:13:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



CREATE VIEW [dbo].[vw_GoldminetoAlpine]
AS
    SELECT
        c1.ACCOUNTNO AS 'GoldmineId' ,
        ISNULL(c1.CONTACT, '') AS 'CurrentGMVaintyName' ,
        CASE WHEN c2.UROM = 'Closed' THEN 'TBD TBD'
             ELSE ISNULL(c2.UROM, 'TBD TBD')
        END AS 'Director' ,
        ISNULL(c1.LASTNAME, '') AS 'OwnerLastname' ,
        ISNULL(c1.DEAR, '') AS 'OwnerFirstDear' ,
        c2.USTOREOPD AS 'StoreOpenDate' ,
        c2.URESALEOPD AS 'ResaleOpenDate' ,
        CASE WHEN ISNULL(c2.USTORETYPE, '') = 'Closed'
                  OR CHARINDEX('DEVELOPER', UPPER(ISNULL(c1.LASTNAME, ''))) > 0
                  OR CHARINDEX('TRAINING', UPPER(ISNULL(c1.DEAR, ''))) > 0
                  OR ISNULL(c1.KEY4, '') = 'Closed'
                  OR ISNULL(c1.ADDRESS1, '') = 'Coming Soon!'
                  OR ISNULL(c2.USTORETYPE, '') = 'Training'
                  OR ISNULL(c2.USTORETYPE, '') = 'Master'
                  OR ISNULL(c1.CONTACT, '') = 'Catherine Monson' THEN 0
             ELSE 1
        END AS Status ,
        ISNULL(c1.ADDRESS1, '') AS 'Address1' ,
        ISNULL(c1.ADDRESS2, '') AS 'Address2' ,
        ISNULL(c1.CITY, '') AS 'City' ,
        ISNULL(c1.STATE, '') AS 'State' ,
        ISNULL(c1.ZIP, '') AS 'Zip' ,
        ISNULL(c1.COUNTRY, '') AS 'Country' ,
        ISNULL(c2.UREGION, '') AS 'Region' ,
        ISNULL(c1.PHONE1, '') AS 'Phone1' ,
        ISNULL(c1.EXT1, '') AS 'Ext1' ,
        ISNULL(c1.PHONE2, '') AS 'Phone2' ,
        ISNULL(c1.EXT2, '') AS 'Ext2' ,
        ISNULL(c1.FAX, '') AS 'Fax' ,
        CAST(ISNULL(cs.CONTSUPREF, '') + ISNULL(cs.ADDRESS1, '') AS VARCHAR(50)) AS 'Email' ,
        ISNULL(cs2.CONTSUPREF, '') AS 'WebsiteUrl' ,
        CONVERT(INT, ISNULL(c1.KEY1, '0')) AS 'StoreNumber' ,
        CASE WHEN c1.KEY2 = 'Closed' THEN 'TBD TBD'
             ELSE ISNULL(c1.KEY2, 'TBD TBD')
        END AS 'FBC' ,
        ISNULL(c2.UWEBNUMBER, '') AS 'WebNumber' ,
        ISNULL(c1.KEY4, '') AS 'Operational' ,
        ISNULL(c1.KEY5, '') AS 'Compliance' ,
        CONVERT(MONEY, ISNULL(c2.UROYALTYF, 0.0), 2) AS 'RoyaltyFIIpercent' ,
        ISNULL(c2.UROYALTYF, '0.0') AS 'Royalty_B' ,
        CONVERT(MONEY, ISNULL(c2.UADV_FEE, 0.0), 0) AS 'RoyaltyNACpercent' ,
        ISNULL(c2.UADV_FEE, 0.0) AS 'AdvFee_B' ,
        REPLACE(ISNULL(c2.USHARINTN1, 'None NA'),'/',' ') AS 'Shareholder1' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT1, '0.0'), 2) AS 'Interest1_A' ,
        ISNULL(c2.USHAREINT1, '0.0') AS 'Interest1_B' ,
        ISNULL(c2.USHARINTN2, '') AS 'Shareholder2' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT2, '0.0'), 2) AS 'Interest2_A' ,
        ISNULL(c2.USHAREINT2, '0.0') AS 'Interest2_B' ,
        ISNULL(c2.USHARINTN3, '') AS 'Shareholder3' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT3, '0.0'), 2) AS 'Interest3_A' ,
        ISNULL(c2.USHAREINT3, '0.0') AS 'Interest3_B' ,
        ISNULL(c2.USHARINTN4, '') AS 'Shareholder4' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT4, '0.0'), 2) AS 'Interest4_A' ,
        ISNULL(c2.USHAREINT4, '0.0') AS 'Interest4_B' ,
        ISNULL(c2.USHARINTN5, '') AS 'Shareholder5' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT5, '0.0'), 2) AS 'Interest5_A' ,
        ISNULL(c2.USHAREINT5, '0.0') AS 'Interest5_B' ,
        ISNULL(c2.USHARINTN6, '') AS 'Shareholder6' ,
        CONVERT(MONEY, ISNULL(c2.USHAREINT6, '0.0'), 2) AS 'Interest6_A' ,
        ISNULL(c2.USHAREINT6, '0.0') AS 'Interest6_B' ,
        ISNULL(c2.UEMC, '') AS STBLevel ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UASP, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS ASI ,
        CONVERT(INT, ISNULL(c2.UEQUIPPACK, '0')) AS EquipmentPackage ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UEQUIPMNT, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS Router ,
        CASE WHEN ISNULL(c2.ULASTCONV, '0') = 'None' THEN 0
             ELSE CONVERT(INT, ISNULL(c2.ULASTCONV, '0'))
        END AS LastConvention ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.USALESREP, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS OutsideSalesRep ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.ULUMINATE, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS Luminate ,
        ISNULL(c2.ULOCTYPE, '') AS LocationType ,
        0 AS TrafficCount ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UOWNERTYPE, '') = '' THEN 1
                          ELSE 0
                     END) AS SingleOwner ,
        CONVERT(INT, ISNULL(c2.UOWNERCNT, '0')) AS OwnerCount ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.ULANDLORD, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS Landlord ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UFAC, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS FAC ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UNAC, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS NAC ,
        CONVERT(BIT, CASE WHEN ISNULL(c2.UTAC, '') = 'Yes' THEN 1
                          ELSE 0
                     END) AS TAC ,
        CONVERT(INT, REPLACE(ISNULL(SF.SquareFeet, '0'), ',', '')) AS SquareFeet ,
        ISNULL(c2.USTORETYPE, '') AS StoreType ,
        Alert = CASE WHEN CHARINDEX('Al', ISNULL(c1.KEY5, '')) > 0 THEN 1
                     ELSE 0
                END ,
        COD = CASE WHEN CHARINDEX('COD', ISNULL(c1.KEY5, '')) > 0 THEN 1
                   ELSE 0
              END ,
        LimitedServices = CASE WHEN CHARINDEX('Ltd', ISNULL(c1.KEY5, '')) > 0
                                    OR CHARINDEX('Srv', ISNULL(c1.KEY5, '')) > 0
                               THEN 1
                               ELSE 0
                          END ,
        Pacesetter = CASE WHEN CHARINDEX('Pace', ISNULL(c1.KEY4, '')) > 0
                          THEN 1
                          ELSE 0
                     END,
		Company = C1.COMPANY                 
    FROM
        CONTACT1 c1
        LEFT JOIN CONTACT2 c2 ON c1.ACCOUNTNO = c2.ACCOUNTNO
        LEFT JOIN CONTSUPP cs ON c1.ACCOUNTNO = cs.ACCOUNTNO
                                 AND ( cs.RECTYPE = 'P'
                                       AND cs.CONTACT = 'E-mail Address'
                                       AND cs.ZIP LIKE '_1%'
                                     )
        LEFT JOIN CONTSUPP cs2 ON c1.ACCOUNTNO = cs2.ACCOUNTNO
                                  AND ( cs2.RECTYPE = 'P'
                                        AND cs2.CONTACT = 'Web Site'
                                        AND cs2.CONTSUPREF LIKE '%www%'
                                      )
        LEFT JOIN ( SELECT
                        CS.ACCOUNTNO ,
                        MAX(CS.COUNTRY) AS SquareFeet
                    FROM
                        CONTSUPP CS
                        INNER JOIN ( SELECT
                                        CONTSUPP.ACCOUNTNO ,
                                        MAX(CONVERT(VARCHAR, CONTSUPP.LASTDATE, 101)
                                            + ' ' + CONTSUPP.LASTTIME) AS LastDate
                                     FROM
                                        CONTSUPP
                                     WHERE
                                        CONTSUPP.RECTYPE = 'P'
                                        AND CONTSUPP.CONTACT = 'Building Information'
                                     GROUP BY
                                        CONTSUPP.ACCOUNTNO
                                   ) AS CSD ON CSD.ACCOUNTNO = CS.ACCOUNTNO
                    WHERE
                        CS.RECTYPE = 'P'
                        AND CS.CONTACT LIKE 'Building Information'
                        AND CS.COUNTRY IS NOT NULL
                        AND CSD.LastDate = CONVERT(VARCHAR, CS.LASTDATE, 101)
                        + ' ' + CS.LASTTIME
                    GROUP BY
                        CS.ACCOUNTNO
                  ) AS SF ON c2.ACCOUNTNO = SF.ACCOUNTNO
    WHERE
        ISNUMERIC(c1.KEY1) = 1
        AND CAST(c1.KEY1 AS INT) > 0






GO
