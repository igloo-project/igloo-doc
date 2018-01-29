# Hibernate Interceptors

You can declare Spring managed Hibernate interceptors by adding an `hibernateInterceptor()` method in `YourAppCoreCommonJpaConfig`:

```java
        @Bean
        public Interceptor hibernateInterceptor() {
                return new ChainedInterceptor()
                                .add(new YourInterceptor());
        }
```

The `ChainedInterceptor` is a class we provide to be able to chain multiple Hibernate interceptors.

For an example of implementation, see:
* https://github.com/igloo-project/igloo-parent/blob/dev/igloo/igloo-components/igloo-component-jpa-externallinkchecker/src/main/java/org/iglooproject/jpa/externallinkchecker/business/interceptor/ExternalLinkWrapperInterceptor.java
* https://github.com/igloo-project/igloo-parent/blob/dev/igloo/igloo-components/igloo-component-jpa-externallinkchecker/src/main/java/org/iglooproject/jpa/externallinkchecker/business/model/ExternalLinkWrapper.java#L178
