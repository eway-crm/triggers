
# ScheduledAtTime
"ScheduledAtTime" trigger will activate at a specific time.
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
In this example we can see that the trigger definition is set to `When="ScheduledAtTime"`. That makes the trigger activate at specified time. The time is specified by action criteria. You define "Time" in h/m/s format in relation to midnight. Next you set "Repeat", that determines that your trigger will activate repeatedly. Here we have `Value="d"`, which means it will repeat every day.
Next is "IterationCount". Iteration is number of times that the trigger will activate within the chosen "Repeat" period. And lastly "Frequency". That is time after which the next iteration will start. Acoarding to our example, this trigger will activate in 00:40 and will activate 23 times in a day, each activation 60 minutes after the last one.