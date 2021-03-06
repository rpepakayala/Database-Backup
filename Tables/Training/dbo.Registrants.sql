/****** Object:  Table [dbo].[Registrants]    Script Date: 5/15/2018 12:07:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Registrants](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FirstName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StorePosition] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreNumber] [int] NULL,
	[City] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OtherState] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FBCTradeOut] [bit] NULL,
	[FBCName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SubClass] [int] NULL,
	[Wait] [int] NULL,
	[RegisteredDate] [datetime] NULL,
	[Country] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NULL,
	[Status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Registrants] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Registrants]  WITH CHECK ADD  CONSTRAINT [FK_Registrants_SubClasses] FOREIGN KEY([SubClass])
REFERENCES [dbo].[SubClasses] ([ID])
ALTER TABLE [dbo].[Registrants] CHECK CONSTRAINT [FK_Registrants_SubClasses]
/****** Object:  Trigger [dbo].[tr_Registrants_GoldMine]    Script Date: 5/15/2018 12:07:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- Trigger to insert registrants who have atteneded a class --
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

CREATE TRIGGER tr_Registrants_GoldMine ON dbo.Registrants 
AFTER UPDATE
AS
SET NOCOUNT ON -- Perfomance boost

--=-=-=-=-=-=-=-=-=-=-=-=-
-- Variable declaration --
--=-=-=-=-=-=-=-=-=-=-=-=-
DECLARE 
	@RegistrantID int,
	@OldStatus varchar(10),
	@NewStatus varchar(10)

--=-=-=-=-=-=-=-=-
-- Set variables --
--=-=-=-=-=-=-=-=-
SELECT @OldStatus = Status
FROM deleted

SELECT @RegistrantID = ID, @NewStatus = Status
FROM inserted

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- If status is marked as attended --
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
IF ( @OldStatus != @NewStatus ) AND @NewStatus = 'Attended'
 BEGIN
	--=-=-=-=-=-=-=-=-=-=-=-
	-- Clear out GM table --
	--=-=-=-=-=-=-=-=-=-=-=-
	DELETE FROM Registrants_GoldMine
	WHERE RegistrantID = @RegistrantID

	--=-=-=-=-=-=-=-=-=-=-=-=
	-- Insert into GM table --
	--=-=-=-=-=-=-=-=-=-=-=-=
	INSERT INTO Registrants_GoldMine
	( RegistrantID )
	VALUES
	( @RegistrantID )
 END

GO
