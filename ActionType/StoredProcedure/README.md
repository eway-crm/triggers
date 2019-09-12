
# StoredProcedure
"StoredProcedure" trigger will activate stored procedure of your specification. This procedure must be stored on your local Database.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
  <Triggers>

    <TriggerDefinition When="AfterSave" Active="true">
      <Folder>Contacts</Folder>
      <Action Type="StoredProcedure">
        <StoredProcedures>
          <StoredProcedure Name="eWaySP_UpdateInfoOnLeadFromContact">
            <Parameters>
              <StoredProcedureParameter Name="@ContactGUID" SourceName="ItemGUID" SqlDbType="UniqueIdentifier"/>
            </Parameters>
          </StoredProcedure>
        </StoredProcedures>
      </Action>
    </TriggerDefinition>
    
  </Triggers>

</TriggersConfiguration>
```
In this example we can see that the action is set to `Type="StoredProcedure"`. This informs the trigger to invoke certain procedure stored i your database system. Procedure, which will be invoked is defined in `<StoredProcedure>` by its name. 