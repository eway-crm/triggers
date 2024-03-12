# Breaking Changes

## 8.1

### ItemChanges

ItemVersion column in EWD_ItemChanges became required.

Starting with version 8.1 you may notice the following error in your triggers:

```
Cannot insert the value NULL into column 'ItemVersion', table 'dbo.EWD_ItemChanges'
```

When saving single item make sure to call **eWaySP_InsertIntoItemChanges** procedure. It will automatically fill ItemVersion.

When saving multiple items use our [Update multiple items snippet](https://github.com/eway-crm/Snippets).