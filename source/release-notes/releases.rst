########
Releases
########

.. _v3.5.2:

3.5.2 (2022-05-02)
##################

Bugfixes
********

* Fix model generation in ``CacheDataProvider``.

.. _v3.5.1:

3.5.1 (2022-04-11)
##################

Bugfixes
********

* `hibernate.xml_mapping_enabled` wrongly set (https://github.com/igloo-project/igloo-parent/issues/60)

.. _v3.4.1:

3.4.1 (2022-04-11)
##################

Bugfixes
********

* `hibernate.xml_mapping_enabled` wrongly set (https://github.com/igloo-project/igloo-parent/issues/60)

.. _v3.5.0:

3.5.0 (2022-03-09)
##################

Updates
*******

* wicket 8.13.0 -> 9.7.0

.. _v3.1.1:

3.1.1 (2022-03-08)
##################

Bugfixes
********

* Fix ``TFileRegistry`` static create methods.

.. _v3.4.0:

3.4.0 (2022-02-24)
##################

Breaking changes
****************

Hibernate type discovery
------------------------

Since hibernate 5.4.30, it's not possible to use a ``@MappedSuperclass`` unused
entity (if no ``@Entity`` inherits from it, then it's ignored). It triggers failure
on ``TypeDefinitions.java`` that is used to declare ``@TypeDef`` custom types
definitions.

To migrate your project, it's necessary to take all the types used with ``@TypeDef``
annotation (usually located in ``TypeDefinitions.java``) and you need to transfer them to
``<Project>CoreCommonJpaConfig.java``. Check `commit <https://github.com/igloo-project/igloo-parent/commit/1bbb6fb8f79688489ddce4c04c607a0349cbd642#diff-5c5d84501a57bb0440fedb0e199774392a43e7dc6c03814267a13f1bd4cb803eL37>`_
and `commit <https://github.com/igloo-project/igloo-parent/commit/9ebc21de6cb3831b9d5a44e87771dc97ad5fd7b>`_
for new-style type declaration: declare a ``TypeContributor`` bean with your custom types
so that Igloo can detect them and configure Hibernate accordingly.

``TypeDefinitions.java`` file can be deleted.

Hibernate XML mapping (configuration and dependencies)
------------------------------------------------------

Default Hibernate configuration is modified to set ``hibernate.xml_mapping_enabled=false``
and dom4j and jaxb are excluded from hibernate dependencies. If you use XML entity mappings,
you must override property and restore dependencies.

Updates
*******

* hibernate 5.4.29 -> 5.4.33
* postgresql driver: 42.3.1 -> 42.3.3
* spring: 5.3.15 -> 5.3.16
* spring-boot: 2.6.2 -> 2.6.4
* spring-security: 5.6.1 -> 5.6.2
* hibernate-search: 5.11.8 -> 5.11.10
* commons-lang3: 3.11 -> 3.12
* slf4j: 1.7.33 -> 1.7.36
* reload4j: 1.2.18.0 -> 1.2.19
* poi: 5.1.0 -> 5.2.0
* ph-css: 6.4.3 -> 6.5.0
* wicket: 8.13.0 -> 8.14.0
* webjars-locator: 0.49 -> 0.50
* flywaydb 8: 8.4.1 -> 8.5.1
* junit 5: 5.8.0 -> 5.8.2
* mockito: 4.1.0 -> 4.3.1
* errorprone: 2.10.0 -> 2.11.0
* rhino: 1.7.11 -> 1.7.14

Maven plugins:

* maven-jar-plugin: 3.2.0 -> 3.2.2
* maven-javadoc-plugin: 3.3.1 -> 3.3.2
* buildnumber-maven-plugin: 1.4 -> 3.0.0


Fixes
*****

* Restore TFileRegistry static methods (removed with 3.0.0) for TrueVFS registry management.

.. _v3.3.0:

3.3.0 (2022-01-31)
##################

Bugfix / Workaround
*******************

web.xml configuration
---------------------

``basic-application`` is modified to add ``request-character-encoding`` and
``response-character-encoding`` configurations in your `web.xml`,
initiated to UTF-8.

You may need to update your own project accordingly. See basic-application example:
https://github.com/igloo-project/igloo-parent/commit/118281bf9f2b844c7224c07037b489ddd53986a0


@SpringBean workaround
----------------------

This release addresses an issue with wicket and ``@SpringBean`` annotation.
When we want to inject a collection of beans looked up by type, if there
is **one only spring bean** that implements the collection type, it is
used, whereas the expected behavior is to build a collection of all the
beans matching the expected generic type.

If there is no collection bean, or more than one collection bean, bean
lookup is correctly done.

The workaround is to create two beans implementing ``Collection<Object>``
so that ``@SpringBean`` trigger the correct behavior. This workaround
is triggered by ``IglooApplicationConfigAutoConfiguration``.

No action is needed to migrate a project.


@PropertySource, CompositePropertySourceFactory and encoding
------------------------------------------------------------

CompositePropertySourceFactory does not honor ``PropertySource#encoding``.
This release fixes this issue, and all Igloo managed ``@PropertySource`` are
configured to use ``UTF-8`` encoding.

No action is needed to migrate a project. If you use your own ``@PropertySource``
annotations, you may update encoding attribute.


maven-processor-plugin
----------------------

``skipSourcesUnchanged`` removed from configuraiton. If true, it is needed to
fully remove ``target/generated-sources/apt`` to trigger a binding generation.
As Eclipse does not remove whole target folder on clean, it implied manual
actions to refresh generated bindings.


Updates
*******

* Spring-security 5.4.10 -> 5.6.1

XML context security files are removed from Igloo and replaced by javaconfig.
As XML xsd references spring-security version, it eases spring-security version
switch as it no longer complains about xsd version mismatch.

Igloo XML context security file is replaced by an equivalent javaconfig configuration.

If your project contains any ``*security-context.xml`` file, **you need to update
spring-security version from 5.4 to 5.6 in XSD declarations**.

* TaskManagement uses a spring-like Configurer pattern for queueids discovery. It
  is done to get rid of Collection beans. BasicApplication is modified to use this
  new pattern, but existing Collection<IQueueId> bean continue to get honored
  (with a warning at startup), so no change is needed on projects.

  See BasicApplicationCoreTaskManagementConfig for basic-application example
  **to migrate your queueid definition accordingly.**

* h2 CVE-2022-23221: 2.0.206 -> 2.1.210 (h2 is only used for testing purposes).

  No action is needed to migrate a project.

.. _v3.2.1:

3.2.1 (2020-01-26)
##################

Bugfixes
********

* Fix a bug with Flyway compatibility layer introduced in 3.2.0; without this fix, Flyway 7.x cannot be used.

.. _v3.2.0:

3.2.0 (2022-01-17)
##################

Breaking changes
****************

* Flyway is updated (7.x -> 8.x) and Flyway 8.x is not compatible with
  PostgreSQL 9.6. If you use PostgreSQL 9.6, a compatibility layer is
  provided to continue use Flyway 7.x:

  * In your core module, add a dependency exclusion on
    ``org.iglooproject.components:igloo-component-flyway-8`` and manually
    add ``org.iglooproject.components:igloo-component-flyway-7``
  * Check in your dependencies that flyway-core artifact has version ``7.15.0``
  * If this is not the case, add the needed exclusion to ensure that flywaydb
    version is handled by ``igloo-component-flyway-7`` artifact
  * Change import `org.iglooproject.jpa.migration.IglooMigration` to `org.iglooproject.flyway.IglooMigration`

* Deprecated log4j 1.2.x dependency is replaced by ``reload4j`` (https://reload4j.qos.ch/).
  It is a drop-in replacement (no action needed to use this new dependency, except if you
  manually import log4j 1.2). You may migrate to log4j 2 as log4j 1.2 is deprecated and
  reload4j is just an emergency solution.

* JSASS triggers a warning. You may check that styles are correct. If you encounter any issues you can downgrade jsass
  by setting property ``<igloo.jsass.version>5.10.3</igloo.jsass.version>``
  (see https://gitlab.com/jsass/jsass/-/issues/95).

  .. code::

    [ERROR] DEPRECATION WARNING on line 1 of classpath:/org/iglooproject/basicapp/web/application/common/template/resources/styles/application/advanced/styles.scss/JSASS_CUSTOM.scss:
    [ERROR] !global assignments won't be able to declare new variables in future versions.
    [ERROR] Consider adding `$jsass-void: null` at the top level.

* A lot of dependency updates. Please check the Dependencies entry below.

Dependencies
************

* Spring 5.2.9 -> 5.3.15
* Spring security 5.4.1 -> 5.4.10
* Spring boot 2.3.4 -> 2.6.2
* Hibernate 5.4.21 -> 5.4.29
* Hibernate Search 5.11.5 -> 5.11.8
* Wicket 8.12.0 -> 8.13.0
* Wicket Wiquery (include JQuery UI 1.12.1 -> 1.13.0) 8.1.1 -> 8.2.0
* FlywayDB 7.15.0 -> 8.4.1 (Flyway 7.x can still be used, see breaking changes)

* HikariCP 3.4.5 -> 5.0.1
* Spring LDAP 2.3.3 -> 2.3.5
* Guava 29.0-jre -> 31.0.1-jre
* PostgreSQL JDBC Driver 42.2.14 -> 42.3.1
* POI 4.1.2 -> 5.1.0
* Jackson 2 2.11.3 -> 2.13.1
* Javax/Jakarta mail 1.6.6 -> 1.6.7
* SLF4J 1.7.30 -> 1.7.33
* Log4j2 2.17.0 -> 2.17.1
* Apache HTTPComponents Core 4.4.13 -> 4.4.15

* AspectJ 1.9.6 -> 1.9.7
* Byte-buddy 1.10.10 -> 1.12.6
* JBoss Logging 3.4.1 -> 3.4.3
* JBoss Logging Annotations -> 2.2.0
* JDK Serializable functions 1.8.6 -> 1.9.0
* Freemarker 2.3.30 -> 2.3.31
* BouncyCastle jdk15on 1.68 -> 1.70
* Flying Saucer 9.1.20 -> 9.1.22
* JSoup 1.14.2 -> 1.14.3
* Pretty-time 4.0.6 -> 5.0.2
* PH-CCS 6.2.3 -> 6.4.2
* Validation API 1.1.0 -> 2.0.1
* Webjars locator 0.46 -> 0.48
* JSASS 5.10.3 -> 5.10.4
* Passay 1.6.0 -> 1.6.1

* Junit 5 5.7.0 -> 5.8.0
* H2 1.4.200 -> 2.0.206
* Mockito 3.5.15 -> 4.1.0
* AssertJ 3.17.2 -> 3.22.0

This release breaks Flyway compatibility layer : Flyway 7.x cannot be used. Please use 3.2.1.

.. _v3.1.0:

3.1.0 (2021-12-23)
##################

Breaking changes
****************

* Hibernate Search initialization now authorizes hibernate-search,
  lucene or elasticsearch dependencies to be removed if not used.

  Add lucene integration to your project:

  .. code-block:: xml

		<dependency>
			<groupId>org.iglooproject.components</groupId>
			<artifactId>igloo-component-hibernate-configurator-lucene</artifactId>
			<version>${igloo.version}</version>
		</dependency>

* ``wicket-webjars`` 2.0.20 update. Resource paths not beginning by ``webjars/``
  are broken. If you use custom webjars resource reference (check ``WebjarsJQueryPluginResourceReference``,
  ``WebjarsJavaScriptResourceReference``, ``WebjarsCoreJQueryPluginResourceReference`` derived classes),
  ensure that your resource path begins by ``webjars``.

  Example:

  .. code-block:: diff

     private BootstrapAlertJavaScriptResourceReference() {
    -  super("bootstrap/current/js/dist/alert.js");
    +  super("webjars/bootstrap/current/js/dist/alert.js");
     }


Dependencies
************

* We no longer override cglib-nodep dependency. It is managed exclusively
  by wicket-ioc.
* Compilation-time code quality annotations dependencies are moved to
  provided scope, so that it does not clutter war artifact.
* ``com.sun.mail:javax.mail`` is replaced by ``com.sun.mail:jakarta.mail``. Check
  in that your dependencies are updated and does not contain old dependency.

Removed
*******

* LessCss / Less4j is removed
* maven-enforcer-plugin ``DependencyConvergence`` rule is replaced by ``requireUpperBoundDeps``:
  transitive dependencies versions no longer need to be consistent, but they needs to match
  the last version of candidate dependencies
* ``glyphicons-halflings-white.png`` and ``glyphicons-halflings`` are removed (used by bootstrap 3,
  also removed previously)


Bugfixes
********

* City : update xlsx init file - postalcode with 5 characters
* Feedbacks : update style (fatal + debug)


.. _v3.0.3:

3.0.3 (2021-12-22)
##################

Fix for CVE-2021-45105 Log4Shell. The only modification from 3.0.2 is the log4j dependency update (2.17.0).

.. _v2.7.6:

2.7.6 (2021-12-22)
##################

Fix for CVE-2021-45105 Log4Shell. The only modification from 2.7.5 is the log4j dependency update (2.17.0).

.. _v3.0.2:

3.0.2 (2021-12-16)
##################

Fix for CVE-2021-45046 Log4Shell. The only modification from 3.0.1 is the log4j dependency update (2.16.0).

.. _v2.7.5:

2.7.5 (2021-12-16)
##################

Fix for CVE-2021-45046 Log4Shell. The only modification from 2.7.4 is the log4j dependency update (2.16.0).

.. _v2.7.4:

2.7.4 (2021-12-14)
##################

Fix for CVE-2021-44228 Log4Shell. The only modification from 2.7.2 is the log4j dependency update (2.15.0).

Fix broken jgtiflow configuration introduced in 2.7.3.


.. _v3.0.1:

3.0.1 (2021-12-13)
##################

Fix for CVE-2021-44228 Log4Shell. The only modification from 3.0.0 is the log4j dependency update (2.15.0).

.. _v2.7.3:

2.7.3 (2021-12-13)
##################

Fix for CVE-2021-44228 Log4Shell. The only modification from 2.7.2 is the log4j dependency update (2.15.0).

This release breaks jgtiflow configuration. Please use 2.7.4.


.. _v3.0.0:

3.0.0 (2021-11-25)
##################

Updates
*******

* Jackson ``QueuedTaskHolder`` serializer configuration is modified to remove
  deprecated APIs; task output in console modified to use Jackson nodetree
  (it allows to get rid of a real deserialization).
* Removed POI deprecated API calls.
* Fix ``javax.annotations-api`` dependency issue.
* QueryDSL 4.4.0 -> 5.0.0 (check your JPA / SQL query generation)

Breaking changes
****************

* Removed Java < 11 support.
* Removed servlet < 4.0 support.
* Removed ``externallinkchecker``: if you want to use it, fork the module and
  put it into you project.
* Removed ``org.iglooproject.jpa.more.business.execution``: if you use it, fork
  the module and put it into your project.
* Removed ``org.javatuples:javatuples`` from ``igloo-component-commons``; if you
  use it, add this dependency to your project.
* TrueZip replaced by TrueVFS.
* Jersey update: Jersey version implies Java EE 8 API, so it implies tomcat >= 9.x
*

Java 11 and Servlet 4.0
***********************

Igloo now uses Java 11 and Servlet 4.0. See here what you need to do to perform Java 11 and Servlet 4.0 migration.
:ref:`Migrating to Java 11 and Servlet 4.0 <migrating-to-java11>`

.. _v2.7.2:

2.7.2 (2021-11-19)
##################

Bugfixes
********

* Select2: temporary fix focus search input.

.. _v2.7.1:

2.7.1 (2021-10-07)
##################

Bugfixes
********

* Select2: temporary fix focus search input.

.. _v2.7.0:

2.7.0 (2021-09-07)
##################

Updates
*******

* Font Awesome 5.15.1 -> 5.15.2
* commons-compress 1.20 -> 1.21
* jsoup 1.13.1 -> 1.14.2

Enhancements
************

* BasicApp: use ``ExternalLink`` in notification emails.
* BasicApp: add reference data read-only list feature.
* BasicApp: refactor condition on enable/disable actions.
* WicketTester : new test case for first sign in workflow
* Revert ``@Basic`` for user and user group generic classes, keep with ``@Colmun`` for override.

.. _v2.6.0:

2.6.0 (2021-07-30)
##################

Bugfixes
********

* BasicApp: fix ``enabled`` / ``active`` fields for ``User`` and ``Announcement``.
* BasicApp: fix administration breadcrumb.
* ``AbstractMapCollectionModel``: fix ``.size()`` method.

Updates
*******

* wicket 8.10.0 -> 8.12.0
* wicketstuff-select2 8.10.0 -> 8.12.0

Enhancements
************

* Fix container max width mixin deprecated message.
* BasiApp: erros pages use same layout than application access pages.
* BasicApp: use ``color-yiq`` for color consistency (component active + navbar main).
* BasicApp: add rel noopener on target blank links.
* BasicApp: add meta description.
* ``EnumDropDownMultipleChoice`` : ``Collection`` instead of ``List`` for choices model.
* Fix HTML ``<title>`` to be on one line.

.. _v2.5.0:

2.5.0 (2021-04-12)
##################

Breaking changes
****************

* User - rename field active to enabled for consistency.
* BasicApp: Announcement - rename field active to enabled for consistency.
* BasicApp: ReferenceData - update enabled properties for consistency.
* User - remove useless attributs (phone numbers)
* User - rename 2 comparators for consistency.
* User - rename groups join table.
* User - rename package person to user for consistency.
* User - fix create entity service method.
* User - clean flush in save
* BasicApp: clean useless spring component name value.
* User - update service and dao name value for consistency.

Enhancements
************

* BasicApp: consistency for ``enabled`` fields in ``User`` and ``Announcement``.
* SqlUpdateScript: (used in <Project>SqlUpdateScriptMain) target file is now
  overwritten (previously, SQL script was append to the target file).

.. _v2.4.0:

2.4.0 (2021-04-02)
##################

Breaking changes
****************

* **Bootstrap 4.5.3 -> 4.6.0**

Updates
*******

* **Bootstrap 4.5.3 -> 4.6.0**
* Font Awesome 5.15.1 -> 5.15.2
* Clipboard.js 2.0.6 -> 2.0.8

Bugfixes
********

* Security: remove user active / enabled check, done by Spring Security during authentication.
* Fix Select2 css box shadow focus error state.
* BasicApp: fix scss import BS utilities.
* BasicApp: fix margin bottom application access.

Enhancements
************

* BasicApp: small changes on sidebar scss.
* BasicApp: use kobalt email address for admin user.
* BasicApp: use shared email address in filter mode.
* BasicApp: refactor sign in content page.

.. _v2.3.1:

2.3.1 (2021-02-05)
##################

Breaking changes
****************

* **Bootstrap 4.5.0 -> 4.5.3**
* Refactor password security options.

Updates
*******

* **Bootstrap 4.5.0 -> 4.5.3**
* Font Awesome 5.14.0 -> 5.15.1

Bugfixes
********

* BasicApp: fix ``User`` permission evaluator.
* BasicApp: fix ehcache xsd url.

Enhancements
************

* Add ``hasPasswordHash()`` in ``GenericUser``.
* BasicApp: fix sign out on password security pages.
* BasicApp: add first sign in workflow.
* BasicApp: clean up user password recovery notification panel.
* BasicApp: use bypassPermissions for links in notification panels.
* BasicApp: add fallback url in mail notifications.
* BasicApp: add properties console page.
* BasicApp: rename resources properties packages and classes for consistency.
* BasicApp: wording for ``HistoryLog`` mandatory differences search query.
* BasicApp: Update resource key update password.
* BasicApp: properties for password length min max.
* BasicApp: refactor condition on enable/disable actions.
* Permission Evaluator: object no longer needs to be a ``GenericEntity``.

.. _v2.3.0:

2.3.0
#####

Not released.

.. _v2.2.1:

2.2.1 (2020-12-01)
##################

Breaking changes
****************

* BasicApp: rework batch report console page

.. _v2.2.0:

2.2.0 (2020-11-19)
##################

Breaking changes
****************

* New default logging backend : log4j2

  * :ref:`Keep log4j 1.2 <keep-log4j1>`
  * :ref:`Migrate to log4j2 <migrate-log4j1>`

* Spring boot update related change : if you have ``new  ApplicationContextRunner()``
  declared in your application or tests and you want to override existing beans,
  you now need to add ``.withAllowBeanDefinitionOverriding(true)``

* Flyway update related change :

    - you must override ``getEquivalentChecksum`` either in ``AbstractDataUpgradeMigration.java``
      or in each of your migrations. This function
      is used if you want to state that two of your migrations are doing the same thing and if one pass
      the other must not be executed. The default implementation is to call ``getChecksum()``.
    - You can now have the possibility to override in each of your migrations the following functions :

      - ``isUndo`` if you want to flag your migration as undoing another (default is false)
      - ``canExecuteInTransaction`` if you want your migration not to be executed in a transaction (default is false)

    - You also need to modify the flyway locations in your properties file as dot-separated
      path are no longer supported by flyway, you need to refactor them in slash-separated path.

* Spring Security update related change : references to http://www.springframework.org/schema/security/spring-security-5.3.xsd
  url must be rewritten to https://www.springframework.org/schema/security/spring-security-5.4.xsd.

Updates
*******

* **spring-framework 5.2.6.RELEASE -> 5.2.9.RELEASE**
* **spring-security 5.3.2.RELEASE -> 5.4.1**
* **spring-boot 2.2.7.RELEASE -> 2.3.4.RELEASE**
* **spring-ldap 2.3.2.RELEASE -> 2.3.3.RELEASE**
* **hibernate 5.4.16.Final -> 5.4.21.Final**

  * Hibernate 5.4.22 skipped, waiting for
    https://hibernate.atlassian.net/browse/HHH-14279 fix

* **hibernate-search 5.11.4.Final -> 5.11.5.Final**
* **wicket 8.8.0 -> 8.10.0**
* **wicketstuff-select2 8.8.0 -> 8.10.0**
* flyway 5.2.7 -> 7.0.2
* jackson 2.10.4 -> 2.11.3
* jackson-databind 2.10.4 -> 2.11.3
* commons-codec 1.14 -> 1.15
* commons-validator 1.6 -> 1.7
* commons-lang3 3.10 -> 3.11
* commons-text 1.8 -> 1.9
* aspectj 1.9.5 -> 1.9.6
* bouncycastle-jdk15on 1.65 -> 1.66
* postgresql 42.2.12 -> 42.2.14
* webjars-locator-core 0.45 -> 0.46
* flying-saucer 9.1.19 -> 9.1.20
* querydsl 4.3.1 -> 4.4.0
* httpclient 4.5.12 -> 4.5.13
* prettytime 4.0.5 -> 4.0.6
* allure-junit4 2.13.3 -> 2.13.6
* assertj 3.16.1 -> 3.17.2
* mockito 3.3.3 -> 3.5.13
* maven-failsafe-plugin 3.0.0-M4 -> 3.0.0-M5
* maven-project-info-reports-plugin 3.0.0 -> 3.1.1
* maven-resources-plugin  3.1.0 -> 3.2.0
* maven-surefire-plugin 3.0.0-M4 -> 3.0.0-M5
* maven-war-plugin 3.2.3 -> 3.3.1
* exec-maven-plugin 1.6.0 -> 3.0.0
* wagon-ssh-external 3.3.4 -> 3.4.1
* jacoco-maven-plugin 0.8.5 -> 0.8.6
* maven-javadoc-plugin 3.1.1 -> 3.2.0
* junit 4.13 -> 4.13.1
* log4j2 support 2.13.3

Bugfixes
********

* Wicket: allow \*.webmanifest in SecurePackageResourceGuard
* Fix missing scope:test on igloo-component-web-jpa-test in igloo-component-rest-jersey2
* BS4 Popover: fix close button.
* Fix add-in elements css placements in ``DataTableBuilder``.

Enhancements
************

* BasicApp: drop ``init`` module.
* BasicApp: move ``BasicApplicationSqlUpdateScriptMain`` to ``cli`` package in
  ``core`` module.
* BasicApp: rename ``INotificationUserProfileUrlBuilderService`` to
  ``IBasicApplicationNotificationUrlBuilderService``.
* BasicApp: update favicons and conf.
* BasicApp: rework logo header sections in application access pages, error
  pages, and the home page.
* BasicApp: fix decorated table add-in elements margin.
* BasicApp: update user groups list page.
* BasicApp: fix permissions on users and usergroups.
* BasicApp: add ``ReferenceDataAjaxDropDownSingleChoice`` and
  ``ReferenceDataAjaxDropDownMultipleChoice``.
* BS4 tabs: update url anchor and show tab from anchor on load.
* jQuery multivalued expand: fix toggle button html.

  * Explicit close ``</span>`` for icons.
  * Use ``<span>`` instead of ``<a>`` to wrap icons.

.. _v1.7.2:

1.7.2 (2020-09-16)
##################

Bugfixes
********

* Fix export Excel cell formula type.

.. _v2.1.1:

2.1.1 (2020-09-15)
##################

Bugfixes
********

* Fix export Excel cell formula type.

.. _v2.1.0:

2.1.0 (2020-09-09)
##################

Enhancements
************

* BasicApp: fix style notification password recovery.
* Animal-sniffer maven plugin is not disabled for JDK >1.8, as it is
  now managed since JDK 9.
* Add new MediaType ``APPLICATION_MS_EXCEL_MACRO`` to handle macros

.. _v2.0.0:

2.0.0 (2020-07-29)
##################

Breaking changes
****************

* **Bootstrap 4.5.0.**
* **Disable Autoprefixer in development mode.**
* Rework ``toString()`` on ``GenericEntity``. Drop ``getNameForToString()`` and
  ``getDisplayName``.
* Drop Bootstrap 3 module.
* Remove JQuery Autosize plugin.
* ``IComponentFactory`` and parameterized ones are now functional interfaces.
  Drop ``AbstractComponentFactory``, ``AbstractParameterizedComponentFactory``
  and ``AbstractDecoratingComponentFactory``.
* Fix null values display in Excel exports. For instance, a number cell will be
  blank instead of displaying zero.
* Remove ``$sizes`` scss variable override.

Updates
*******

* **Bootstrap 4.3.1 -> 4.5.0**
* Font Awesome 5.11.2 -> 5.14.0
* Popper.js 1.16.0 -> 1.16.1-lts
* Clipboard.js 2.0.4 -> 2.0.6

Bugfixes
********

* BasicApp: fix ``<span>`` close tag on static error pages.
* BasicApp: fix reference data sort type label.

Enhancements
************

* BasicApp: remove BS override shadow focus.
* BasicApp: fix markup custom check.
* BasicApp: forms - use ``col-md-*`` instead of ``col-sm-*``.
* BasicApp: environment section in sidebar for advanced layout.
* BasicApp: hover on table disabled row + upstream scss to Igloo.
* BasicApp: fix sidebar sub menu collapse animation.
* BasicApp: clean up + update css on email notifications.
* BasicApp: add ``.divider-light`` css class.
* BasicApp: advanced layout as default.
* Fix some Sonar issues.
* Clean up some deprecated.
* ``LinkDescriptor``: ``bypassPermissions`` method no longer deprecated.
* Add a debug stopwatch on Autoprefixer process.

.. _v1.7.1:

1.7.1 (2020-06-17)
##################

Enhancements
************

* Add ``ConditionalOnMissingBean`` annotation on default
  ``AuthenticationProvider`` to allow use of exclusively custom
  ``AuthenticationProvider``.

.. _v1.7.0:

1.7.0 (2020-06-16)
##################

Bugfixes
********

* Fix ``ReferenceData`` comparator.

Enhancements
************

* Select2: force size 1 row.
* Select2 - BS4: override selected element background color.
* Make class ``AbstractImmutableMaterializedPrimitiveValueUserType`` public.
* ``AbstractUnicityFormValidator``: all ``FormComponent`` are flagged on error.
* Hibernate identifier generator strategy can now be customized through
  property ``hibernate.identifier_generator_strategy_provider``, with
  a fallback on the previous default ``PerTableSequenceStrategyProvider``.
* ``PredefinedIdSequenceGenerator`` is a new sequence generator allowing
  to set entity ids manually base on a transient field ``predefinedId``.

Updates
*******

* **spring-framework 5.2.2.RELEASE -> 5.2.6.RELEASE**
* **spring-security 5.2.1.RELEASE -> 5.3.2.RELEASE**
* **spring-boot 2.1.3.RELEASE -> 2.2.7.RELEASE**
* **hibernate 5.4.10.Final -> 5.4.16.Final**
* *byte-buddy 1.10.2 -> 1.10.10*
* **wicket 8.6.1 -> 8.8.0**
* *wicketstuff-select2 8.6.0 -> 8.8.0*
* jackson 2.9.10 -> 2.10.4
* jackson-databind 2.9.10.1 -> 2.10.4
* guava 28.1-jre -> 29.0-jre
* ph-css 6.2.0 -> 6.2.3
* querydsl 4.2.2 -> 4.3.1
* HikariCP 3.4.1 -> 3.4.5
* commons-codec 1.13 -> 1.14
* commons-compress 1.19 -> 1.20
* commons-configuration2 2.6 -> 2.7
* commons-lang3 3.9 -> 3.10
* httpclient 4.5.10 -> 4.5.12
* httpcore 4.4.12 -> 4.4.13
* apache-poi 4.1.1 -> 4.1.2
* bouncycastle bcprov-jdk15on 1.64 -> 1.65
* freemarker 2.3.29 -> 2.3.30
* javassist 3.26.0-GA -> 3.27.0-GA
* jsoup 1.12.1 -> 1.13.1
* prettytime 4.0.2.Final -> 4.0.5.Final
* passay 1.5.0 -> 1.6.0
* postgresql 42.2.9 -> 42.2.12
* slf4j 1.7.29 -> 1.7.30
* webjars-locator-core 0.43 -> 0.45
* flying-saucer 9.1.19 -> 9.1.20
* jdk-serializable-functional 1.8.5 -> 1.8.6
* maven-antrun 1.5.0 -> 3.0.0
* maven-assembly-plugin 3.2.0 -> 3.3.0
* maven-dependency-plugin 3.1.1 -> 3.1.2
* maven-jar-plugin 3.1.1 -> 3.2.0
* maven-javadoc-plugin 3.1.1 -> 3.2.0
* maven-source-plugin 3.2.0 -> 3.2.1
* mockito 3.2.0 -> 3.3.3
* allure-junit4 2.13.0 -> 2.13.3
* junit 4.12 -> 4.13
* assertj 3.14.0 -> 3.16.1
* assertj-guava 3.3.0 -> 3.4.0

.. _v1.6.1:

1.6.1 (2020-04-24)
##################

Enhancements
************

* BasicApp: user - fix user group add form layout.
* BasicApp: user group - fix authorities list layout.
* BasicApp: users - remove useless ``withNoRecordsResourceKey``.
* BasicApp: move bs breakpoint div to the bottom.
* Boostrap Override: remove ``.card-${color}-full``.

.. _v1.6.0:

1.6.0 (2020-03-13)
##################

Enhancements
************

* BasicApp: major markup and scss changes.
* Fix jQuery UI datepicker positioning and input height value.

.. _v1.5.2:

1.5.2 (2020-03-12)
##################

Bugfixes
********

* Fix spring-security namespace; without this fix, network-less application
  start is not possible because spring-security namespace cannot be mapped with
  jar's provided .xsd.

  In your application, you need to replace in XML files
  http(s)://www.springframework.org/schema/security/spring-security\*.xsd URL
  by https://www.springframework.org/schema/security/spring-security-5.2.xsd.

  This URLs are mapped by Spring to jar's provided files.

.. _v1.5.1:

1.5.1 (2020-01-10)
##################

Bugfixes
********

* Fix manifest resource finding error.

.. _v1.5.0:

1.5.0 (2020-01-06)
##################

Breaking changes and enhancements are introduced to allow usage of
autoconfiguration and to prepare a future reorganization and splitting of
Igloo modules, to ease future development and maintenance tasks.

Breaking changes
****************

* Configuration system is modified to replace custom ``@ConfigurationLocations``
  system by spring vanilla ``@PropertySource``. See
  :ref:`property-source-migration` to find how to modify your application and
  check that configuration is correctly managed.
* Spring Security related change : references to http://www.springframework.org/schema/security/spring-security-4.2.xsd
  url must be rewritten to http://www.springframework.org/schema/security/spring-security.xsd
  (same file, but does not trigger a failed check on version done by Spring Security at startup time).

Updates
*******

* **wicket 8.2.0 -> 8.6.0**
* **hibernate 5.4.2.Final -> 5.4.10.Final**
* **hibernate-search 5.11.1 -> 5.11.4**
* **spring-framework 5.1.6.RELEASE -> 5.2.2.RELEASE**
* **spring-security 5.1.4.RELEASE -> 5.2.1.RELEASE**
* cglib 3.2.10 -> 3.3
* jackson 2.9.8 -> 2.9.10
* gson 2.8.5 -> 2.8.6
* guava 27.1-jre -> 28.1-jre
* ph-css 6.1.2 -> 6.2.0
* HikariCP 3.3.1 -> 3.4.1
* wicket webjars 2.0.10 -> 2.0.16
* jsass 5.8.0 -> 5.10.3
* allure-junit4 2.10.0 -> 2.13.0
* ehcache-core 2.10.6.5.1 -> 2.10.7.0.62
* commons-codec 1.12 -> 1.13
* commons-beanutils 1.9.3 -> 1.9.4
* commons-collections4 4.3 -> 4.4
* commons-compress 1.18 -> 1.19
* commons-configuration 2.4 -> 2.6
* commons-lang3 3.8.1 -> 3.9
* commons-text 1.6 -> 1.8
* httpclient 4.5.8 -> 4.5.10
* httpcore 4.4.11 -> 4.4.12
* wicketstuff-select2 8.2.0 -> 8.6.0
* aspectj 1.9.2 -> 1.9.5
* assertj 3.12.2 -> 3.14.0
* assertj-guava 3.2.1 -> 3.3.0
* bouncycastle bcprov-jdk15on 1.61 -> 1.64
* jdk-serializable-functional 1.8.5 -> 1.9.0
* freemarker 2.3.28 -> 2.3.29
* javassist 3.24.1-GA -> 3.26.0-GA
* jboss-logging 3.3.2.Final -> 3.4.1.Final
* jsoup 1.11.3 -> 1.12.1
* mockito 2.25.1 -> 3.2.0
* passay 1.4.0 -> 1.5.0
* postgresql 42.2.5 -> 42.2.9
* slf4j 1.7.26 -> 1.7.29
* apache-poi 4.1.0 -> 4.1.1
* byte-buddy 1.9.10 -> 1.10.2
* h2database 1.4.199 -> 1.4.200
* querydsl 4.2.1 -> 4.2.2
* webjars-locator-core 0.37 -> 0.43
* maven-compiler-plugin 3.8.0 -> 3.8.1
* maven-javadoc-plugin 3.1.0 -> 3.1.1
* maven-source-plugin 3.0.1 -> 3.2.0
* maven-toolchains-plugin 1.1 -> 3.0.0
* maven-war-plugin 3.2.2 -> 3.2.3
* jacoco-maven-plugin 0.8.3 -> 0.8.5
* dependency-check-maven 5.2.1 -> 5.2.4
* animal-sniffer-maven-plugin 1.17 -> 1.18
* maven-antrun 1.4.0 -> 1.5.0
* maven-assembly-plugin 3.1.1 -> 3.2.0
* maven-failsafe-plugin 3.0.0-M3 -> 3.0.0-M4
* maven-surefire-plugin 3.0.0-M3 -> 3.0.0-M4
* wagon-ssh-external 3.3.3 -> 3.3.4
* maven-enforcer-plugin 3.0.0-M2 -> 3.0.0-M3

Enhancements
************

* basic-application now uses autoconfiguration
* ``GenericEntity`` can be used without hibernate dependency (this allow to
  use existing entity objects in third-party micro-services if needed)
* ``WicketRendererServiceImpl``: add ``renderPage(...)`` method
  (similar to ``renderComponent(...)`` method)
* bindgen-functional now includes ``java.time.*`` bindings (jdk8+ date/time
  APIs)

.. _v1.4.0:

1.4.0 (2019-11-28)
##################

Breaking changes
****************

* Remove Google Analytics jQuery plugin.
* Remove CarouFredSel jQuery plugin.
* Remove Hotkeys jQuery plugin.
* Remove Autocomplete jQuery plugin.
* Remove ItemIt jQuery plugin.
* Remove ListFilter jQuery plugin.
* Remove Modal Fancybox jQuery plugin.
* Remove Easing jQuery plugin.
* Remove Placeholder Polyfill jQuery plugin.
* Remove ScrollInViewport jQuery plugin.
* Remove SortableListUpdate jQuery plugin.
* Remove Waypoints jQuery plugin.
* Remove obfuscated email jQuery plugin.
* Remove FileUpload jQuery plugin.
* Remove JSON jQuery plugin.
* Remove CarouFredSel webjar.
* Remove Modal Fancybox webjar.
* Remove JSON jQuery webjar.
* BS4: Keep only jQuery UI datepicker resources (js and css).

Bugfixes
********

* Fix up jQuery UI MonthPicker.
* Fix up JavaScript inherited dependencies.
* Fix confirm modal dependency.

Enhancements
************

* BasicApp: add a custom ``BasicApplicationUserDetailsService`` to deal with
  permissions by role.
* BS3: Move Font Awesome package.

Updates
*******

* jQuery Mask 1.11.2 -> 1.14.16

.. _v1.3.2:

1.3.2 (2019-11-18)
##################

Bugfixes
********

* Fix stackoverflow on ``Announcement`` with ``getNameForToString()`` and
  ``getDisplayName()`` methods.
* Use ``Predicates2`` instead of ``Predicates`` (guava).
* Add missing Bootstrap utility ``.stretched-link``.
* Remove ``position: relative`` from Bootstrap cols.

.. _v1.3.1:

1.3.1 (2019-10-23)
##################

Bugfixes
********

* Transaction synchronization: unbind context before ``doOnRollback`` as
  synchronization is already removed by caller and remaining resources prevent
  correct transaction synchronization creation during ``doOnRollback``.

Updates
*******

* Font Awesome 5.10.2 -> 5.11.2
* Popper.js 1.15.0 -> 1.16.0

.. _v1.3.0:

1.3.0 (2019-10-17)
##################

Breaking changes
****************

* ``DataTableBuilder``: ``.addRowCssClass(...)`` has been removed. Use
  ``.rows().withClass(...).end()`` instead with proper indentation.
* Due to Flyway update, migration parent has changed.
  ``AbstractDataUpgradeMigration.java`` must now implement
  ``IglooMigration.java``.
* Property ``notification.test.emails`` has been
  renamed ``notification.mail.filter.emails``
* Property ``notification.mail.recipientsFiltered`` has been
  replaced by ``notification.mail.send.mode``. It is no longer
  a boolean value. It is now an enumeration, with the following values :

  * ``SEND``, emails are sent to their designated recipients
  * ``FILTER_RECIPIENTS``, email recipients are filtered to a specific list given
    by the property ``notification.mail.filter.emails``
  * ``NO_EMAIL``, no email is sent by the application


Updates
*******

* Select2 4.0.9 -> 4.0.10
* Flyway 5.0.7 -> 5.2.4

Bugfixes
********

* BasicApp: preload scss file for both themes.

Enhancements
************

* Add configuration property ``autoprefixer.enabled`` to enable or disable
  Autoprefixer.
* BasicApp: sidebar user quicksearch only visible for admins.
* Add ``table-layout`` css classes.
  Usage : ``table-layout{-sm|-md|-lg|-xl}-(auto|fixed)``
* ``DataTableBuilder``: row item model dependant behaviors and css classes
  on rows and actions columns elements + single element.

  .. code-block:: text

    - IBuildState#addRowCssClass(IDetachableFactory<? super IModel<? extends T>, ? extends String>);
    - IActionColumnAddedElementState#withClass(String);
    - IActionColumnCommonBuildState#withClassOnElements(String);

  .. code-block:: text

    + IDataTableRowsState#add(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>>);
    + IDataTableRowsState#add(IDetachableFactory<? super IModel<? extends T>, ? extends Behavior> rowsBehaviorFactory);
    + IDataTableRowsState#add(Behavior, Behavior...);
    + IDataTableRowsState#withClass(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IDataTableRowsState#withClass(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IDataTableRowsState#withClass(IModel<? extends String>);
    + IDataTableRowsState#withClass(String, String...);
    + IDataTableRowsState#end();

    + IActionColumnAddedElementState#withClass(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IActionColumnAddedElementState#withClass(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IActionColumnAddedElementState#withClass(IModel<? extends String>);
    + IActionColumnAddedElementState#withClass(String, String...);
    + IActionColumnAddedElementState#add(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>>);
    + IActionColumnAddedElementState#add(IDetachableFactory<? super IModel<? extends T>, ? extends Behavior>);
    + IActionColumnAddedElementState#add(Behavior, Behavior...);

    + IActionColumnCommonBuildState#withClassOnElements(Collection<? extends IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>>);
    + IActionColumnCommonBuildState#withClassOnElements(IDetachableFactory<? super IModel<? extends T>, ? extends IModel<? extends String>>);
    + IActionColumnCommonBuildState#withClassOnElements(IModel<? extends String>);
    + IActionColumnCommonBuildState#withClassOnElements(String, String...);

* ``.gitlab-ci.yml`` integrates an owasp / dependency check

.. _v1.2.0:

1.2.0 (2019-09-05)
##################

Updates
*******

* Font Awesome 5.10.1 -> 5.10.2

Enhancements
************

* Add ``BootstrapCollapseBehavior`` to easily enable BS collapse plugin on
  components.
* BasicApp: sidebar is automatically displayed if there is enough space.
* BasicApp: add ``-webkit-overflow-scrolling: touch`` on sidebar.

.. _v1.1.28:

1.1.28 (2019-08-30)
###################

Breaking changes
****************

* ``QueuedTaskHolder``: remove ``CREATION_DATE_SORT``, ``TRIGGERING_DATE_SORT``,
  ``START_DATE_SORT`` and ``END_DATE_SORT``. Use fields without ``_SORT``
  suffix. **Warning**: ``QueuedTaskHolder`` needs to be reindexed.

Updates
*******

* Bootstrap 3.3.6 -> 3.4.1
* Font Awesome 5.9.0 -> 5.10.1
* Popper.js 1.14.7 -> 1.15.0
* BS4: Select2 4.0.5 -> 4.0.9
* BS3: Select2 4.0.3 -> 4.0.9
* BS3: select2-bootstrap-theme 0.1.0-beta.8 -> 0.1.0-beta.10

Enhancements
************

* Add ``list-group-sub`` css class.

Bugfixes
********

* BS4 modal: remove fade animation on close.
* BS4 tooltip: set ``window`` as default ``boundary`` instead of ``viewport``.
* BS4 select2: remove options tooltip.
* BS3 select2: update tab key behavior.
* Hibernate Search: use Lucene ``missingValue`` parameter on HS field context.

.. _v1.1.27:

1.1.27 (2019-07-26)
###################

Highlights
**********

* BasicApp: update basic and advanced layouts + consistency.
  Revamp sidebar (style and positioning) in advanced layout.
* Add build tool **Autoprefixer**: css prefixes like ``-webkit-``, ``-moz-``,
  ``-ms-``, ``-o-``, etc. are automatically added if needed.
* Added PropertySourceLogger, for debugging/maintenance purpose.

Breaking changes
****************

* Drop Igloo Infinispan maven module.

Bugfixes
********

* ``FilterByModelItemModelAwareCollectionModel``: Use copy of ``unfiltered``
  (iterator) to avoid concurrent modification exceptions.
* ``AbstractJpaSearchQuery``: Method ``containsIfGiven`` use
  ``CollectionPathBase`` instead of ``CollectionPath`` to allow ``SetPath``
  and ``ListPath``.
* Fix wicket-more-jqplot ``pom.xml`` to embed Js files. May fix "resource
  not found" messages when using JQPlot charts.
* Feedback panel (BS4): fix unwanted overlay preventing users to interact with
  the bottom (or top) of the page.

.. _v1.1.26:

1.1.26 (2019-07-03)
###################

Bugfixes
********

* Transaction synchronization: ``unbindContext()`` must be called in a finally
  block. Otherwise, in rare case where previous call ``doOnRollback()`` throw
  an error, context will be bind for the current thread forever. If really
  needed, the new context will not be bind in future (for the same thread).

Enhancements
************

* Announcement: various enhancements and bugfixes.

Updates
*******

* Font Awesome 5.8.1 -> 5.9.0

.. _v1.1.25:

1.1.25 (2019-06-11)
###################

Bugfixes
********

* ``FilterByModelItemModelAwareCollectionModel``: Fix ``size`` method to use
  the filtered iterable instead of using the unfiltered model size.

Enhancements
************

* BS3 affix js: check position on dom ready.

.. _v1.1.24:

1.1.24 (2019-05-03)
###################

Updates
*******

.. warning::
  - **wicket-webjars**: bug in latest versions from 2.0.11 to 2.0.14,
    don't use them.

  - **wicket** and **wicketstuff-select2**: bug in latest version 8.3.0 in
    wicketstuff-select2 dependency.

* **spring-core 5.1.4.RELEASE -> 5.1.6.RELEASE**
* **hibernate-core 5.4.1 -> 5.4.2**
* hibernate-validator 5.4.2 -> 5.4.3
* wicket-webjars 2.0.8 -> 2.0.10
* webjars-locator-core 0.35 -> 0.37
* spring-security 5.1.3.RELEASE -> 5.1.4.RELEASE
* flying-saucer-pdf 9.1.16 -> 9.1.18
* guava 27.0-jre -> 27.1-jre
* commons-codec 1.11 -> 1.12
* jsass 5.7.3 -> 5.7.4
* aspectjrt 1.9.1 -> 1.9.2
* aspectjweaver 1.9.1 -> 1.9.2
* jsch 0.1.54 -> 0.1.55
* slf4j 1.7.25 -> 1.7.26
* cglib-nodep 3.2.8 -> 3.2.10
* ph-css 4.1.3 -> 6.1.2
* HikariCP 3.2.0 -> 3.3.1
* commons-collections4 4.2 -> 4.3
* commons-fileupload 1.3.3 -> 1.4
* commons-configuration2 2.3 -> 2.4
* httpcore 4.5.6 -> 4.5.7
* httpclient 4.4.10 -> 4.4.11
* assertj 3.11.1 -> 3.12.2
* assertj-guava 3.2.0 -> 3.2.1
* elasticsearch 5.6.9 -> 5.6.10
* elasticsearch-cluster-runner 5.6.9.0 -> 5.6.10.0
* flywaydb 5.0.7 -> 5.2.4
* javassist 3.24.0-GA -> 3.24.1-GA
* passay 1.3.1 -> 1.4.0
* allure-junit4 2.8.1 -> 2.10.0
* ehcache 2.10.6 -> 2.10.6.5.1
* allure-maven 2.9 -> 2.10.0
* mockito-core 2.23.0 -> 2.25.1
* jackson 2.9.7 -> 2.9.8
* h2database 1.4.197 -> 1.4.199
* maven-javadoc-plugin 3.0.1 -> 3.1.0
* jacoco-maven-plugin 0.8.0 -> 0.8.3
* maven-assembly-plugin 3.1.0 -> 3.1.1
* maven-clean-plugin 3.0.0 -> 3.1.0
* maven-compiler-plugin 3.7.0 -> 3.8.0
* maven-dependency-plugin 3.0.2 -> 3.1.1
* maven-deploy-plugin 2.8.2 -> 3.0.0-M1
* maven-enforcer-plugin 3.0.0-M1 -> 3.0.0-M2
* maven-install-plugin 2.5.5 -> 3.0.0-M1
* maven-failsafe-plugin 2.21.0 -> 3.0.0-M3
* maven-jar-plugin 3.0.2 -> 3.1.1
* maven-resources-plugin 3.0.2 -> 3.1.1
* maven-surefire-plugin 2.21.0 -> 3.0.0-M3
* maven-war-plugin 3.2.1 -> 3.2.2
* animal-sniffer-maven-plugin 1.16 -> 1.17
* wagon-maven-plugin 1.0 -> 2.0.0
* wagon-ssh-external 3.2.0 -> 3.3.1

Dependencies deleted
********************

* pgjdbc-ng
* solr-core

Enhancements
************

Added `Owasp Dependency-Check and Versions maven plugin`_ for maven dependencies.

.. _Owasp Dependency-Check and Versions maven plugin: ../usage/howtos/owasp-maven-versions-plugin.html

Refactor basic-application java configuration, now uses a `custom Spring-boot annotation`_.

.. _custom Spring-boot annotation: ../usage/howtos/spring-boot.html

.. _v1.1.23:

1.1.23 (2019-03-04)
###################

Enhancements
************

* Excel init data: fallback on old xls format to avoid breaking change.

.. _v1.1.22:

1.1.22 (2019-03-04)
###################

Breaking changes
****************

* Refactor ``ReferenceData``:

  * Remove ``*Simple*ReferenceData*`` classes and references.
  * Rename ``*Localized*GenericReferenceData*`` classes and references to
    ``*GenericReferenceData*``
  * BasicApp: rename ``*LocalizedReferenceData*`` classes and references to
    ``*ReferenceData*``.
  * BasicApp: rename ``*Simple*ReferenceData*`` classes and references to
    ``*Basic*ReferenceData*``.

Enhancements
************

.. warning::

  This is a unwanted breaking change. Use 1.1.23 instead to keep using the old
  xls format.

* Excel init data: use xlsx format instead of xls.

.. _v1.1.21:

1.1.21 (2019-03-29)
####################################

Updates
*******

* Bootstrap 4.2.1 -> 4.3.1
* Font Awesome 5.7.0 -> 5.8.1
* popper.js 1.14.6 -> 1.14.7

Bugfixes
********

* BasicApp: fix ``UserPasswordValidator`` to check the username rule. It now
  has to be added to a ``ModelValidatingForm`` instead of a ``Form``.
* BasicApp: fix email check on password reset page.

Enhancements
************

* Select2: override BS theme to make multiple selection choices more responsive.

.. _v1.1.20:

1.1.20 (2019-03-22)
###################

Bugfixes
********

* Fix Hibernate Search sort util to deal with score sort.
* Fix condition for ``notEmpty`` and ``mapNotEmpty`` predicates.

Enhancements
************

* BS3 module:

  * Custom Select2 4.0.3 js file.
  * Update Select2 Bootstrap 3 theme and clean up override.
  * Update JQuery UI to 1.12.1 with custom js and css files.
  * Change pagination default size (small) in panel add-in.
  * Update logo on console sign in page.
  * Change modal backdrop style.
  * Fix popover html template.


.. _v1.1.19:

1.1.19 (2019-02-25)
###################

Updates
*******

* Bindgen 4.0.1 -> 4.0.2

Enhancements
************

* Update and fix footer layout on BasicApp and console template.

.. _v1.1.18:

1.1.18 (2019-02-13)
###################

Updates
*******

* Hibernate 5.3.7 -> 5.4.0
* Hibernate 5.10.4 -> 5.11.0
* Spring 5.0.10 -> 5.1.4
* Spring security 5.0.9 -> 5.1.3
* Font Awesome 5.6.3 -> 5.7.0

Hibernate & JAXB dependencies
-----------------------------

From 5.4.0, Hibernate includes JAXB dependencies in pom.xml, so this new release
transitively includes javax.xml.bind:jaxb-api and org.glassfish.jaxb:jaxb-runtime
(and transitive dependencies). Please check your dependencies.

Enhancements
************

* Improve inclusion of tables into cards with new custom css classes (``.table-bordered-inner``, ``.table-card-body``, ``.card-body-table``).
  From now on every content in a ``card`` should be placed under a ``card-body`` element.
* Add new method ``replaceAll`` in ``CollectionUtils`` utilitary to provide the transformation to operate on the reverse collection.
* Creation of a new Igloo module, ``igloo-component-jpa-more-test``, that was originally included in ``igloo-component-jpa-more``. It includes utilitaries for tests
  and all tests present in ``igloo-component-jpa-more`` ``src/test`` package.
* Select2: Override ``ChoiceProvider`` to add ``offset`` and ``limit`` parameters to ``query`` method.
  Also, compute ``hasMore`` attribut for ajax response.

.. _v1.1.17:

1.1.17 (2019-01-04)
###################

Updates
*******

 * Bootstrap 4.1.3 -> 4.2.1
 * Font Awesome 5.6.1 -> 5.6.3

.. _v1.1.16:

1.1.16 (2018-12-28)
###################

Bugfixes
********

* Fix partial reindexation form not submitted.
* BasicApp: fix email in import excel files.

Breaking changes
****************

* Update scss custom grid:

  * Remove ``.row-default`` and ``.row-compact``, use ``.row-md`` and ``.row-xs`` instead.
  * Change ``$grid-gutter-widths`` to ``$grid-gutters`` and update keys from ``(0, 1, 2, 3, 4, 5, 6)`` to ``(0, xxs, xs, sm, md, lg, xl, xxl)``.
  * Add ``$layout-container-padding-x`` for consistency across containers in page sections.
  * Revamp css for description parts (label-value display).

Updates
*******

* Allure (test reports) updated to version 2.8.1

.. _v1.1.15:

1.1.15 (2018-12-14)
###################

Bugfixes
********

* Fix :issue:`16` Webjars - too many open files

Updates
*******

* Font Awesome 5.5.0 -> 5.6.1
* Wicket Stuff Select2 8.1.0 -> 8.2.0
* Apache POI 4.0.0 -> 4.0.1
* Popper.js 1.14.4 -> 1.14.6
* Clipboard.js 2.0.1 -> 2.0.4

Enhancements
************

* BasicApp: consistent use of default locale french.
* BasicApp: refactor users admin pages.
* BasicApp: add tabs in user detail pages.

WicketTester
************

WicketTester mecanism has been improved by providing new utilitary methods and
somes modules were refactored in that way.

.. _v1.1.14:

1.1.14 (2018-12-03)
###################

Enhancements
************

* Bootstrap Modal changes:

  * Use custom js file ``modal-more.js`` to override modal behavior.
  * Move ``_enforceFocus`` method override in ``modal-more.js``.
  * Override ``show`` and ``hide`` methods to move modal to body on show
    and put it back to its parent on hide.
  * Override ``show`` and ``hide`` methods to force modal to close on
    transition.
  * Remove custom ``modal.js`` override, no longer needed.

* BasicApp: minor scss updates.

.. _v1.1.13:

1.1.13 (2018-11-23)
###################

Bugfixes
********

* Fix Apache POI dependency: add missing commons-math3.
* Remove from html useless confirm modal on hidden event.
* BasicApp: add missing visible condition on navbar submenu items.

.. _v1.1.12:

1.1.12 (2018-11-19)
###################

.. warning::
  Apache POI 4.0.0: dependency ``commons-math3`` is missing.
  Use Igloo 1.1.13 instead or add the dependency locally.

Bugfixes
********

* Add missing Bootstrap Util js dependency for Bootstrap Modal js.

Updates
*******

* Wicket 8.1.0 -> 8.2.0

  * https://wicket.apache.org/news/2018/11/17/wicket-8.2.0-released.html

* javax.mail:mail 1.4.7 updated to com.sun.mail:javax.mail 1.6.2

  * javax.mail:mail added as a forbidden dependency
  * igloo-component-spring dependency modified to com.sun.mail:javax.mail
  * if you declare your own javax.mail:mail dependency in you project, please
    update groupId/artifactId with com.sun.mail/javax.mail

* poi 3.17.0 updated to poi 4.0.0; there's some breaking change that are not
  involved in API used by Igloo

  * http://poi.apache.org/changes.html#4.0.0

* Font Awesome 5.3.1 -> 5.5.0

  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.0
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.1
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.4.2
  * https://github.com/FortAwesome/Font-Awesome/releases/tag/5.5.0

* Bindgen 4.0.0 -> 4.0.1

Enhancements
************

* BasicApp: fix reference data permission check on add action.
* BasicApp: add build date and commit sha in footer.

WicketTester
************

* The use of ``WicketTester`` has been added to the BasicApplication. For now it's
  more a showcase and does not present an entire test coverage.
* This development required to create a new Igloo module,
  ``igloo-component-wicket-more-test``, that was originally included in
  ``igloo-component-wicket-more``.
* Note that the version of ``igloo-component-jpa-test`` has been declared globally,
  so it should not be present in project pom anymore.

.. _v1.1.11:

1.1.11 (2018-11-06)
###################

.. warning::
  Wicket 8.1.0 websocket implementation is broken wicket Tomcat 8.5+
  (https://github.com/apache/wicket/commit/5fc86bdd8628686ffcd124849750f327dccc0c77#diff-94114697955d73acae40bf0a21c6b961)
  Please do not update if you use websocket.

Bugfixes
********

* Fix Select2 focus and dropdown results position in Bootstrap Modal.

.. _v1.1.10:

1.1.10 (2018-10-29)
###################

Dependencies
************

* Major updates:

  * hibernate 5.3.5 -> 5.3.17, hibernate-search 5.10.3 -> 5.10.4
  * spring 5.0.7 -> 5.0.10, spring-security 5.0.6 -> 5.0.9
  * wicket 8.0.0 -> 8.1.0

.. warning::
  Wicket 8.1.0 websocket implementation is broken wicket Tomcat 8.5+
  (https://github.com/apache/wicket/commit/5fc86bdd8628686ffcd124849750f327dccc0c77#diff-94114697955d73acae40bf0a21c6b961)
  Please do not update if you use websocket.

* Details:

  * https://github.com/igloo-project/igloo-parent/commit/5fbfce45d2ea92c340dff6107c24a2de0e28e19b
  * https://github.com/igloo-project/igloo-parent/commit/80563f1a097d46fae2c3dfc310966265ecbf46db
  * https://github.com/igloo-project/igloo-parent/commit/d4c3a13fc28ff46c0802f3443b17940c01cb235a
  * https://github.com/igloo-project/igloo-parent/commit/e4107081d829c3f36106674fa778ba771a69d94f
  * https://github.com/igloo-project/igloo-parent/commit/d082937880f43dd076fd7615f15a902aaa00140b

.. _v1.1.9:

1.1.9 (2018-10-29)
##################

Bugfixes
********

* Fix JQuery UI datepicker absolute top position.
* Fix condition on edit button for ``ReferenceData`` list pages.

Enhancements
************

* Move Wicket JavaScript and Select2 custom settings to
  ``CoreWicketApplication``.
* Add announcement feature into BasicApp.
* Update error pages (403, 404, 500, 503).

Breaking changes
****************

* ``DataTableBuilder``: rename method
  ``when(SerializablePredicate2<? super T> predicate)`` to
  ``whenPredicate(SerializablePredicate2<? super T> predicate)``.


.. _v1.1.8:

1.1.8 (2018-10-11)
##################

Bugfixes
********

* Fix conflict between Bootstrap 4 tooltip and JQuery UI widget tooltip.

Breaking changes
****************

* Override JQuery UI js ressource from WiQuery to remove widget tooltip.

.. _v1.1.7:

1.1.7 (2018-10-10)
##################

Bugfixes
********

* Fix inline enclosure component handler in BS modal.
* Fix limit 0 case in QueryDSL and HS search query (return empty list).

Breaking changes
****************

* Custom Wicket tag ``wicket:enclosure-container`` is now deprecated and will be
  removed soon. Use Igloo component ``EnclosureContainer`` instead.

Enhancements
************

* added tests on rollback behavior in ``igloo-component-jpa-test``

.. _v1.1.6:

1.1.6 (2018-10-01)
##################

Bugfixes
********

* Select2: attach component to the Bootstrap modal.

Breaking changes
****************

* Fix Bootstrap variables override.

.. _v1.1.5:

1.1.5 (2018-09-24)
##################

Bugfixes
********

* Select2: prevent dropdown toggle (open) on clear (single + multiple).
* Select2: dispose tooltip on element clear (multiple).

Updates
*******

* Font Awesome 5.3.1.

Enhancements
************

* Add build informations (date, commit sha, etc.).
* Consistency in use of Wicket ``Session.get()``.
* Remove useless icon on cancel buttons.
* BasicApp: fix custom BS checkbox position.
* BasicApp: improve alignment on page title and back to btn.
* BasicApp: minor change on style (nav and pagination background colors).
* BasicApp: remove useless link to user detail page.

.. _v1.1.4:

1.1.4 (2018-09-16)
##################

Bugfixes
********

* :issue:`18` - fix grouping/splitting behavior when sending a notification to
  multiple recipients.
* :issue:`17` - use an explicit setting ``notification.mail.sender.behavior``
  to control what is done when sender is not explictly set when a mail is sent.
  Get rid of an extraneous INFO message on PropertyServiceImpl when
  ``notification.mail.sender`` is empty.

Breaking changes
****************

If you use a not-empty value for ``notification.mail.sender``, you need to
add to your configuration
``notification.mail.sender.behavior=FALLBACK_TO_CONFIGURATION``.

.. _v1.1.3:

1.1.3 (2018-09-12)
##################

Bugfixes
********

* Fix off-request wicket generation (scheduler, async tasks). The issue broke
  all wicket-based API used outside of an HTTP request.
* Fix a problematic dependency declaration on igloo-dependency-hibernate-search
  that triggers (wrongly) SNAPSHOT detection by jgitflow plugin.

.. _v1.1.2:

1.1.2 (2018-09-06)
##################

Enhancements
************

This changes are backward-compatible.

* added JNDI's database support (:ref:`jndi`)
* added ``igloo.config`` and ``igloo.log4j`` configuration overrides
  (:ref:`config.bootstrap`)
* drop some useless WARN messages
* AuthenticationManager now uses Spring to search AuthenticationProvider
  (instead of a static configuration).

Bugfixes
********

* fix logger's configuration overriding (higher precedence for last files).

Misc
****

* update developers' information (pom.xml)

.. _v1.1.1:

1.1.1 (2018-09-03)
##################

Enhancements
************

* [4747e20056678ae7300272a6bf9dd39d38ba7b9a] added !default on some styles
* [713cc732fce44c5b26e3cf9e46abf5aebcacb9c3] update some data for Excel-based
  initialization
* [c28ed4fccd9a25481123da2db48d34d54c031a98] basic-application: use raw
  bootstrap grid styling instead of custom styles
* [df3bcdb1f215e7005efba0fefcde751064bddb0b] prepare bootstrap-override
  resources to ease fix and workaround integration in Igloo on external styling
  resources (bootstrap, ...).

Bugfixes
********

* [e3007084ca90495cc4e8b9d875938f6d52c8a25c] workaround for bootstrap col-auto max width
* [ad0896a0ab4b28705e9bef122050bf330f557f9b] fix scroll to top (styles)

.. _v1.1.0:

1.1.0 (2018-08-20)
##################

Major rewrite of Igloo ; see Migrating to 1.1 guide.
