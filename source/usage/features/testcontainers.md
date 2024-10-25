
(testcontainers)=

# Testcontainers

## TLDR

By using `@TestExecutionListeners(mergeMode = TestExecutionListeners.MergeMode.MERGE_WITH_DEFAULTS)`
and importing `PsqlTestContainerConfiguration` in your Spring context on Spring boot managed tests, the following behavior
are configured automatically :

* A postgresql container using a dynamic port is started with tests
* Spring datasource is automatically reconfigured to use the postgresql container
* Flyway migration is performed at spring startup time
* Before `@Sql` spring handling, the following tasks are performed
  * Database cleaning by truncating tables (PostgreSQL only) ; flyway migration table is kept untouched
  * Second level cache cleaning
  * Hibernate search index cleaning
* After `@Sql` spring handling, the following tasks are performed
  * Hibernate search reindexation

All the configuration are managed by spring autoconfigure, and only available and configured items are triggered.

If `@TestInstance(TestInstance.Lifecycle.PER_CLASS)` is used, cleaning/reindexing is performed on class
lifecycle.

## Configurations

It is possible to customize some behavior :

* `igloo.test.listener.cache-level2.enabled=false` to disable level 2 cache handling
* `igloo.test.listener.hsearch.enabled=false` to disable hibernate-search handling
* `igloo.test.listener.psql.enabled=false` to disable postgresql handling
* `igloo.test.listener.psql.excludes=*.table,schema.*,schema.table` to exclude tables from cleaning
* `igloo.test.listener.psql.=*.table,schema.*,schema.table` to exclude tables from cleaning
* `igloo.test.listener.psql.exclude-flyway-table=false` **not** to exclude flyway migration table

Default configuration is to enable all available and configured cleans, and to exclude flyway migration
table from cleaning.

## How does it work

The setup is based on the following items :

* `IglooTestExecutionListener` and `AfterSqlIglooTestExecutionListener` auto-registered `TestExecutionListener`
  (with `META-INF/spring.factories` configuration file)
* `IIglooTestListener` beans. A name matching is used to bind each `IIglooTestListener` to the
  appropriate `TestExecutionListener` (either `default` or `after-sql` for the auto-configured ones)
* `*IglooTestListenerAutoConfiguration`, auto-registered with `META-INF/spring/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` to instantiate conditionaly the appropriate `IIglooTestListener` based on classpath and bean conditions.

`HsearchUtil` and `PsqlUtil` performs the actual cleaning tasks.

## Troubleshooting

If you encounter some issues, you may check the following items :

* If datasource is not bind to datasource, you may check that (with breakpoint on constructor) :
  * `JdbcContainerConnectionDetails` is created
  * No `PropertiesJdbcConnectionDetails` is created
  * `DataSourceAutoConfiguration` is loaded
  * `ServiceConnectionAutoConfiguration` is loaded
  * You may need to add `HikariCP` dependency to trigger `DataSourceAutoConfiguration`
* Ensure that `IglooTestExecutionListener` and `AfterSqlIglooTestExecutionListener` are created. If not,
  check the `@TestExecutionListener#mergeMode` setting, or register manually these listeners
* If you migrate to testcontainers, and tests complains about a missing `EntityManager`, check that you
  keep `EntityManagerExecutionListener` when you migrate `@TestExecutionListeners`
* If `@Sql` are not applied, check that `SqlScriptsTestExecutionListener` is created. If not, the
  `@TestExecutionListener#mergeMode` setting.
* You can activate `igloo.test.listener` logger at info or debug level to check which listeners are triggered
* You can place breakpoints in `IIglooTestListener` subclasses to check if and when callbacks are triggered
* You can place a breakpoint and use `docker ps` to check the container port and connect with
  `psql -U USER -p PORT -h localhost`

## Power-user

It is possible to declare new `IIglooTestListener`. You need to choose an appropriate name to bind to the
appropriate `IglooTestExecutionListener` or `AfterSqlIglooTestExecutionListener`.

If you bind to `IglooTestExecutionListener` or `AfterSqlIglooTestExecutionListener`, `before` and `after` methods
are called on before/after test method or class, based on `@TestInstance` setting.

You can subclass one of `IglooTestExecutionListener` subclasses if you want to handle before / after binding
differently. If so, declare new `IIglooTestListener` with a customized name matching. There is subclass for the
following use-cases :
* IglooAnyTestExecutionListener : each step call `IIglooTestListener`; appropriate handling can be performed
  with the `IglooTestListenerType` argument.
* IglooClassTestExecutionListener : `IIglooTestListener` is invoked only for before / after class (ignoring `@TestInstance`)
* IglooMethodTestExecutionListener : `IIglooTestListener` is invoked only for before / after method (ignoring `@TestInstance`)
* IglooExecutionTestExecutionListener : `IIglooTestListener` is invoked only for before / after execution (ignoring `@TestInstance`)

If you use a custom `IglooExecutionTestExecutionListener`, it is up to you to register it (`@TestExecutionListeners`
annotation or `META-INF/spring.factories`).

(testcontainers-migration)=

## Testcontainers migration

* (gitlab docker runner) CI/CD must enable docker:dind
* Use `mergeMode = MergeMode.MERGE_WITH_DEFAULTS` on `@TestExecutionListeners`
* Add (or merge) `@Import({PsqlTestContainerConfiguration.class})`
  in your test spring configuration
* Replace in `configuration-env-test.properties` database related
  properties (see snippet below)
* Shutdown your postgresql test instance
* These steps should be enough to run your tests successfully
* Optional : remove database cleaning code (IglooTestExecutionListener
  default setup handles database, second level cache, and database cleaning)
  * remove calls to `AbstractTestCase#init()`
  * remove dead code `cleanAll`, `cleanReferenceData`
* Check again test execution
* Optional : translate existing initialization to SQL
* Optional : add `@SqlMergeMode(SqlMergeMode.MergeMode.MERGE)` to allow
  common + specialized initialization (see snippet below)
* Optional : add `@Sql(scripts = "/scripts/init-data-test.sql")` and a
  init file in `src/test/resources/scripts`

**`@SpringBootTest..` annotation or `ApplicationCoreTestCommonConfig`**

```java
@Import({ApplicationCoreCommonConfiguration.class, PsqlTestContainerConfiguration.class})
```

**TestExecutionListeners configuration**

Search `TestExecutionListeners` occurrences.

Spring listeners can be removed; they are loaded by `MERGE_WITH_DEFAULTS`.
`EntityManagerExecutionListener` must be kept if already present.

```java
@TestExecutionListeners(
    listeners =  EntityManagerExecutionListener.class,
    mergeMode =
        TestExecutionListeners.MergeMode
            .MERGE_WITH_DEFAULTS // Retains default TestExecutionListeners.
    )
```

**configuration-env-test.properties**

Remove `spring.datasource.*` setup, and add `PsqlTestContainerConfiguration` configurations.

```ini
# REMOVE spring database-related properties
spring.datasource.url=jdbc:postgresql://${TEST_DB_HOST:localhost}:${TEST_DB_PORT:5436}/${TEST_DB_NAME:basic_application_test}
spring.datasource.username=${TEST_DB_USER:basic_application_test}
spring.datasource.password=${TEST_DB_PASSWORD:basic_application_test}
spring.jpa.properties.hibernate.default_schema=${TEST_DB_USER:basic_application_test}
spring.flyway.defaultSchema=${TEST_DB_USER:basic_application_test}
db.schema=${TEST_DB_USER:basic_application_test}

# ADD testcontainers and static schema definition properties
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

**Remove obsolete cleaning code (back and front)**

```java
// [...]
public class AbstractApplicationTestCase extends AbstractTestCase {
  // [...]
  @BeforeEach
  @Override
  public void init() throws ServiceException, SecurityServiceException {
    // Database cleaning performed by CleanDatabaseTestExecutionListener
  }

  @AfterEach
  @Override
  public void close() throws ServiceException, SecurityServiceException {
    // Database cleaning performed by CleanDatabaseTestExecutionListener
  }

  // remove cleanAll, cleanReferenceData, unused cleaning code
}
```

***(optional) Add SQL initialization scripts (global and local)**

```java
// [...]
@Sql(scripts = "scripts/test-global-init.sql")
@SqlMergeMode(MergeMode.MERGE)
class AbstractApplicationTestCase extends AbstractTestCase {
  // [...]
}
```

```java
// [...]
class TestCase extends AbstractApplicationTestCase {
  // [...]
  @Sql(scripts = "scripts/test-testcase1.sql")
  void testCase1() {
    // [...]
  }
}
```