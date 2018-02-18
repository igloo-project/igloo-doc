.. _config.bootstrap:

Configuration management
========================

TLDR
----

For deployment, set ``IGLOO_PROFILE`` environment variable.

In ``configuration-bootstrap.properties``, configure your
``igloo.default.spring.profiles.active`` active profiles.

Use ``@ActiveProfiles`` for profile switching in tests (if you
want to always use the same profiles, you can just use
``igloo.test.spring.profiles.active``).

Push your personal configuration overrides in
``configuration-user-${user.name}.properties`` or
``configuration-user-${user.name}-test.properties`` (tests).

Push your application configuration in ``configuration.properties``. If this
configuration rely on a profile setting, use a ``<property>=${environment.<property>}``
configuration.

For the definitions of ``environment.<property>``:

* Set common overrides in ``configuration-env-default.properties``.

* Set qualification, preproduction, production overrides in ``configuration-env-deployment.properties``.

* Set specific overrides in ``configuration-env-<profile>.properties``.

* Use a secure delivery for secrets/confidential configuration and push it to
  ``/etc/${igloo.applicationName}/configuration.properties``.

.. note:: using ``<property>=${environment.<property>}`` is just a way to keep
  an exhaustive property definition in ``configuration.properties`` and to
  highlight generic and specific configurations. You can override any
  configuration in ``configuration-*.properties`` if needed.

Override log4j configuration the same way (files ``log4j-{env,user}-*.properties``).


Overview
--------

From 1.0, Igloo use the following mechanisms to handle configuration:

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


Usage
-----

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

Default configuration may be sufficient for simple projects.

Default configurations for bootstrap phase can be viewed here:
https://github.com/igloo-project/igloo-parent/blob/dev/igloo/igloo-components/igloo-component-spring-bootstrap-config/src/main/resources/configuration-bootstrap-default.properties

It handles:

* ``configuration-env-{default,development}.properties``, then
  ``configuration-user-${user.name}.properties`` loading for development
* ``configuration-env-{default,deployment,<profile>}.properties``,
  then ``/etc/<applicationName>/configuration.properties`` loading for
  qualification, preproduction, production profiles
* Log4j configuration loading with the same patterns
* Spring profiles configuration based on ``igloo.default.spring.profiles.active``
  and an empty (no profile) default

**Basic-application defaults** are to activate flyway profile and to use defaults
behavior.


Selecting profile
-----------------

Profile can be selected with ``IGLOO_PROFILE`` environment variable or
``igloo.profile`` system property.


Overriding bootstrap phase
--------------------------

Loaded bootstrap files can be overriden with ``IGLOO_BOOTSTRAP_LOCATIONS``
environment variable or ``igloo.bootstrapLocations`` system property.

By default, these new locations are **added** to the default configuration.

To completely override bootstrap locations, you must use ``IGLOO_BOOTSTRAP_OVERRIDE_DEFAULT``
or ``igloo.bootstrapOverrideDefault``.


Default log4j configuration
---------------------------

With default bootstrap configuration, an ``log4j-igloo.properties`` is provided
with some default configurations. This properties can be overriden in you local
``log4j-*.properties``.


Configuration loading logging
-----------------------------

``igloo@config`` logger allow to visualize loaded configurations. Verbose logs
are handled by org.iglooproject.config.bootstrap.* logger names. Missing
configurations are logged with a WARN level.

.. code-block:: properties

   log4j.logger.igloo@config=INFO
   log4j.logger.org.iglooproject.config.bootstrap=WARN

This configuration is included in ``log4j-igloo.properties``.
