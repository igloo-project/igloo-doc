Automatize data upgrades with Flyway
====================================

.. contents:: :local:

Igloo and the basic application are using Flyway for handling your data upgrades.

Activate Flyway's Spring profile
--------------------------------

By default, Flyway's Spring profile is activated with this line in the file ``configuration-bootstrap.properties`` :

.. code-block:: bash

  igloo.default.spring.profiles.active=flyway

With this simple configuration, the creation of the Flyway bean is enabled
in the application and you can now start to use it.

.. note:: Flyway spring profile is enabled in basic-application generated
  from Igloo version 0.14 and above.

.. note::
  If you want to disable flyway from your application, just remove ``flyway`` from
  the configuration variable ``igloo.default.spring.profiles.active`` in file ``configuration-bootstrap.properties``.


Create a Flyway data upgrade
----------------------------

The first thing to do is to is to configure both scripts location and updates table name
for Flyway in ``development.properties`` :

.. code-block:: bash

  maven.flyway.locations=org.iglooproject.basicapp.core.config.migration.common,db/migration/
  maven.flyway.table=flyway_schema_version

You can write your data upgrades either in SQL or Java.
Here we have chosen to :

  * put our upgrades .sql in the folder ``src/main/resources/db/migration/``
  * put our upgrades .java in the package ``org.iglooproject.basicapp.core.config.migration.common``

If you want to specify multiple locations, you have to separate them with commas.

Now you can create the data upgrades which will be applied by Flyway.
If you want to be able to relaunch manually the upgrade in case it fails, you have to use the Java formatted upgrades.


.. note:: In Igloo version 0.14 and above, hibernate ``hdm2ddl`` is disabled by default
  and database model is created with the ``V1_1__CreateSchema.sql`` SQL script during
  the first startup.

.. note::
  Flyway works with a database versioning system. Versions are based
  on the names of the data upgrades so be careful how you name them. The name must
  respect the pattern ``V<major>_<minor>__<name>``. For instance ``V1_1__CreateSchema.sql``
  is a valid name. SQL and Java upgrades follow the same naming pattern.


Create a SQL formatted data upgrade
````````````````````````````````````

If you want to write a SQL data upgrade, just write your SQL script with
the wright naming pattern and place it in the folder or package you specified earlier.
The script will be executed next time you launch your application.


Create a Java formatted data upgrade
````````````````````````````````````

If you want to write a data upgrade in Java, you have to follow a particular workflow.
In this case, Flyway script is only feeding the ``DataUpgradeRecord`` table in the
database. This table is looked up at startup to execute data upgrade in a Java
context.

Your Flyway script will only declare that the data upgrade exists and that the
application needs to launch it. To do so, copy the existing Flyway data upgrade
``V1_2__InitDataFromExcel``, change the version and the name or the script. Then
target the Igloo data upgrade you want to see executed.

.. code-block:: java

  @Override
  protected Class<? extends IDataUpgrade> getDataUpgradeClass() {
    return DataUpgrade_InitDataFromExcel.class;
  }

Create an Igloo data upgrade
--------------------------------

If you have wrote Java formatted data upgrades, you need to create an Igloo
data upgrade for each one of these.

An Igloo data upgrade is a java class which implements ``IDataUpgrade`` and override its methods.
Write all your operations in the function ``perform()``.

Each Igloo data upgrade need to be registered in  ``DataUpgradeManagerImpl`` :

.. code-block:: java

  @Override
  public List<IDataUpgrade> listDataUpgrades() {
    return ImmutableList.<IDataUpgrade>of(
       new DataUpgrade_InitDataFromExcel()
    );
  }
