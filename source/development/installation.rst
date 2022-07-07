.. _igloo-initialize:

Development environment
=======================

Prerequisites
-------------

* **PostgreSQL** (default configuration); other databases may be used
* **Eclipse**/**Intellij**
* **JRE 11** (Open JDK - maven build / runtime compatible with Java 11)


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

* Clone https://github.com/igloo-project/igloo-oomph-project

* Start eclipse

* ``Package Explorer`` > contextual menu > ``Import...``

* ``Oomph`` > ``Projects into workspace`` > ``Next``

* ``Add user projects`` (green ``+`` icon) > ``Browse File System`` > ``igloo-oomph-project/org.iglooproject.eclipse.igloo.setup`` > Validate

* Select ``Igloo development`` in ``<Eclipse Projects>`` > ``<User>`` tree

* In Variables' form, check the fields. You may customize filesystem clone folder name (``~/git/<folder name>``), git branch or tomcat binary location; validate

* Accept to restart when Eclipse asks to

* At restart, igloo project is cloned and imported. Wait for build completion (~ 4 minutes), then stop-start Eclipse again

* Add ``Servers`` view (``Window`` > ``Show view`` > ``Other...``)

* tomcat85 may be listed, with basic-application-webapp module, and is ready to be run


Intellij
--------

Maven build process is compatible with Intellij maven integration.

Keep attention to switch indentation configuration to tabs for `.java` and `.xml` files. Deactivate automatic import reorganization.

When using a launcher setup to start `main` application, include provided/runtime dependencies in classpath.


Other IDE
---------

You may use the tools provided by your IDE for Maven's integration.

Igloo relies on the following requirements :

* **maven-processor-plugin**: code generation with java builtin annotation processing. It implies a custom generate-resources task, and added source folders for generated files

* **maven-surefire-plugin**: unit tests, managed by junit. Tests may also be run by junit IDE integration (known to work with Eclipse)

* **com.github.eirslett/frontend-maven-plugin**: npm build for javascript/css resources

* (optional) **maven-enforcer-plugin**: various check about dependencies

* (optional) **animal-sniffer-maven-plugin**: Java API checks
