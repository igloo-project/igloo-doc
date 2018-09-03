
Configuration management
########################

With version 1.0, configuration management is heavily rewritten. Here are the
steps and precaution to migrate your application.

Class rename
------------

Some classes need a package renaming. Following script should be used for
this operation.

.. literalinclude:: scripts/config-replace.sh
  :language: bash


Maven profile resource filtering removal
----------------------------------------

New projects initialized with basic application no longer use maven profile
to filter resources.

You can still use profiles in your project if you want to (as profiles are
configured in the project, there is no impact on this point).


ConfigurationLocations
----------------------

* ``configurationLocationProvider()``: This attribute is removed from annotation.
  There is no longer customization of this behavior.

* ``locations()``: placeholders available here are now handled differently.

  * ``${user}`` must be replaced by ``${user.name}``
  * ``${environment}`` is no longer available
  * ``${igloo.config}`` is no longer available
  * ``${applicationName}`` must be renamed ``${igloo.applicationName}`` but it
    is recommended to load it with profile configurationLocations setting.

If you use ``environment`` or ``igloo.config``, the preferred way to replace
this behavior is to add the targeted location to your profile definition of
``igloo.configurationLocations`` in your :ref:`bootstrap <config.bootstrap>`
configuration.

With default bootstrap configuration, renaming your file
configuration-env-*.properties (for environment development, preproduction,
production) or configuration-user-*.properties (for user-related file) should
be enough.

Default bootstrap configuration also load ``file:/etc/${igloo.applicationName}/configuration.properties``
with preproduction and production profiles.


log4j.configurationLocations
----------------------------

This configuration must be moved to your bootstrap configuration. Configuration
in ``configuration*.properties`` are ignored.

If you want to use default bootstrap settings, renaming your files may be enough:
*  ``log4j-<environment>.properties`` in ``log4j-env-<environment>``.properties``
*  ``log4j-<user>.properties`` in ``log4j-user-<user>``.properties``


Configuration file naming
-------------------------

With default bootstrap configuration, environment related files are named
``environment-*.properties`` and personal configurations are named
``user-*.properties``.


configuration-private.properties
--------------------------------

configuration-private.properties is no longer loaded from igloo default
configurations. If you use a configuration-private.properties, please add it
to your custom ``ConfigurationLocations.locations``.


configuration-bootstrap*.properties
-----------------------------------

Copy ``configuration-bootstrap.properties`` from basic-application in your
``application-core/src/{main,test}/resources/``.

Rename your ``configuration-test.properties`` to ``configuration-env-test.properties``.

You should check in these files:

* ensure that configurations are available or defined by default for all the
  targetted profiles (i.e.: development, preproduction, production, ...).
* that ``igloo.default.spring.profiles.active`` or by profile setting
  ``igloo.<profile>.spring.profiles.active`` is correct.
* if different Spring profiles are needed in unit-test, you may use @ActiveProfiles
  to handle it test-by-test.
* that loaded log4j configurations are corrects: ``igloo.<profile>.log4j.configurationLocations``


You should also check:

* that your base test class uses ``ExtendedTestApplicationContextInitializer``
* that your base test class activates test profile with @PropertySource("igloo.profile=test")


Runtime
-------

In each target environment, configure either ``IGLOO_PROFILE`` environment variable
or ``igloo.profile`` system property.
