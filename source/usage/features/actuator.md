(spring-boot-actuator)=

# Spring Boot actuator

Spring boot actuator can be enabled on Igloo application. It provides a default
security configuration to handle `/actuator` endpoint accesses and some sensible
default configuration.


## How to enable

Add `org.iglooproject.components:igloo-spring-actuator` dependency to you `front`
project module.

Check that http://localhost:8080/actuator/health endpoint is available.

Other endpoints are protected by basic authentication:
* http://localhost:8080/actuator/prometheus : accessible by `prometheus` and `actuator` user.
* http://localhost:8080/actuator/* : accessible by `actuator` user.

By default, password is generated at application startup and displayed by
`igloo.actuator.ActuatorAutoConfiguration` logger.

```
[2024-09-10T17:25:59,987] WARN  - ActuatorAutoConfiguration  -  - 
Using generated security password: actuator:302b9851-b39c-450c-8a6f-8a1c2e86ea71
This generated password is for development use only. Your security configuration must be updated before running your application in production.

[2024-09-10T17:25:59,988] WARN  - ActuatorAutoConfiguration  -  - 
Using generated security password: prometheus:72a36645-2a7e-416b-9e42-24aee24be422
This generated password is for development use only. Your security configuration must be updated before running your application in production.
```

For production usage, password can be set in configuration files.

## How to configure

Igloo provides some specific configuration option for user management.

Igloo reuses Spring Boot standard configuration configuration from https://docs.spring.io/spring-boot/reference/actuator/endpoints.html

```
# Specific Igloo configuration

# Disable whole actuator feature
igloo.actuator.enabled=false

# Configure a static password for production usage
igloo.actuator.security.actuator.password=XXX
igloo.actuator.security.prometheus.password=XXX

# Standard Igloo boot setup

# Disable actuator prometheus export
management.prometheus.metrics.export.enabled=false
# Provide custom metric labels
management.metrics.tags.label_name=label_value

# Re-enable ldap health contributor
management.health.ldap.enabled=true
```

The following dependencies can be removed to restrict actuator auto-configuration :
* io.micrometer:micrometer-registry-prometheus (metrics and prometheus export)
* io.github.resilience4j:resilience4j-spring-boot3 (resilience4j registries and metric
  export)

## Under the hood

`igloo-spring-actuator` is a thin layer above spring-boot-actuator providing :

* Spring Security Web handling :
  * Use a separate and isolated authentication manager (not published as a bean
    so that it does not interfere with existing configurations)
  * Load user credentials from configuration file, with pre-determined roles
  * Use 2 user accounts : one dedicated to prometheus, one for administration
  * SecurityFilterChain is injected with a high priority, but restricted
    to controllers provided by spring-actuator
* Sensible defaults in classpath configuration `igloo-actuator/actuator.properties`
  * Enable all endpoints
  * Disable LDAP health contribution (as it is installed when no LDAP configuration
    is available and fails)
  * Enable JMX integration

## How to use

Please refer to https://docs.spring.io/spring-boot/reference/actuator/endpoints.html for exhaustive
documentation.

The following commands are known to work with a default setup.

```
PROMETHEUS_CREDENTIALS=prometheus:72a36645-2a7e-416b-9e42-24aee24be422
ACTUATOR_CREDENTIALS=actuator:302b9851-b39c-450c-8a6f-8a1c2e86ea71

curl -s -u "$PROMETHEUS_CREDENTIALS" http://localhost:8080/actuator/prometheus
# Health detail are available only for authenticated user
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/health | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/env | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/beans | jq
# https://docs.spring.io/spring-boot/api/rest/actuator/caches.html
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/caches | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/conditions | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/configprops | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/env | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/flyway | jq
# Empty for a default app
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/info | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/loggers | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/metrics | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/mappings | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/scheduledtasks | jq
# Empty as sessions are not handled by Spring
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/sessions | jq
# Only if a BufferingApplicationStartup is configured (not done by default)
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/startup | jq
curl -s -u "$ACTUATOR_CREDENTIALS" http://localhost:8080/actuator/threaddump | jq
```