# Job trigger example
"ScheduledAtTime" trigger will activate at a specific time. Lets say you want to run Program.exe each hour, every day.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
  <Triggers>
  <TriggerDefinition When="ScheduledAtTime" Active="true">
    <Action Type="Executable">
      <Executable Target="C:\inetpub\wwwroot\Free_com\31994\bin\Program.exe" WaitingType="WaitInTransaction">
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
There is also an option to choose, if the trigger will be handled as transaction. This is done by assigning true or false to `WaitingType=""`.  It can have following values:

 - **WaitInTransaction**
The executable process will be launched inside the transaction repeater and we will also wait for its ending. The saving/removing routine does not end before the trigger process finishes. If a error occurs, the saving/removing transaction will fail like for example the SQL triggers do.

 - **WaitOutsideTransaction**
The executable process will be launched inside the transaction repeater and its handle will be saved. Later, after the transaction repeater finishes its work, the saving routine will wait for the process handle to end. If an error occurs, the saving/removing transaction is already committed and the ReturnCode will not be affected. An email will be however sent (like in queued jobs).
 
 - **NoWaiting**
The executable process will be launched inside the transaction repeater and the handle will not be stored.If an error occurs, the saving/removing transaction is already committed and the ReturnCode will not be affected. No email nor a log message is provided.

When choosing which option to use, note that you could find yourself in a deadlock situation. This can occur when the executable you want to trigger happens to call eWay-CRM API to work within folder name in which is the trigger also operating. For example, your trigger is "afterSave" on "Contacts" folder name and the executable is supposed to save some contact through API. Trigger is already working on "Contacts", prompting the executable to wait for the transaction to end, resulting in a deadlock.

## What will be activated
The trigger will activate Program.exe, so we have to supply programs path to the trigger like this  `Target="C:\inetpub\wwwroot\Free_com\31994\bin\Program.exe"`.

## Choosing time
By defining action criterias we can create our own schedule for trigger activation.

### Time
This criteria defines starting time for the trigger. The time format is `h:m:s`. The trigger will activate at the specified time, relative to 00:00. Here we have this value set to 00:40:00 (40 minutes after midnight).

### Repeat
Repeat determines your trigger will activate repeatedly. Here we have `Value="d"`, which means it will repeat every day. In this case each day at 00:40. This criteria can have following values:

"d" for daily

"wd" for daily but only on work days (Monday till Friday)

"w" for weekly

"m" for monthly

"y" for yearly


### Iteration count
Iteration is number of times that the trigger will activate. Its value is number. In this case the value is 23, so the trigger will activate each day  23 times . 
 
### Frequency
This is time after which the next iteration will start. It value is given in minutes. In this case we set it to 60, so the trigger will activate daily, 23 times after 60 minutes.

Configuration in this example will work this way. Each day at 00:40 and than subsequently after 60 minutes again and again. This cycle will repeat every day and should ensure activating the specified Executable or Stored Procedure each hour.