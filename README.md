

# Work with triggers
This page should give you insight for how triggers work, what you can do with them and which parameters you can use.

##  Trigger definition
Trigger definition says when the trigger should be triggered.

### After/Before Save
This definition makes the trigger activate before or after saving an item. 
Click [here](TriggerDefinition/AfterSave/README.md) for example

### Scheduled at time
This definition makes the trigger activate on specific time.
Click [here](TriggerDefinition/ScheduledAtTime/README.md) for example

## Action type
Action type is what the trigger is "triggering". In most cases it is either "SroredProcedure" or "Executable".

### StoredProcedure
"StoredProcedure" trigger will activate stored procedure of your specification. This procedure must be stored on your local Database.

Click [here](ActionType/StoredProcedure/README.md) for example

### Executable
"Executable" trigger will activate .exe file of your specification.

Click [here](ActionType/Executable/README.md) for example
