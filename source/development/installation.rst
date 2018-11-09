Initialize an Igloo environment
===============================

.. contents:: :local:

.. warning:: This documentation is valid for version **>= 1.1.0**.

Prerequisites
-------------

* **PostgreSQL** (default configuration); other databases may be used
* **Eclipse** >= 4.7 (default configuration); other Maven-enabled IDE may be used
* **JRE 1.8** (Open JDK or Oracle JVM)
* **Elasticsearch** 5.6 (optional)


Database initialization
-----------------------

To run the basic-application or any project that use the basic-application as an outline, you need to initialize a database.
To do so, you need to create a user first, and then create a database with the user you have created as its owner.

.. code-block:: bash

  createuser -U postgres -P basic_application
  createdb -U postgres -O basic_application basic_application
  psql -U postgres basic_application
  #Here you are connected to the database as the user postgres
  DROP SCHEMA public;
  \q
  psql -U basic_application application
  #Here you are connected to the database as the user hello_world
  CREATE SCHEMA basic_application;

**Database's content** is automatically initialized (schema, tables, index, data) with default basic_application configuration
(spring profile **flyway** enabled, see ``spring.profiles.active`` configuration).


Eclipse configuration
---------------------

Igloo uses Maven build system. Some shortcuts, configurations and tools are provided for Eclipse integration.

The following documentation needs a running Eclipse instance with `m2e Maven integration <http://www.eclipse.org/m2e/>`_ installed.

This documentation is known to work with Eclipse 4.7 release.

* Checkout https://github.com/igloo-project/igloo-oomph-project in ``~/git/igloo-oomph-project``

* Start eclipse

* ``Package Explorer`` > contextual menu > ``Import...``

* ``Oomph`` > ``Projects into workspace`` > ``Next``

* ``Add user projects`` (green ``+`` icon) > ``Browse File System`` > ``~/git/igloo-oomph-project/org.iglooproject.eclipse.igloo.setup`` > Validate

* Select ``Igloo development`` in ``<Eclipse Projects>`` > ``<User>`` tree

* In Variables' form, check the fields. You may customize filesystem clone folder name (``~/git/<folder name>``), git branch or tomcat binary location; validate

* Accept to restart when Eclipse asks to

* At restart, igloo project is cloned and imported. Wait for build completion (~ 4 minutes), then stop-start Eclipse again

* Add ``Servers`` view (``Window`` > ``Show view`` > ``Other...``)

* tomcat85 may be listed, with basic-application-webapp module, and is ready to be run


Maven
-----

If you do not use Eclipse, you may use the tools provided by your IDE for Maven's integration.

Igloo relies on the following requirements :

* **maven-processor-plugin**: code generation with java builtin annotation processing. It implies a custom generate-resources task, and added source folders for generated files.

* **maven-surefire-plugin**: unit tests, managed by junit. Tests may also be run by junit IDE integration (known to work with Eclipse).

* (optional) **maven-enforcer-plugin**: various check about dependencies

* (optional) **animal-sniffer-maven-plugin**: Java API checks
