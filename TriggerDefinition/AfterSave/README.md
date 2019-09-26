# After save stored procedure trigger example
This example will show trigger, which send email, after Lead is saved. Lets say you as a overwatcher want to know when your subordinate create new Lead. For this, we will use this trigger:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
    <Triggers>
        <TriggerDefinition Active="true" When="AfterSave">
            <Folder>Leads</Folder>
            <Action Type="StoredProcedure">
                <StoredProcedures>
                    <StoredProcedure Name="TriggersExample_SendLeadNotification">
                        <Parameters>
                            <StoredProcedureParameter Name="@LeadFileAs" SourceName="FileAs" SqlDbType="NVarChar" />
                        </Parameters>
                    </StoredProcedure>
                </StoredProcedures>
                <Criterias>
                  <ActionCriteria Name="OwnerGUID" Operator="Equals" Value="#SQL SELECT U.[ItemGUID] FROM [Users] U WHERE U.[UserName] = 'user1'" />
                </Criterias>
            </Action>
        </TriggerDefinition>
    </Triggers>
</TriggersConfiguration>
```

## Circumstances of activation
Trigger definition "When" will define when the trigger will activate. Value "AfterSave" ensures that the activation will occur after saving an item in eWay-CRM. Also note the "Active" parameter. Its value can be either fase or true and determine that  even when the trigger is on your server, you can prevent its activation even when the circumstances of activation occures.

## Item which is being saved
We will specify the folder as "Leads", since we want the email to send only in case of Lead saving

## What will be activated
This trigger will be supposed to activate a SQL stored procedure. We specify that in "Action" section by stating `Type="StoredProcedure"`. We also have to specify name of that procedure. In this case that is `Name="TriggersExample_SendLeadNotification"`. This procedure must be saved on your server database.

## Procedure parameters
Our procedure have one input parameter. We want to supply it with name of Lead that is being saved. That means specifying:

Name - Name of the parameter in procedure `Name="@LeadFileAs"`

SourceName - Name of column from database, which will be supplied to the parameter `SourceName="FileAs"`

SqlDbType - Type of this parameter `SqlDbType="NVarChar"`


## Conditions
By action criteria, we can also specify more conditions for the activation. We want to be notified in case of the Lead being saved by the chosen subordinate. We can achieve that with this condition:

Name - Name of column on the current specified folder containing information we compare against `Name="OwnerGUID"`

Operator - Operator on which we determine if the condition is fulfilled `Operator="Equals"`

Value - Value which we compare against the column value` Value="#SQL SELECT U.[ItemGUID] FROM [Users] U WHERE U.[UserName] = 'user1'"`


The condition will thus compare value of "OwnerGUID" on the saved Lead against "Value" we specified. We could specified statically the GUID of User which our subordinate uses. Alternatively, as used here, we can use SQL statement by starting the value with `#SQL` followed by the statement. Here we select GUID of User with certain username (user1).

## Stored procedure
this is stored procedure that will be invoked by the trigger:

```SQL
CREATE PROCEDURE [dbo].[TriggersExample_SendLeadNotification]
(
	@LeadFileAs NVARCHAR(MAX)
)
AS
BEGIN

	SET NOCOUNT ON;

	SET XACT_ABORT ON;

	DECLARE @To NVARCHAR(MAX)
    DECLARE @Body NVARCHAR(MAX)

    SET @To = 'jiri.patera@eway-crm.com';
    SET @Body = 'A new Deal has been made.';

    EXECUTE [dbo].[eWaySP_SendMail] @To, @Body, @LeadFileAs

END
GO
```

On activation the trigger will supply input parameter `@LeadFileAs` with name of the Lead being saved, as we specified it. The procedure will result in sending an email to address provided by `@To` variable.

## Outcome
This series of actions should in getting this email:
![email](images/email.PNG)