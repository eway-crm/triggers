
# AfterSave
"AfterSave" trigger will activate after saving item in eWay-CRM.
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
In this example we can see that the trigger definition is set to `When="Executable"`. That makes the trigger activate after saving an item in  eWay-CRM. The type of item is defined in "Folder" definition. You can find list of these folders here. You can also use "All" instead of fold name, which means that the trigger will activate after any save. This is not really advisable, because besides manual saving, eWay-CRM also makes numerous saves on items which cannot be save manually. In this example, the specified folder is "Contacts", which means every time a contact is saved, that is either manually or as a result of some other string of actions, the trigger will execute.