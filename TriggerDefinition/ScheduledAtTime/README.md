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
There is also an option to choose, if the trigger will be handled as transaction. This is done by assigning one of the values listed below in the `WaitingType=""` attribute.

* **WaitInTransaction**
The executable process will be launched inside the item's saving / removing transaction and we will also wait for it's ending.
If an error occurs, the saving / removing transaction will fail like for example the SQL Triggers do.
The saving / removing routine does not end before the trigger process finishes (eWay-CRM synchronization that caused the operation is waiting for the end).

* **WaitOutsideTransaction**
The executable process will be launched inside the transaction repeater and the process handle will be saved.
Later, after the transaction finishes its work, the saving routine will wait for the process handle to end.
If an error occurs, the saving / removing transaction is already committed and the ReturnCode will not be affected.
An email will be however sent to the SystemHealthNotification group.
The saving / removing routine does not end before the trigger process finishes (eWay-CRM synchronization that caused the operation is waiting for the end).

* **NoWaiting**
The executable process will be launched inside the transaction repeater and the process handle will not be stored.
If an error occurs, the saving / removing transaction is already committed and the ReturnCode will not be affected.
No email nor a log message is provided.

Note that using WaitInTransaction may cause a deadlock. This may occur when the executable you want to trigger saves data back to the eWay-CRM using eWay-CRM API.

## What will be activated
The trigger will activate Program.exe, so we have to supply programs path to the trigger like this  `Target="C:\inetpub\wwwroot\eWay\bin\Program.exe"`.

## Choosing time
By defining action criterias we can create our own schedule for trigger activation.

In this example the trigger will run each day at 00:40 and than subsequently after 60 minutes again and again. This cycle will repeat every day and should ensure activating the specified Executable or Stored Procedure each hour.