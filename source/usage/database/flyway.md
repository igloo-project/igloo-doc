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

## Activate Flyway's Spring profile

By default, Flyway's Spring profile is activated with this line in the file `configuration-bootstrap.properties` :

```bash
igloo.default.spring.profiles.active=flyway
```

With this simple configuration, the creation of the Flyway bean is enabled in the application and you can now start to use it.

```{note}
Flyway spring profile is enabled in basic-application generated from Igloo version 0.14 and above.
```

```{note}
If you want to disable flyway from your application, just remove `flyway` from the
configuration variable `igloo.default.spring.profiles.active` in file `configuration-bootstrap.properties`.
```

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
 
It is possible to exclude some scripts during initialization. By default we have two paths :
- `db/migration/common/*` : contains all the scripts that will be included when the application is started
- `db/migration/init/*` : contains the scripts that we want to include according to the environment (generally, these scripts contain data to import)

If you want to include the `init/` scripts, this property must be modified :
```bash
# `true`  : import files from `common/` and `init/`
# `false` : only import files from `common/` (default if `null`)
migration.init.enabled=true
```

```{note}
Its default values are in Igloo :
- `spring.flyway.locations.withInit=db/migration/common/**/*.sql,db/migration/init/**/*.sql`
- `spring.flyway.locations.withoutInit=db/migration/common/**/*.sql`
It is possible to overwrite them if needed
```

## Create a Flyway data upgrade

You can write your data upgrades either in SQL or Java.
Here we have chosen to :

  * put our upgrades .sql in the folder `src/main/resources/db/migration/common/` or `src/main/resources/db/migration/init/`
  * put our upgrades .java in the package `db.migration.common` or `db.migration.init`

If you want to specify multiple locations, you have to separate them with commas.

Now you can create the data upgrades which will be applied by Flyway.
If you want to be able to relaunch manually the upgrade in case it fails, you have to use the Java formatted upgrades.


```{note}
In Igloo version 0.14 and above, hibernate `hdm2ddl` is disabled by default
  and database model is created with the `V1_1__CreateSchema.sql` SQL script during
  the first startup.
```

```{note}
Flyway works with a database versioning system. Versions are based on the names of the data upgrades so be careful how you name them.
The name must respect the pattern `V<major>_<minor>__<name>`.
For instance `V1_1__CreateSchema.sql` is a valid name. SQL and Java upgrades follow the same naming pattern.
```


## Create a SQL formatted data upgrade

If you want to write a SQL data upgrade, just write your SQL script with the wright naming pattern and place it in the folder or package you specified earlier.  
The script will be executed next time you launch your application.


## Create a Java formatted data upgrade

If you want to write a data upgrade in Java, you have to follow a particular workflow.
In this case, Flyway script is only feeding the `DataUpgradeRecord` table in the
database. This table is looked up at startup to execute data upgrade in a Java
context.

Your Flyway script will only declare that the data upgrade exists and that the
application needs to launch it. To do so, copy the existing Flyway data upgrade
`V1_2__InitDataFromExcel`, change the version and the name or the script. Then
target the Igloo data upgrade you want to see executed.

```java
@Override
protected Class<? extends IDataUpgrade> getDataUpgradeClass() {
  return DataUpgrade_InitDataFromExcel.class;
}
```

## Create an Igloo data upgrade

If you have wrote Java formatted data upgrades, you need to create an Igloo
data upgrade for each one of these.

An Igloo data upgrade is a java class which implements `IDataUpgrade` and override its methods.
Write all your operations in the function `perform()`.

Each Igloo data upgrade need to be registered in  `DataUpgradeManagerImpl` :

```java
@Override
public List<IDataUpgrade> listDataUpgrades() {
  return ImmutableList.<IDataUpgrade>of(
      new DataUpgrade_InitDataFromExcel()
  );
}
```

## Migration

Since Igloo 5.X.X (TODO) (with Flyway `>9.9.0` version)

### Property files

1. In the file `configuration-env-default.properties`, you must delete these lines :
```bash
# DELETE
environment.flyway.locations.withInit=org/iglooproject/basicapp/core/config/migration/common,org/iglooproject/basicapp/core/config/migration/init,db/migration/common/
environment.flyway.locations.withoutInit=org/iglooproject/basicapp/core/config/migration/common,db/migration/common/
environment.flyway.locations=
```

2. In the file `configuration.properties`, you must make the following changes :
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
