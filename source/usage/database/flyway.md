# Flyway model update

- [Flyway model update](#flyway-model-update)
  - [Activate Flyway's Spring profile](#activate-flyways-spring-profile)
  - [Properties configuration](#properties-configuration)
    - [Basic properties](#basic-properties)
    - [Migration properties](#migration-properties)
  - [Create a Flyway data upgrade](#create-a-flyway-data-upgrade)
  - [Create a SQL formatted data upgrade](#create-a-sql-formatted-data-upgrade)
  - [Create a Java formatted data upgrade](#create-a-java-formatted-data-upgrade)
  - [Create an Igloo data upgrade](#create-an-igloo-data-upgrade)
  - [Migration](#migration)
    - [Property files](#property-files)
    - [Script file](#script-file)

Igloo and the basic application are using Flyway for handling your data upgrades.

## Properties configuration

### Basic properties

Before using Flyway's features, you need to configure the following properties:

```bash
# the schema that Flyway will use
spring.flyway.schemas=X
spring.flyway.default-schema=X
# the table that Flyway will use, by convention `flyway_schema_version` 
spring.flyway.table=flyway_schema_version
```

### Migration properties

Database model migration can be used to perform :

* schema initialization only
* schema initialization and data import

First use-case is used for integration tests, as data are generally bootstraped by tests.

Second use-case is used for application bootstrap in early realease stages.

Default configurations provided by Igloo use the following paths:

- `db/migration/common/*` : contains schema initialization scripts
- `db/migration/init/*` : contains data initialization scripts

If you want to include both `common/` and `init/` scripts, this property must be modified :

```bash
# `true`  : import files from `common/` and `init/`
# `false` : only import files from `common/` (default behavior)
migration.init.enabled=true
```


### Advanced usage: Spring boot configuration

Spring-boot flyway configuration properties are available here: https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#appendix.application-properties.data-migration

*common/init* behavior is controlled by an Igloo configuration that switch
`flyway.spring.locations` based on `migration.init.enabled` value. If you want to use this
mechanism, you must not redefine `flyway.spring.locations`.

If you want to customize `flyway.spring.locations`, it is advised to not use
`db.migration` locations (keep this classpath empty).

If you want to customize `flyway.spring.locations` and use both SQL and Java migrations,
keep in mind that Java migrations you want to be Spring-injection-enabled must not be
discovered by the provided `flyway.spring.locations`; Spring-injection-enabled migrations
must be Spring managed beans. You may restrict file discovery to sql files by using
a pattern in your configuration: `path/**/*.sql`.


## Create a Flyway data upgrade

You can write your data upgrades either in SQL or Java.
Here we have chosen to :

  * put your upgrades .sql in the folder `src/main/resources/db/migration/common/` or `src/main/resources/db/migration/init/`
  * put your upgrades .java in the package `db.migration.common` or `db.migration.init`
  * follow Flyway naming convention: `V<major>_<minor>__<name>.sql/java`. Follow your project's
    convention to choose major/minor version (it may not match application version).

If you want to specify multiple locations, you have to separate them with commas.

Use SQL scripts to perform schema and data migration that can be performed reliably with
SQL scripts.

If you need to use Hibernate API to perform data migrations, you need to create a
DataUpgradeRecord entry so that it can be launched once flyway migration and hibernate
startup are performed.


## Create a SQL formatted data upgrade

Just write your SQL script and place it in the configured migration locations. You can
use basic templating with values defined in configuration properties by using Flyway
placeholders mechanism.


## Create a Java formatted data upgrade

When Flyway migration are applied, Hibernate is not started. You can use Java code that
do not use Hibernate API to access data (plain JDBC, JdbcTemplate, ...).

If you want to use Hibernate or other components initialized after flyway,
you have to create a `DataUpgradeRecord` row in database. This table is looked up once
the Spring context is fully initialized to trigger a DataUpgrade. This DataUpgrade
can use Hibernate APIs.

You can use `V1_2__InitDataFromExcel` as an example, and customize the targetted
DataUpgrade:

```java
@Override
protected Class<? extends IDataUpgrade> getDataUpgradeClass() {
  return DataUpgrade_InitDataFromExcel.class;
}
```

## Create an Igloo data upgrade

An Igloo data upgrade is a java class which implements `IDataUpgrade`.

Migration operations are performed by the `perform()` function.

Each Igloo data upgrade need to be registered in  `DataUpgradeManagerImpl` bean:

```java
@Override
public List<IDataUpgrade> listDataUpgrades() {
  return ImmutableList.<IDataUpgrade>of(
      new DataUpgrade_InitDataFromExcel()
  );
}
```

## Migration

From Igloo 5.X.X (TODO) (with Flyway `>9.9.0` version), Igloo custom flyway integration is
replaced by spring-boot implementation. It allows to use the `spring.flyway.*` properties
to control Flyway behavior.

The migration steps are needed to adapt an existing application so that:

* SQL migration are present in the expected locations
* Java migration are now Spring registered bean
* Properties are renamed to the spring-boot equivalents

### Property files

1. In `configuration-env-default.properties`, delete `environment.flyway.locations.*`
   properties:

```bash
# DELETE
environment.flyway.locations.withInit=org/iglooproject/basicapp/core/config/migration/common,org/iglooproject/basicapp/core/config/migration/init,db/migration/common/
environment.flyway.locations.withoutInit=org/iglooproject/basicapp/core/config/migration/common,db/migration/common/
environment.flyway.locations=
```

2. In `configuration.properties`, you must make the following changes :

```bash
# DELETE
flyway.locations=${environment.flyway.locations}
# ---

# REPLACE
flyway.schemas=${db.user}
flyway.table=flyway_schema_version
# BY
spring.flyway.schemas=${db.user}
spring.flyway.table=flyway_schema_version
# ---

# ADD
spring.flyway.default-schema=${db.user}
```

3. Check and modify in **all** `.properties` files :
```bash
# REPLACE
environment.flyway.locations=${environment.flyway.locations.withInit}
# BY
migration.init.enabled=true
# ---

# REPLACE
environment.flyway.locations=${environment.flyway.locations.withoutInit}
# BY
migration.init.enabled=false
# ---
```

### Script file

1. Modify `AbstractDataUpgradeMigration` class according to this [commit](https://github.com/igloo-project/igloo-parent/commit/1f87e628f98c57c296661f7fc9b3fdbb0c64a782#diff-bd35549851f4e20174bec607c189418397635f2c46777f1f59732cb8630225d9). 

2. Modify your `JAVA` script classes by adding the `@Component` annotation (otherwise they will not be applied).   
An example [here](https://github.com/igloo-project/igloo-parent/commit/1f87e628f98c57c296661f7fc9b3fdbb0c64a782#diff-2fc5796213ed4ca640455757c8e0ac259a009fcebac78b3386dc3e4532453ee8).

3. Move files :
   - From `<project>.core.config.migration.init` to `db.migration.init`
   - From `<project>.core.config.migration.commom` to `db.migration.common`
