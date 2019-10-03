
# Job trigger example
"ScheduledAtTime" trigger will activate at a specific time. Lets say you want to run Program.exe each hour, every day.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
  <Triggers>
  <TriggerDefinition When="ScheduledAtTime" Active="true">
    <Action Type="Executable">
      <Executable Target="C:\inetpub\wwwroot\eWay\bin\Program.exe" WaitingType="WaitInTransaction">
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
In this example we can see that the trigger definition is set to `When="ScheduledAtTime"`. That makes the trigger activate at specified time. The time is specified by action criteria.
There is also an option to choose, if the trigger will be handled as transaction. In this case, the trigger is supposed to "WaitInTransaction", meaning that The executable process will be launched inside transaction and we will also wait for it's ending. If an error occurs, the saving / removing transaction will fail like for example the SQL Triggers do.

## What will be activated
The trigger will activate Program.exe, so we have to supply programs path to the trigger like this  `Target="C:\inetpub\wwwroot\eWay\bin\Program.exe"`.

## Choosing time
By defining action criterias we can create our own schedule for trigger activation.

In this example the trigger will run each day at 00:40 and than subsequently after 60 minutes again and again. This cycle will repeat every day and should ensure activating the specified Executable or Stored Procedure each hour.