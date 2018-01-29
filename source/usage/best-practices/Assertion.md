# Assertion

## Check non null

It is recommended to use `Objects.requireNonNull` (with `Objects` being the one of Java 8):
```java
Objects.requireNonNull(executionResult, "executionResult must not be null");
```

## More advanced conditions

As for more advanced conditions, it is recommended to use Guava's `Preconditions`.

## In Wicket code

In Wicket code, you can use `Args.notNull`, `Args.notEmpty`, `Args.isTrue`, `Args.isFalse`. Be careful to use the `Args` class from Wicket.
