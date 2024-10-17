# Testcontainers

## Existing project migration

* (gitlab docker runner) CI/CD must enable docker:dind
* Add test TextExecutionListener on test or test superclass
  (merge with existing config if needed)
* Add (or merge) `@Import({PSQLTestContainerConfiguration.class})`
  in your test spring configuration
* Replace in `configuration-env-test.properties` database related
  properties (see snippet below) 
* These steps should be enough to run your tests successfully
* Add `@SqlMergeMode(SqlMergeMode.MergeMode.MERGE)` to allow
  common + specialized initialization (see snippet below)
* Add `@Sql(scripts = "/scripts/init-data-test.sql")` and a
  init file in `src/test/resources/scripts`
* Optional : translate existing initialization to SQL
* Optional : remove database cleaning code (TestExecutionListener
  perform database cleaning)
* Shutdown your existing postgresql and check test execution


```java
@TestExecutionListeners(
    value = {SetupAndCleanDatabaseTestExecutionListener.class},
    mergeMode =
        TestExecutionListeners.MergeMode
            .MERGE_WITH_DEFAULTS // Retains default TestExecutionListeners.
    )
```

```ini
# Remove spring database-related properties
spring.datasource.url=jdbc:postgresql://${TEST_DB_HOST:localhost}:${TEST_DB_PORT:5436}/${TEST_DB_NAME:basic_application_test}
spring.datasource.username=${TEST_DB_USER:basic_application_test}
spring.datasource.password=${TEST_DB_PASSWORD:basic_application_test}
spring.jpa.properties.hibernate.default_schema=${TEST_DB_USER:basic_application_test}
spring.flyway.defaultSchema=${TEST_DB_USER:basic_application_test}
db.schema=${TEST_DB_USER:basic_application_test}

# Add testcontainers and static schema definition properties
spring.jpa.properties.hibernate.default_schema=basic_application_test
spring.flyway.defaultSchema=basic_application_test
db.schema=basic_application_test
spring.flyway.clean-disabled=false
testContainer.database.name=basic_application_test
testContainer.database.userName=basic_application_test
testContainer.database.password=basic_application_test
testContainer.database.exposedPorts=5432
testContainer.database.dockerImageName=postgres:17-alpine
```