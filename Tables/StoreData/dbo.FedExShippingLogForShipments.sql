/****** Object:  Table [dbo].[FedExShippingLogForShipments]    Script Date: 5/15/2018 12:06:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FedExShippingLogForShipments](
	[OrderNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActualOrderNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrackingNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Weight] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListPrice] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActualPrice] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShipDate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeclaredValue] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryDate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryInstructions] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackageType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ServiceType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NumberOfPackages] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [FedExShippingLogForShipments_OrderNumberIndex]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [FedExShippingLogForShipments_OrderNumberIndex] ON [dbo].[FedExShippingLogForShipments]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Trigger [dbo].[UpdateFedExShipment]    Script Date: 5/15/2018 12:06:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER UpdateFedExShipment ON FedExShippingLogForShipments FOR INSERT, UPDATE
AS

UPDATE Shipments 
SET    ModifiedByUser     = 'FedEx Auto Update',
       ModifiedDate       = GETDATE(),
       SeqID              = SeqID + 1,
       ActualCost         = Cast(Inserted.ActualPrice AS Float),
       EstimatedCost      = Cast(Inserted.ListPrice AS Float),
       IsShipped          = 1,
       PackageWeight      = Cast(Inserted.Weight AS Float),
       ShipDate           = CAST(Inserted.ShipDate AS DateTime),
       TrackingNumber     = CASE WHEN COALESCE(Shipments.TrackingNumber, '') = '' THEN ''
                                 ELSE Shipments.TrackingNumber + '; '
                            END + Inserted.TrackingNumber,
       InsuredValue       = Inserted.DeclaredValue,
       Notes              = Inserted.DeliveryInstructions,
       NumberOfPackages   = CAST(Inserted.NumberOfPackages AS Float ),

       CarrierID          = (SELECT TOP 1 ID FROM ShippingMethod WITH(NOLOCK) WHERE CarrierName LIKE '%FedEx%' AND IsActive = 1),
       CarrierClassTypeID = 6130,

       PackageSize        = CASE CAST(Inserted.PackageType AS VarChar(30)) 
                              WHEN '2'  THEN 'FedEx Pak' 
                              WHEN '3'  THEN 'FedEx Box'
                              WHEN '4'  THEN 'FedEx Tube'
                              WHEN '6'  THEN 'FedEx Envelope'
                              WHEN '15' THEN 'FedEx 10kg Box'
                              WHEN '25' THEN 'FedEx 25kg Box'
                              ELSE 'Your Packaging'

                            END,

       CarrierService     = CASE ServiceType 
                              WHEN '1' THEN 'Priority Overnight'
                              WHEN '2' THEN 'Standard Overnight'
                              WHEN '3' THEN '2Day'
                              WHEN '4' THEN '1Day Freight'
                              WHEN '5' THEN '2Day Freight'
                              WHEN '6' THEN 'First Overnight'
                              WHEN '7' THEN 'Express Saver'
                              WHEN '8' THEN '3Day Freight'
                              WHEN 'R' THEN 'Ground'
                              ELSE NULL
                            END

FROM   Inserted
WHERE  Shipments.ShipmentNumber = LTRIM(Inserted.OrderNumber)

GO
