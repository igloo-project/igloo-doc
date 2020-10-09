#####################
Logging configuration
#####################

Default configuration
#####################

Logging configuration is based on the following components :

* SLF4J API for every logging invocation (Logger and MDC)
* Log4j2 (from X.X.X) for logging backend
* Log4j2 CompositeConfiguration for logging configuration

How dependencies are managed
****************************

Logging subsystem is provided by these dependencies :

* igloo-component-core-logging : import slf4j API and slf4j bindings for
  JCL (commons-logging) and JUL (java.util.logging)

  * JUL binding implies to call ``SLF4JBridgeHandler.install()``. This is done
    in Igloo project using ``SLF4JLoggingListener`` servlet listener. This
    listener is added in basic-application-webapp ``web.xml``.

    Logger ``org.iglooproject.slf4j.jul.bridge.SLF4JLoggingListener``, level
    INFO, can be used to check if the binding is done.

  * JCL binding is automatic

* igloo-component-core-logging-log4j1 : dependency to use log4j 1.2 (deprecated)
  backend

* igloo-component-core-logging-log4j2 : dependency to use log4j2 backend

How log4j configuration can be customized
*****************************************

Log4j 1.2 and Log4j2 uses similar behavior. log4j2 must be transformed to
log4j when Log4j 1.2 is used.

At early startup stage :

* log4j 1.2 uses log4j.properties file (default configuration)
* log4j2 uses log4j2.properties as configured by ``log4j2.component.properties``
  in ``igloo-component-spring-bootstrap-config`` module

During Spring early initialization :

* Log4j2 configuration is customized by loading custom files
* It is managed by ``AbstractExtendedApplicationContextInitializer`` class
  and uses ``log4j2.configurationLocations`` property.
* This property is set (default) in ``configuration-bootstrap-default.properties``,
  ``configuration-bootstrap.properties`` (in your project).
* A custom bootstrap properties path can be specified : :ref:`bootstrap-locations`
* Switch between log4j 1.2 and log4j2 is done base on SLF4J selected backend.
* It is adviced to ensure you include only 1 implementation and 1 SLF4J binding
  in your classpath to ensure proper backend is used. So check your application
  dependencies.

With default configuration (take a look at ``configuration-bootstrap-default.properties``),
you can use :

* ``log4j2-user-USERNAME.properties`` to manage your personal configuration
* ``log4j2-env-development.properties`` to manage configuration dedicated to
  development
* ``log4j2-env-deployment.properties`` to manage configuration for all deployment
  targets (qualification, preproduction, production)
* ``log4j2-env-{qualification,preproduction,production}.properties`` to manage
  configuration for earch target
* You can use ``igloo.log4j2`` property to specify a path to an extra
  configuration. It is commonly used to provides a local on-disk extra
  configuration. Default path for this value is
  ``classpath:/log4j2-extra.properties``.

Last configuration has the highest precedence. Configuration are loaded with
this order :

* General igloo config (log4j2-igloo.properties)
* Project configuration (log4j2.properties)
* Environment configuration
* User configuration
* Extra configuration

Logger ``igloo@config`` allows to see loaded files.

.. code-block:: shell

   INFO  - igloo@config - Log4j configurations (ordered): classpath:/log4j2-igloo.properties, classpath:/log4j2.properties, classpath:/log4j2-env-development.properties, classpath:/log4j2-user-lalmeras.properties

Other customizations
********************

``org.iglooproject.wicket.servlet.filter.Log4jUrlFilter``, a servlet filter,
installed in basic-application-webapp web.xml set current page URL using
``MDC`` API.

It allows to include URL in logging messages by using ``%X{ow-url}`` in the
configured pattern.

.. _keep-log4j1:

How to keep log4j 1.2
#####################

To keep log4j 1.2, you need to add this new dependency to your ``application-core/pom.xml``:

.. code-block:: xml

   <!-- Logging backend -->
   <dependency>
      <groupId>org.iglooproject.dependencies</groupId>
      <artifactId>igloo-dependency-core-logging-log4j1</artifactId>
      <version>${igloo.version}</version>
      <type>pom</type>
   </dependency>

Check that your core, init and webapp dependencies only include log4j 1.2.

.. _migrate-log4j1:

How to migrate a log4j 1.2 configuration
########################################

To migrate to log4j2, you need to add this new dependency to your ``application-core/pom.xml``:

.. code-block:: xml

   <!-- Logging backend -->
   <dependency>
      <groupId>org.iglooproject.dependencies</groupId>
      <artifactId>igloo-dependency-core-logging-log4j2</artifactId>
      <version>${igloo.version}</version>
      <type>pom</type>
   </dependency>

Check that your core, init and webapp dependencies only include log4j2.

If you use a custom ``configuration-bootstrap.properties``, you need to create
the multiple ``log4j2.configurationLocations`` entries. You can use
igloo basic-application-core ``configuration-bootstrap.properties`` as a model.

You need to check if deployment uses custom bootstrap files (ask your deployment
guy) to update it. You also need to update any local log4j configuration file.

Then ``log4j-*.properties`` must be renamed ``log4j2-*.properties``, and
configuration rewritten to use log4j2 syntax.

Here are examples:

.. code-block::
   :caption: Main configuration

   #
   # log4j 1.2
   #
   log4j.appender.Stdout=org.apache.log4j.ConsoleAppender
   log4j.appender.Stdout.layout=org.apache.log4j.PatternLayout
   log4j.appender.Stdout.layout.ConversionPattern=[%d{ISO8601}][%X{PID}] %-5p - %-26.26c{1} - %X{ow-url} - %m\n

   log4j.rootLogger=WARN, Stdout

   #
   # log4j2
   #
   status = error
   dest = err
   name = PropertiesConfig

   appender.console.type = Console
   appender.console.name = STDOUT
   appender.console.layout.type = PatternLayout
   appender.console.layout.pattern = [%d{ISO8601}] %-5p - %-26.26c{1} - %X{ow-url} - %m\n

   rootLogger.level = warn
   rootLogger.appenderRef.stdout.ref = STDOUT

.. code-block::
   :caption: Logger configuration

   #
   # log4j 1.2
   #
   log4j.logger.package.Class=DEBUG

   #
   # log4j2
   #
   # NAME is an arbitrary string used to link name and level together
   logger.NAME.name=package.Class
   logger.NAME.level=DEBUG

.. code-block::
   :caption: Advanced logger configuration

   #
   # log4j 1.2
   #
   # synchro is an appender
   log4j.logger.package.Class=INFO, synchro
   log4j.additivity.package.Class=false

   #
   # log4j2
   #
   # NAME is an arbitrary string used to link name and level together
   # EITHER is an arbitrary string used to link append configurations together
   # [...]
   appender.EITHER.name = synchro
   # [...]
   logger.NAME.name=package.Class
   logger.NAME.level=DEBUG
   logger.NAME.additivity=false
   logger.NAME.appenderRefs = SYNCHRO
   logger.NAME.SYNCHRO.ref = synchro
   # if multiple append must be specified
   #logger.NAME.appenderRefs = SYNCHRO, STDOUT
   #logger.NAME.SYNCHRO.ref = synchro
   #logger.NAME.STDOUT.ref = STDOUT

.. code-block::
   :caption: Alternate appender configuration

   #
   # log4j 1.2
   #
   log4j.appender.SYNCHRO=org.apache.log4j.FileAppender
   log4j.appender.SYNCHRO.File=${catalina.base}/logs/synchro.log
   log4j.appender.SYNCHRO.layout=org.apache.log4j.PatternLayout
   log4j.appender.SYNCHRO.layout.ConversionPattern=[%d{ISO8601}] %-5p - %-26.26c{1} - %X{ow-url} - %m\n

   #
   # log4j2
   #
   # sys: prefix is used to use system properties
   # env: prefix may be used for environment variables
   appender.synchro.type=File
   appender.synchro.name=SYNCHRO
   appender.synchro.fileName=${sys:catalina.base}/logs/synchro.log
   appender.synchro.layout.type = PatternLayout
   appender.synchro.layout.pattern=[%d{ISO8601}] %-5p - %-26.26c{1} - %X{ow-url} - %m\n
