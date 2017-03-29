# HistoryLog & Audit

## Principles

The history log machinery is designed to track the action performed on our business entities.

It can also be used to track the differences but this feature should be used with caution as it can be quite time consuming to configure and has a negative impact on performance.

Logs are performed upon commit (just before the commit), in order to:

 * Remove duplicate logs
 * Ensure that all edits on the entities are over, so that a diff can safely be computed

**Warning:** Please note that when performing a batch processing, you should take care of calling `ITransactionSynchronizationTaskManagerService.beforeClear()` before flushing the indexes and clearing the Hibernate session, so that the logs can be safely flushed too.

## Using it in your application

### Setting up

The basic application provide a basic (but functional) template for setting up the HistoryLog. See package `fr.openwide.core.basicapp.core.business.history` for more information.

The minimal set of classes to define includes:
 * The concrete enum representing `HistoryEvents` (create, update, sign-in, ...)
 * The concrete class for your `HistoryLog`s, with (optionally) custom fields.
 * Your `HistoryLogDao` and `HistoryLogService`, which may simply extend the provided abstract classes
 * Your own implementation of the bean that will store additional informations about log objects: `HistoryLogAdditionalInformationBean`. This bean serves as a way to pass additional parameters to the `HistoryLogService`: secondary objects (for actions performed on more than one object), contextual information (to enable later search on logs with filters on objects *linked* to the main object at the time of the action), ... **It's typically not recommended to randomly use the object1...4 fields (see `AbstractHistoryLogAdditionalInformationBean` for more information).**

You may also want to define a `HistoryLogSearchQuery` for querying you history. An example is provided in the basic application.

### Recording simple logs

```java
historyLogService.log(HistoryEventType.SIGN_IN, user, HistoryLogAdditionalInformationBean.of(user));
```

### Recording diff-enabled logs

Linking a full diff of the main object to the  log:
```java
historyLogService.logWithDifferences(HistoryEventType.UPDATE, person, HistoryLogAdditionalInformationBean.of(person), userDifferenceService);
```

The code above will add to the log every change on every relevant fields of the given entity. This is typically what we do upon updates.

Sometimes, though, you only want to record changes on a subset of the entity fields. This is typically what's required upon create/delete (where we know that almost all fields will change), but it may be done upon updates, too.

Here's how to link a minimal diff of the main object to the log:
```java
historyLogService.logWithDifferences(HistoryEventType.UPDATE, person,
				HistoryLogAdditionalInformationBean.of(person),
				userDifferenceService.getMinimalDifferenceGenerator(),
				userDifferenceService);
```

Optionnally, you may pass to those methods one or several `IDifferenceHandler<T>`, which are ways for you to inspect a diff, and do something based on that information. This is typically used to update a date on the entity when some field changed.

For more information about setting up a difference service, see [[DifferenceService]].

## Displaying the logs on the user interface

### Basic stuff

The basic application contains everything needed to display the audit. See `UserHistoryLogPanel`.

### Renderers/Converters

The history log machinery uses the renderers/converters infrastructure so you need to define either converters (in your `YourAppApplication.newConverterLocator()` or renderers (in `YourAppWebappConfig.rendererService()`).

### Resource keys for difference display

When the label of a field needs to be displayed, several resource keys are tried, in this order:

 * `history.difference<entity resource key>.<property.path>`
 * `business<entity resource key>.<property path>`
 * `history.difference.common.<property.path>`
 * `business.<property path>`

The first key that actually exists in you properties is used.
This behavior is defined in the basic application class `HistoryDifferencePathRenderer`.

The resource key for each entity is defined in `AbstractHistoryRenderer`.
