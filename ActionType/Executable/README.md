# Executable
"Executable" trigger will activate .exe file of your specification.
```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
  <Triggers>
  <TriggerDefinition When="ScheduledAtTime" Active="true">
    <Action Type="Executable">
      <Executable Target="C:\inetpub\eWay\bin\LeadyConnector\LeadyConnector.exe" WaitForProcessEnd="true">
      </Executable>
      <Criterias>
        <ActionCriteria Name="Time" Value="00:40:00"/>
        <ActionCriteria Name="Repeat" Value="d" />
        <ActionCriteria Name="IterationCount" Value="23"/>
        <ActionCriteria Name="Frequency" Value="60"/>
      </Criterias>
    </Action>
  </TriggerDefinition>
  </Triggers>
</TriggersConfiguration>
```
In this example we can see that the action is set to `Type="Executable"`. This informs the trigger to invoke certain executable file located on your disc. Executable file, which will be invoked is defined in `<Executable>` by its target location. 