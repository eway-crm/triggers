# Job trigger example
"ScheduledAtTime" trigger will activate at a specific time. Lets say you want to run Program.exe each hour, every day.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
  <Triggers>
  <TriggerDefinition When="ScheduledAtTime" Active="true">
    <Action Type="Executable">
      <Executable Target="C:\inetpub\wwwroot\Free_com\31994\bin\Program.exe" WaitForProcessEnd="true">
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

## What will be activated
The trigger will activate Program.exe, so we have to supply programs path to the trigger like this  `Target="C:\inetpub\wwwroot\Free_com\31994\bin\Program.exe"`.

## Choosing time
By defining action criterias we can create our own schedule for trigger activation

### Time
 This criteria defines starting time for the trigger. The time format is h : m : s. The trigger will activate at the set time, relative to 00:00. Here we have this value set to 00:40:00 (40 minutes after midnight). That means, if you set the trigger to "active" at time 00:39, it will activate in the next minute. However if you set it to "active" at 00:41, it will activate after 23 hours and 59 minutes. Take notice, that the time which the trigger checks is time on your server.

### Repeat
Repeat determines your trigger will activate repeatedly. Here we have `Value="d"`, which means it will repeat every day. In this case each day at 0:40. This criteria can have following values:

"d" for daily

"wd" for daily but only on week days

"w" for weekly

"m" for monthly

"y" for yearly


### Iteration count
Iteration is number of times that the trigger will activate. Its value is number. In this case the value is 23, so the trigger will activate each day  23 times . 
 
### Frequency
This is time after which the next iteration will start. It value is given in minutes. In this case we set it to 60, so the trigger will activate daily, 23 times after 60 minutes.

Configuration in this example will work this way. Each day at 00:40 and than subsequently after 60 minutes again and again. This cycle will repeat every day and should ensure activating the specified executable/procedure each hour the trigger is active.