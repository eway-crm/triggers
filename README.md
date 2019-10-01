# Work with Triggers
This page should give you insight on how triggers work, what you can do with them and which parameters you can use.

## Use good XLM editor with XSD validation
To work with XML Triggers we advise to use Microsoft Visual Studio. You can download free version [here](https://visualstudio.microsoft.com/downloads/). Click on download and then install the application. Once you have it installed, open Visual Studio and click on "File", "New" and then "File..." in next context menu.

![New file](NewFile.png)

File type selection then appears. Here you have to choose "XML File". While this option is chosen, click on "Open" Button to open the new file.

![Open](Open.png)

This new file will be empty XML File with only standard definition `<?xml version="1.0" encoding="utf-8"?>` on the first line.

![Empty file](EmptyFile.png)

## Download XSD Schema for validation of Triggers

We have provided our XSD definition schema for [download](https://github.com/eway-crm/triggers/raw/master/Triggers.xsd). If you do so, you can use it in Visual Studio to validate your XML Trigger. To use it, right click into the opened XML file and go to Properties. In "Schemas" specify path to the downloaded XSD file.

![Properties](Properties.png)

Now you can start creating your Trigger.

## Standard trigger configuration
Every Trigger should start with a standard specification:
```xml
<?xml version="1.0" encoding="utf-8"?>
<TriggersConfiguration xmlns="urn:eway:document-schemas:triggers-configuration">
    <Triggers>
    
    </Triggers>
</TriggersConfiguration>
```

##  Choose when the trigger will be activated
Trigger definition gives the Trigger information when it should be activated. This can be either by action such as delete or save or by specifying time of activation.
```xml
<TriggerDefinition Active="" When="">
</TriggerDefinition>
```
"Active" can be either true or false. That indicates, if the trigger will be executed. Perhaps you want to have it inactive for some time, but don't want to delete it, you set it to false. You can also fit more than one trigger definitions inside `<Triggers></Triggers>`, resulting in having multiple triggers in one file.

"When" than defines what action will activate the Trigger. Item related actions are called **[Triggers](Trigger)** (BeforeSave, AfterSave, ...), time related actions are called **[Jobs](Job)** (ScheduledAtTime).
* BeforeSave
* AfterSave
* BeforeRemove
* AfterRemove
* ScheduledAtTime

### Trigger
This definition makes the trigger activate on specified item action. Bellow is link to example of "AfterSave" activation. That means the trigger will activate after an item in eWay-CRM is saved.

Click [here](TriggerDefinition/AfterSave/README.md) for example

In this case we additionally have to specify "FolderName". That defines on which eWay-CRM Item will we observe the action.
```xml
<Folder></Folder>
```
To ease understanding folder names, look [here](https://github.com/eway-crm/php-lib/blob/master/FolderNames.md).

### Job
This definition makes the trigger activate on specific time. That means either just once, or periodically in times of your own choosing.

Click [here](TriggerDefinition/ScheduledAtTime/README.md) for example

## What is it that you want to trigger?
Action type is what the trigger is "triggering". That could be either executable program or stored SQL procedure.

### StoredProcedure
"StoredProcedure" trigger will activate stored procedure of your specification. This procedure must be stored on your local Database. You can fit more than one definition of stored procedure in here, in case you want to activate multiple procedures by the trigger.
```xml
<Action Type="StoredProcedure">
	<StoredProcedures>
	    <StoredProcedure Name="">
	    
		</StoredProcedure>
	</StoredProcedures>    
</Action>
```
Click [here](ActionType/StoredProcedure/README.md) for example.

For the procedure to have correct format, please use our SQL snippet with predefined templates. You can find that [here](https://github.com/eway-crm/Snippets).

Writting triggers requires T-SQL knowledge. Checkout our [Database Schema](https://dev.eway-crm.com/docs/database-schema.html) to find a lot of system procedures and functions that can be used right away.

### Executable
"Executable" trigger will activate .exe file of your specification.

```xml
<Action Type="Executable">
	<Executable Target="">
    </Executable>
    
</Action>
```
Click [here](ActionType/Executable/README.md) for example.

## Define the triggers specifics
With type of activating and activation target chosen, you can now focus on detailing the specifics of the trigger. That means procedure parameters for "storedProcedure" trigger and action criteria for both types of trigger.

### Stored procedure parameter
When creating trigger which activates stored procedure, we will possibly want to supply the procedure with input parameters. If the procedure doesn't have any, than we are set can leave this be. Otherwise we have to specify value for each input parameter the procedure has.

```xml
<Parameters>
    <StoredProcedureParameter Name="" SourceName="" SqlDbType="" />
</Parameters>
```

### Action criteria
Action criteria narrows the conditions for activation even more. In case of "Job", we define the specific time by them. In other cases we can check whether some column has expected value.

```xml
<Criterias>
	<ActionCriteria Name="" Value=""/>
	<ActionCriteria Name="" Operator="" Value="" />
</Criterias>
```
