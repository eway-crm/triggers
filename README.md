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

"When" than defines what action will activate the Trigger. Item related actions are called **[Triggers](#Trigger)** (BeforeSave, AfterSave, ...), time related actions are called **[Jobs](#Job)** (ScheduledAtTime).
* BeforeSave
* AfterSave
* BeforeRemove
* AfterRemove
* ScheduledAtTime

### Trigger
This definition makes the trigger activate on specified item action. Bellow is link to example of "AfterSave" action. That means the trigger will activate after an item in eWay-CRM is saved.

Click [here](TriggerDefinition/AfterSave/README.md) for example

In this case we additionally have to specify "FolderName". That defines on which item will the action be executed.
```xml
<Folder></Folder>
```
To ease understanding Folder names, look [here](https://github.com/eway-crm/php-lib/blob/master/FolderNames.md).

### Job
This definition makes the trigger activate at specific time. That means either just once, or periodically in times of your own choosing.

Click [here](TriggerDefinition/ScheduledAtTime/README.md) for example

## What action you want to trigger?
Action type specifies whether you want to execute [T-SQL Store Procedure](#Stored Procedure) or [Executable program](#Executable).

### Stored Procedure
"StoredProcedure" trigger will activate Stored Procedure of your specification. This procedure must be stored on the eWay-CRM server database. You can fit more than one definition of stored procedure in here, in case you want to activate multiple procedures at once.
```xml
<Action Type="StoredProcedure">
	<StoredProcedures>
		<StoredProcedure Name="">

		</StoredProcedure>
	</StoredProcedures> 
</Action>
```

Stored Procedure parameters are defined in the Parameters tag.

```xml
<Parameters>
    <StoredProcedureParameter Name="" SourceName="" SqlDbType="" />
</Parameters>
```

Click [here](TriggerDefinition/AfterSave/README.md) for example.

Please use our template to create T-SQL Procedure. You can find it in our [Snippets](https://github.com/eway-crm/Snippets).

Writting triggers requires T-SQL knowledge. Checkout our [Database Schema](https://dev.eway-crm.com/docs/database-schema.html) to find description of standard system Procedures and Functions that can be used right away.

### Executable
"Executable" trigger will activate .exe file of your specification.

```xml
<Action Type="Executable">
	<Executable Target="">
	</Executable>
</Action>
```
Click [here](TriggerDefinition/ScheduledAtTime/README.md) for example.

## Action criteria
Action criteria specifies conditions that indicates whether the trigger will be activated for the item or not by checking item's value on a specified column.

In case of [Job](#Job), we define time of the execution.

```xml
<Criterias>
	<ActionCriteria Name="" Value=""/>
	<ActionCriteria Name="" Operator="" Value="" />
</Criterias>
```
Here is a list of variables that can be used in action criteria:

 - **SourceName**
 Name of the database column.
 
 - **Name**
 Name of the input parameter in stored procedure.
 
 - **NeedLoadSource**
 Boolean indication, if the criteria need a load source.
 
 - **SqlDbType**
 Type of the variable in stored procedure.
 
 - **Value**
 Value of the variable.
 
 - **UsePreviousValue**
 Use variable from the previous criteria.
 
 - **UseCurrentFolder**
 Use current folder as value.

