.. _config.bootstrap:

Configuration management
========================

.. contents:: :local:

Basic usage
-----------

Quick guide
***********

* Write ``<property>=...`` in configuration.properties.
* If you want to override this property by environment on a regular basis
  (database settings for example), uses a ``property=environment.<property>``
  definition, and put ``environment.<property>=...`` definition in
  ``configuration-env-*.properties`` files.
* If you want to override any property on your development environment, put
  definition in ``configuration-user-<username>.properties``.
* Use ``/etc/<applicationName>/configuration.properties`` for environment
  sensitive information (password, ...) or not-versionned properties.


Selecting Igloo profile
***********************

Profile can be selected with ``IGLOO_PROFILE`` environment variable or
``igloo.profile`` system property.


Advanced usage
--------------

Default log4j configuration
***************************

With default bootstrap configuration, a ``log4j-igloo.properties`` is provided
with some default configurations. This properties can be overriden in your
local ``log4j-*.properties``.

Override local configuration path
*********************************

For configuration overrides, set ``igloo.config`` system property to a
java resource url (default value:
``file:/etc/${igloo.applicationName}/configuration.properties``).

For log4j configuration overrides, set ``igloo.log4j`` system property to a
java resource url (default value: ``classpath:/log4j-extra.properties``).

Default value for this properties can be set in
``configuration-bootstrap.properties``.

Manage spring profiles
**********************

In ``configuration-bootstrap.properties``, configure your default Spring
profiles with ``igloo.default.spring.profiles.active``.

If you want to use custom Spring profiles based on your Igloo profile setting,
initialize custom ``igloo.<profile>.spring.profiles.active=...`` properties.

Use @TestPropertySource(properties="igloo.profile=xxx") for Igloo profile
switching in your unit-test.

Create a custom Igloo profile
*****************************

You can create custom Igloo profile (example: myProfile) by initializing
``igloo.myProfile.(configurationLocations|log4j.configurationLocations|spring.profiles.active)``
in ``configuration-bootstrap.properties``.

``environment.<property>`` pattern
**********************************

Push your application configuration in ``configuration.properties``. If this
configuration relies on a Igloo profile switch, a best practice is to use a
``<property>=${environment.<property>}`` configuration to highlight the fact
this property is overriden by environment.

For the definitions of ``environment.<property>``:

* Set common overrides in ``configuration-env-default.properties``.

* Set qualification, preproduction, production overrides in ``configuration-env-deployment.properties``.

* Set specific overrides in ``configuration-env-<profile>.properties`` (including test profile).

.. note:: using ``<property>=${environment.<property>}`` is just a way to keep
  an exhaustive property definition in ``configuration.properties`` and to
  highlight generic and specific configurations. You can override any
  configuration in ``configuration-*.properties`` if needed.

Configuration loading logging
*****************************

``igloo@config`` logger allow to visualize loaded configurations. Verbose logs
are handled by org.iglooproject.config.bootstrap.* logger names. Missing
configurations are logged with a WARN level.

.. code-block:: properties

   log4j.logger.igloo@config=INFO
   log4j.logger.org.iglooproject.config.bootstrap=WARN

This configuration is included in ``log4j-igloo.properties``.

Configuration debugging
***********************

Igloo 1.1.27 includes a debugging tool for configuration. It allows to
write in a file targetted by ``igloo.propertySource.outputFileName`` the
content of both environment and PropertySourcesPlaceholderConfigurer.

It is intended to be configured using a system property
(e.g. ``-Digloo.propertySource.outputFileName=/tmp/debug.properties``).

The generated files contains all listable properties and their values.

Not enumerable PopertySource (like JNDI ones) and not resolvable properties are
skipped (a comment is included in the generated file for each skipped item).

**This file may contain sensitive data (password, ...).**

Custom bootstrap files
**********************

Loaded bootstrap files can be overriden with ``IGLOO_BOOTSTRAP_LOCATIONS``
environment variable or ``igloo.bootstrapLocations`` system property.

By default, these new locations are **added** to the default configuration.

To completely override bootstrap locations, you must use ``IGLOO_BOOTSTRAP_OVERRIDE_DEFAULT``
or ``igloo.bootstrapOverrideDefault``.

Implementation's overview
-------------------------

Configuration loading
*********************

From 1.y.z (TODO), Igloo uses a early loading for properties:

* Igloo initializer (AbstractExtendedApplicationContextInitializer children
  classes):

  * loads ``configuration-bootstrap*.properties`` files. Property
    switching are based system property settings (``igloo.profile`` value).

  * adds IglooPropertySourcesLevelsConfig @Configuration class to order
    ``igloo/component``, ``igloo/framework``, ``igloo/application``,
    ``igloo/bootstrap`` and ``igloo/overrides`` @PropertySource's names (listed
    from the lower to the higher precedence).

  * add IglooBootstrapPropertySourcesConfig @Configuration class to manage
    loading of properties files targetted by ``igloo.configurationLocations``.

* Vanilla @PropertySource annotation must be used to perform properties loading.
  Constants from IglooPropertySourcePriority must be used for the ``name``
  attribute to manage property precedence.

* For a same @PropertySource name, bean discovery order is used to manage
  precedence. We must not rely on this mechanism to override property (as
  bean discovery order is hard to predict and control).


From 1.1 to 1.1.27, Igloo used the following mechanisms to handle configuration:

* Two-phase loading: **bootstrap** (early and minimal) and
  **spring configuration** (late and exhaustive)
* **Spring configuration locations** from ``@ConfigurationLocations`` annotations
  (either from your project, or from Spring Java Config beans provided by
  Igloo)
* **Configuration overriding** by user or by Igloo profile with an added bunch of
  files configured during bootstrap phase
* **Log4j** configured by user or by Igloo profile during bootstrap phase
* **Spring profiles** by user or by Igloo profile during bootstrap phase

.. warning:: Igloo profile and Spring profiles are not the same thing. Igloo
  profile is loaded first, and Spring profiles are computed from
  ``igloo.<profile>.spring.profiles.active``.

``configuration-bootstrap*`` properties
***************************************

``configuration-bootstrap.properties``, located in your
``project-core/src/main/resources`` may define the following values, for each
needed profile:

* ``igloo.<profile>.configurationLocations``: files to add to **override**
  configurations computed from ``@ConfigurationLocations`` files.
* ``igloo.<profile>.log4j.configurationLocations``: files to merge to build
  log4j configuration.
* ``igloo.<profile>.spring.profiles.active``: Spring profiles to activate. If
  there is no difference between the profile, you may use
  ``igloo.default.spring.profiles.active``.
* tests are handled as a plain Igloo profile. Profile activation is done by
  using @PropertySource("igloo.profile=test") in ``AbstractTestCase``.

Default configuration may be sufficient for simple projects. Just let the
provided lines commented out.

Default configurations for bootstrap phase can be viewed here:
https://github.com/igloo-project/igloo-parent/blob/dev/igloo/igloo-components/igloo-component-spring-bootstrap-config/src/main/resources/configuration-bootstrap-default.properties

It handles:

* ``configuration.properties`` loading
* ``configuration-env-{default,development}.properties``
  ``configuration-user-${user.name}.properties`` loading for development
* ``configuration-env-{default,deployment,<profile>}.properties``,
* ``/etc/<applicationName>/configuration.properties`` loading for
  qualification, preproduction, production profiles; this path can be overriden
  by ``igloo.config`` property.
* Log4j configuration loading with the same patterns
* Spring profiles configuration based on ``igloo.default.spring.profiles.active``
  and an empty (no profile) default

**Basic-application defaults** are to activate flyway profile and to use defaults
behavior.


.. _property-source-migration:

Migrating from @ConfigurationLocations to @PropertySource
---------------------------------------------------------

Reason of the breaking change
*****************************

With 1.y.z (TODO), configuration subsystem is deeply modified to allow further
improvements and to use vanilla spring boot mechanisms (autoconfiguration,
conditionals, ...).

The old behavior was:

* Bootstrap configuration loads some low-level configuration properties
  (like igloo.configurationLocations, igloo.profile, log4j configuration).
* Spring bean configuration is fully discovered and computed.
* ApplicationConfigurerBeanFactoryPostProcessor initializes a
  PropertySourcesPlaceholderConfigurer based on Spring environment, based on
  the list provided by @ConfigurationLocations annotations (low precedence)
  and ``igloo.configurationLocations`` property (high precedence).
* Spring beans are initialized.

This behavior is problematic:

* It is not possible to control Spring bean discovery by Spring boot
  autoconfiguration by properties loaded by @ConfigurationLocations or
  ``igloo.configurationLocations``
* @ConfigurationLocations is a custom annotation that cannot interact with
  @PropertySource
* Switch some properties to ``configuration-bootstrap*.properties`` (as it is
  early loaded) is a valid option, but it can lead to difficulties :

  * It is not clear for a developer how a property must be early-loaded or not.
  * If configuration is split, some properties may be wrongly updated between
    initialization and running phase.

So we choose to remove the old configuration behavior and to write a guide
on how to update an Igloo application:

Configuration migration guide
*****************************

* Generates a file containing your original configuration. Update your
  application to Igloo 1.1.27 and starts it with
  ``-Digloo.propertySource.outputFileName=/tmp/debug.properties.orig``.

* Switch to Igloo 1.y.z (TODO).
* Modify your ``configuration-boostrap.properties``

  * Add a property ``igloo.applicationName=xxx``; Replace xxx with the name
    of @ApplicationDescription.
  * Add classpath:/configuration.properties as first item of all
    ``igloo.<profile>.configurationLocations=``, either this property is
    commented out or not, to prevent any future error.

* Remove @ApplicationDescription annotation
* Remove empty @ConfigurationLocations
* Replace other @ConfigurationLocations by a named @PropertySource

  .. code-block:: java

     @PropertySource(
        name = IglooPropertySourcePriority.APPLICATION,
        value = "classpath:configuration-init.properties"
     )

 * Start your application with
   ``-Digloo.propertySource.outputFileName=/tmp/debug.properties.new``.

 * Checks the diff of the 2 files:

   * Differences on ``igloo.build.*`` are OK.
   * Differences from Manifest information are OK (date, created-by, ...).
   * Added ``classpath:/configuration.properties`` in
     ``igloo.configuurationLocations`` is normal.
   * Modified ``igloo.version`` is OK.

Here is an example of a normal diff.

.. code-block:: diff

  --- debug-propertySources.properties.orig	2019-07-23 14:33:01.983824649 +0200
  +++ debug-propertySources.properties.new	2019-07-23 14:23:40.451085807 +0200
  @@ -1,7 +1,7 @@
  #skipped PropertySource: StubPropertySource {name='servletConfigInitParams'} as it is not enumerable
  #skipped PropertySource: JndiPropertySource {name='jndiProperties'} as it is not enumerable
  #
  -#Tue Jul 23 14:32:59 CEST 2019
  +#Tue Jul 23 14:23:20 CEST 2019
  autocomplete.limit=20
  awt.toolkit=sun.awt.X11.XToolkit
  @@ -127,45 +127,45 @@
  hibernate.search.default.elasticsearch.host=http\://127.0.0.1\:9220
  hibernate.search.default.elasticsearch.index_schema_management_strategy=CREATE
  igloo.applicationName=application
  -igloo.build.date=1563884774310
  -igloo.build.sha=a3664b7820ca11d2b34c157ee8373039ae5bf9a1
  +igloo.build.date=1563882188918
  +igloo.build.sha=f8af62cbc8ebdafa03b14b843246b724ca0fe720
  igloo.build.user.name=lalmeras
  igloo.component-spring.Build-Jdk=1.8.0_212
  igloo.component-spring.Built-By=lalmeras
  -igloo.component-spring.Built-Date=1563884774310
  +igloo.component-spring.Built-Date=1563882188918
  igloo.component-spring.Created-By=Apache Maven 3.5.4
  -igloo.component-spring.Implementation-Build=a3664b7820ca11d2b34c157ee8373039ae5bf9a1
  +igloo.component-spring.Implementation-Build=f8af62cbc8ebdafa03b14b843246b724ca0fe720
  igloo.component-spring.Implementation-Title=Igloo - Component - Spring
  igloo.component-spring.Implementation-Vendor=Kobalt
  igloo.component-spring.Implementation-Vendor-Id=org.iglooproject.components
  -igloo.component-spring.Implementation-Version=1.2-SNAPSHOT
  +igloo.component-spring.Implementation-Version=1.2-PS
  igloo.component-spring.Manifest-Version=1.0
  igloo.config=file\:/etc/application/configuration.properties
  -igloo.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-development.properties,classpath\:/configuration-user-lalmeras.properties
  +igloo.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-development.properties,classpath\:/configuration-user-lalmeras.properties
  igloo.default.spring.profiles.active=flyway
  -igloo.development.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-development.properties,classpath\:/configuration-user-lalmeras.properties
  +igloo.development.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-development.properties,classpath\:/configuration-user-lalmeras.properties
  igloo.development.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-development.properties,classpath\:/log4j-user-lalmeras.properties
  igloo.development.spring.profiles.active=flyway
  -igloo.integration.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-preproduction.properties,file\:/etc/application/configuration.properties
  +igloo.integration.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-preproduction.properties,file\:/etc/application/configuration.properties
  igloo.integration.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-deployment.properties,classpath\:/log4j-env-preproduction.properties,classpath\:/log4j-extra.properties
  igloo.integration.spring.profiles.active=flyway
  igloo.log4j=classpath\:/log4j-extra.properties
  igloo.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-development.properties,classpath\:/log4j-user-lalmeras.properties
  -igloo.preproduction.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-preproduction.properties,file\:/etc/application/configuration.properties
  +igloo.preproduction.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-preproduction.properties,file\:/etc/application/configuration.properties
  igloo.preproduction.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-deployment.properties,classpath\:/log4j-env-preproduction.properties,classpath\:/log4j-extra.properties
  igloo.preproduction.spring.profiles.active=flyway
  -igloo.production.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-production.properties,file\:/etc/application/configuration.properties
  +igloo.production.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-production.properties,file\:/etc/application/configuration.properties
  igloo.production.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-deployment.properties,classpath\:/log4j-env-production.properties,classpath\:/log4j-extra.properties
  igloo.production.spring.profiles.active=flyway
  igloo.profile=development
  igloo.profile.default=development
  -igloo.qualification.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-qualification.properties,file\:/etc/application/configuration.properties
  +igloo.qualification.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-deployment.properties,classpath\:/configuration-env-qualification.properties,file\:/etc/application/configuration.properties
  igloo.qualification.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-deployment.properties,classpath\:/log4j-env-qualification.properties,classpath\:/log4j-extra.properties
  igloo.qualification.spring.profiles.active=flyway
  -igloo.test.configurationLocations=classpath\:/configuration-env-default.properties,classpath\:/configuration-env-test.properties,classpath\:/configuration-user-lalmeras-test.properties
  +igloo.test.configurationLocations=classpath\:/configuration.properties,classpath\:/configuration-env-default.properties,classpath\:/configuration-env-test.properties,classpath\:/configuration-user-lalmeras-test.properties
  igloo.test.log4j.configurationLocations=classpath\:/log4j-igloo.properties,classpath\:/log4j.properties,classpath\:/log4j-env-test.properties,classpath\:/log4j-user-lalmeras-test.properties
  igloo.test.spring.profiles.active=flyway
  -igloo.version=1.2-SNAPSHOT
  +igloo.version=1.2-PS
  imageMagick.convertBinary.path=/usr/bin/convert
  infinispan.enabled=false
  infinispan.roles=QueueTaskHolder\#initQueuesFromDatabase
