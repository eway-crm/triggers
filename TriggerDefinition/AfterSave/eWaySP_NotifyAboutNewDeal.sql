IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eWaySP_NotifyAboutNewDeal]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[eWaySP_NotifyAboutNewDeal]
GO
-- =============================================
-- Author:		Author
-- Create date: Date
-- Description:	Description
-- =============================================
CREATE PROCEDURE [dbo].[eWaySP_NotifyAboutNewDeal]
(
	@LeadGUID UNIQUEIDENTIFIER,
	@LeadFileAs NVARCHAR(MAX)
)
AS
BEGIN

	SET NOCOUNT ON;

	SET XACT_ABORT ON;

	DECLARE @To NVARCHAR(MAX)
	DECLARE @Body NVARCHAR(MAX)

	SET @To = 'jiri.patera@eway-crm.com';
	SET @Body = 'A new Deal has been created. You can inspect it <a href="eway://Leads/' + CAST(@LeadGUID AS CHAR(36)) + '">here</a>.';
	SET @LeadFileAs = 'New Deal: ' + @LeadFileAs

	EXECUTE [dbo].[eWaySP_SendMail] @To, @Body, @LeadFileAs

END
GO

EXEC dbo.eWaySP_SetProcedureDescription 'eWaySP_NotifyAboutNewDeal', 'Notify about new deal for triggers examples.'
EXEC dbo.eWaySP_SetProcedureParameterDescription 'eWaySP_NotifyAboutNewDeal', '@LeadGUID', 'Lead GUID.'
EXEC dbo.eWaySP_SetProcedureParameterDescription 'eWaySP_NotifyAboutNewDeal', '@LeadFileAs', 'Lead name.'