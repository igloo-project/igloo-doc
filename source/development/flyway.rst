Use data upgrades with Flyway
=============================

OWSI-Core and the basic application are programmed to be able to use Flyway for
handling your data upgrades, here's how you can do it.

Activate Flyway's Spring profile
--------------------------------

First of all, you need to activate Flyway's Spring profile. To do so, just modify this line to add flyway in the file **development.properties**  :

.. code-block:: bash

  maven.spring.profiles.active=flyway

With this simple modification, you have enabled the creation of the Flyway bean
in the application and you can now start to use it.

.. note::
  If you want to disable flyway from your application, just remove the word *flyway* from
  the line *maven.spring.profiles.active* in the file **development.properties**.

Create a Flyway data upgrade
----------------------------

The first thing to do is to is to add flyway's variables in the file **development.properties** :

.. code-block:: bash

  maven.flyway.locations=fr.openwide.core.basicapp.core.config.migration.common,db/migration/
  maven.flyway.table=flyway_schema_version

You can write your data upgrades either in SQL or Java.
Here we have chosen to put our upgrades .sql in the folder *src/main/resources/db/migration/* and
our upgrades .java in the package *fr.openwide.core.basicapp.core.config.migration.common*.
If you want to specify multiple locations, you have to separate them with a single comma.

Now you can create the data upgrades which will be applied by Flyway.
If you want to be able to relaunch manually the upgrade in case it fails, you have to use the Java formatted upgrades.

.. note::
  Flyway works with a database versioning system. The versions are based
  on the names of the data upgrades so be careful how you name them. The name must
  respect the pattern *Vversion_you_want__NameOfDataUpgrade*. For example *V1_0__ImportTable.sql*
  is a valid name. SQL and Java upgrades follow the same naming pattern.

Create an SQL formatted data upgrade
````````````````````````````````````

If you want to write a data upgrade in SQL, just write your script and place your SQL file
in the folder or package you have specified earlier.


Create a Java formatted data upgrade
````````````````````````````````````

If you want to write a date upgrade in Java, you have to follow a particular workflow.
In fact, it is not the Flyway upgrade which will contain the operations on your data/database,
you will have to create an OWSI-Core data upgrade after the Flyway one.

Your Flyway data upgrade will only declare that the data upgrade exists and that the application needs to launch it.
To do so, copy the existing Flyway data upgrade *V1_2__ImportExcel.java*, give it the name you want
and change in the class the value of the **DATA_UPGRADE_NAME** variable :

.. code-block:: java

  private String DATA_UPGRADE_NAME = "ImportExcel";

Create an OWSI-Core data upgrade
--------------------------------

If you have wrote Java formatted data upgrades, you need to create an OWSI-Core
data upgrade for each one of these which is named after the **DATA_UPGRADE_NAME**
value you specified earlier. For example, if the value entered in the Flyway Java data upgrade is *ImportTable*,
you have to name your OWSI-Core data upgrade *ImportTable.java*.

An OWSI-Core data upgrade is a java class which implements *IDataUpgrade* and override its methods.
Write all your operations in the function **perform()**.
