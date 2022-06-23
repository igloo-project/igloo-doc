# Igloo Spring Boot

Since version 1.24, basic-application java configuration is mostly managed with a custom spring-boot auto configuration annotation.

## Spring-boot autoconfiguration

If you want to know more about how to declare your own spring-boot auto configuration annotation and how it works,
you can read about it [here](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-developing-auto-configuration.html).

The short explanation is, it works with a package of `@Configuration` classes,
each with `@Conditional` annotations to constrain when the auto configuration should apply.

## @EnableIglooAutoConfiguration

Our custom spring-boot class is named `@EnableIglooAutoConfiguration`.
All the classes gathered under this annotation are located in the package [org.igloo.spring.autoconfigure](https://github.com/igloo-project/igloo-parent/tree/dev/igloo/igloo-components/igloo-spring-autoconfigure/src/main/java/org/igloo/spring/autoconfigure).

The class which contains `@EnableIglooAutoConfiguration` in the basic-application configuration is [BasicApplicationCoreCommonConfig](https://github.com/igloo-project/igloo-parent/blob/dev/basic-application/basic-application-core/src/main/java/org/iglooproject/basicapp/core/config/spring/BasicApplicationCoreCommonConfig.java).

The spring-boot auto configuration is triggered after the declarative java configuration,
which means that all the @Conditional parameters will be checked after you have manually declared what you want.

You can enable auto configuration report by adding `debug=true` in the application.properties file.
This will display all the positive and negative matches made by spring-boot when verifying your conditional parameters.

## Details on specific auto configurations

We have declared under the annotation `@EnableIglooAutoConfiguration` a lot of beans mandatory for the basic-application,
but we have left some beans that you have to declare manually. We have also declared some beans with
naive implementations in order to make it easy to begin a new application,
but it is not safe to keep them and they must be override.

For instance, in the Property auto configuration we have declared a basic implementation of a IPropertyRegistryConfig bean,
but it will not register any properties. You have to declare your own in order to make it works properly.

In the security auto configuration, you have several things to override. First, the application needs
the property `security.runAsKey`, then you also need to make your own beans `ICorePermissionEvaluator`
and `ISecurityUserService`. Those provided by default are unusable in a real application.

In the TaskManagement auto configuration, you have to provide your own bean `Collection<? extends IQueueId>`.

Finally, in the Wicket auto configuration, you need to declare your specific `WebApplication` bean.

## Check autoconfiguration behavior

* Add dedicated spring context initializer : `org.springframework.boot.autoconfigure.logging.ConditionEvaluationReportLoggingListener`
* Configure `org.springframework.boot.autoconfigure` logger to `DEBUG`

For a web spring context, add `org.springframework.boot.autoconfigure.logging.ConditionEvaluationReportLoggingListener` to `contextInitializerClasses` configuration:

```xml
        <context-param>
                <param-name>contextInitializerClasses</param-name>
                <param-value>org.iglooproject.config.bootstrap.spring.ExtendedApplicationContextInitializer,org.springframework.boot.autoconfigure.logging.ConditionEvaluationReportLoggingListener</param-value>
        </context-param>

```

For a log4j2 configuration, add a logger configuration:

```ini
logger.autoconfig.name=org.springframework.boot.autoconfigure
logger.autoconfig.level=DEBUG
```