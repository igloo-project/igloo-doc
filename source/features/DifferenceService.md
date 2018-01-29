# Difference Service (TODO)

## Principles

Igloo provides a way for applications to compute a diff between two objects, i.e. of recursively computing field-by-field differences between a "working" version and a "reference" version of an object.

The diff infrastructure is powered by [Java-object-diff](https://github.com/SQiShER/java-object-diff). Igloo itself provides:

 * basic setup of java-object-diff
 * abstract bases for your diff services, with clearly identified points of configuration
 * interfaces to integrate your diff services to other parts of your application (mainly [HistoryLog & Audit](HistoryLog-&-Audit.html))
 * a way for you to perform a diff between an object in your Hibernate session and the version currently in your database

## Using it in your application

### Setting up

TODO: this part is still evolving. See https://trello.com/c/gUTpyoMr in particular.

### Performing a diff between two objects

```java
// Obtain your IDifferenceGenerator
// You may also use differenceService.getMinimalDifferenceGenerator(), depending on your use case
IDifferenceGenerator generator = differenceService.getMainDifferenceGenerator();
// Perform the  diff
Difference<T> diff = generator.diff(workingObject, referenceObject);
```

### Performing a diff between your (modified) object and the version in your DB

```java
// Obtain your IDifferenceGenerator
// You may also use differenceService.getMinimalDifferenceGenerator(), depending on your use case
IDifferenceFromReferenceGenerator generator = differenceService.getMainDifferenceGenerator();
// Perform the  diff
Difference<T> diff = generator.diffFromReference(workingObject);
```

### Using it in the history log machinery

See [HistoryLog & Audit](HistoryLog-&-Audit.html).
