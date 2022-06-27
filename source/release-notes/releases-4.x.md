# Releases

(v4.2.0)=

# 4.2.0 (2022-06-27)

## Bugfixes

* Exclude Junit 4 from `igloo-component-wicket-bootstrap4` : Make sure that your tests still run
* {issue}`64`: fix SpringBackedMonitoringResource resource name (no impact, code cleaning)
* {issue}`65`: reload4j - Log4j1 Compatibility (when reload4j, log4j 1.x fork, is used)
* {issue}`66`: StorageConsistencyCheck#checkType not set (storage check performance improvement)

## Breaking changes

### Hibernate : Changes to the DDL type for CLOB

Check that you have no entity field annotated `@Lob` or typed `java.sql.Clob`.

`StringClobType` is dropped as it uses Clob:

* Search and replace all StringClobType occurences: for `@Type(type = "org.iglooproject.jpa.hibernate.usertype.StringClobType")`,
  replace by `@Type(type = "text")`.
* With SQL Update script in create-mode, generate a SQL creation file before and after migration and check there is no unexpected change.
* Check that SQL Update script in update-mode, check that proposed updates are expected.
* Igloo entities (QueuedTaskHolder, ...) are fixed in Igloo.

https://github.com/hibernate/hibernate-orm/blob/5.6/migration-guide.adoc#changes-to-the-ddl-type-for-clob-in-postgresql81dialect-and-its-subclasses

## Dependencies

* wicket 9.7.0 -> 9.10.0
* wicketstuff select2 9.7.0 -> 9.10.0
* hibernate 5.4.33.Final -> 5.6.9.Final
* spring 5.3.16 -> 5.3.20
* spring security 2.6.4 -> 2.6.7
* jackson 2.13.1 -> 2.13.2

* reload4j 1.2.19 -> 1.2.20
* guava 31.0.1-jre -> 31.1-jre
* h2 2.1.210 -> 2.1.212
* log4j2 2.17.1 -> 2.17.2
* poi 5.2.0 -> 5.2.2
* flyway 8.5.1 -> 8.5.10
* jboss logging 3.4.1.Final -> 3.5.0.Final
* jsoup 1.14.3 -> 1.15.1
* mockito 4.3.1 -> 4.5.1
* postgresql 42.3.3 -> 42.3.5
* immutables value 2.8.2 -> 2.9.0
* webjars npm clipboard 2.0.8 -> 2.0.11
* micrometer 1.8.4 -> 1.9.0
* ehcache 3.9.6 -> 3.10.0
* errorprone 2.11.0 -> 2.14.0

Maven plugins:

* maven-antrun-plugin 3.0.0 -> 3.1.0
* maven-clean-plugin 3.1.0 -> 3.2.0
* maven-compiler-plugin 3.10.0 -> 3.10.1
* maven-failsafe-plugin 3.0.0-M5 -> 3.0.0-M6
* maven-surefire-plugin 3.0.0-M5 -> 3.0.0-M6
* maven-javadoc-plugin 3.3.2 -> 3.4.0
* maven-project-info-reports-plugin  3.2.1 -> 3.3.0
* maven-site-plugin 3.9.1 -> 4.0.0-M1
* maven-processor-plugin 5.0-rc3 -> 5.0-rc3
* jacoco-maven-plugin 0.8.7 -> 0.8.8
* dependency-check-maven 5.3.2 -> 7.1.0
* versions-maven-plugin 2.9.0 -> 2.11.0

(v4.1.0)=

# 4.1.0 (2022-05-27)

## Updates

* Wicket 9.7.0 -> 9.10.0
* Font Awesome 5.15.4 -> 6.0.0

## Bugfixes

* Fix locale for localize with positional parameters in `RendererServiceImpl`.
* `processor.test.skip` is restored; when set to true on processing-enabled module, it allows to skip test source processing.

## Enhancements

* BasicApp: remove home link in 503 error page.
* BasicApp: use external link and LDM for app links in emails.
* BasicApp: move breadcrumb html into page templates.
* BasicApp: announcement content multilines.
* BasicApp: enhancements on sign in checks and feedback messages.

## Breaking changes

* Tests migrated to junit 5:

  * If you want to keep your project's tests Junit 4 - based:

    * Replace occurences of `org.iglooproject.test.jpa.junit.AbstractTestCase` by `org.iglooproject.test.jpa.junit.AbstractJunit4TestCase`.
    * If you use `AbstractWicketTestCase`, copy it from {igloo-parent}`v4.0.0/igloo/igloo-components/igloo-component-wicket-test/src/main/java/org/iglooproject/test/wicket/core/AbstractWicketTestCase.java` to create it in your project and changes its parent to `AbstractJunit4TestCase`.
    * You may exclude `org.junit.jupiter:junit-jupiter-api` from your dependencies to keep your test classpath clean.

  * If you want to migrate to Junit 5

    * Check that `junit:junit` artifact is excluded from your project and fix errors.
    * Common changes are annotation rewrites : `@Before/@BeforeEach`, `@After/@AfterEach`, `@Rule` must be reworked to use `@ExtendWith`.
    * `basic-application` git history can be checked to find migration examples

  * In both situations, ensure to check test number is not changed before and after run (check by-module final test result).

(v4.0.0)=

# 4.0.0 (2022-05-16)

4.0.0 brings module and repository refactoring. The purpose is to split Igloo codebase in smaller module and to reduce interdependencies.

Big picture changes are the following :

* Maven plugin and dependency managements are moved to [igloo-maven](https://github.com/igloo-project/igloo-maven/)
* Low level and/or common utilities are moved to [igloo-commons](https://github.com/igloo-project/igloo-commons/)
* *igloo-dependencies-\** and *igloo-packages-\** modules are removed; this dependency sets were hard to maintain
* *dependencies-\** from [igloo-maven](https://github.com/igloo-project/igloo-maven/) replaces the later, but it is a *dependencyManagement* modules
* Utilities modules are added:

  * *igloo-hibernate*: Hibernate utilities
  * *igloo-jpa-model*: Parent class for entities, custom types to handle interface backed by enum
  * *jpa-test*: Junit 5 extension for JPA initialization
  * *igloo-monitoring-page*: Wicket utilities to expose adhoc or micrometer data as a web page and enable perfdata-like monitoring
  * *storage-{model,api,impl,micrometer,integration}*: Filesystem-backed storage system
  * *maven-processor-plugin* configuration is modified

## Features

Storage engine is added to replace Filestore utilities. Storage is a more integrated solution, that provides a built-in relational and transactional model, wicket integration and jobs management (cleaning, consistency checks).

Filestore implementation is still available.

A migration guide to move Filestore to Storage engine will be provided.

## Breaking changes

* Add `<masterBranchName>master</masterBranchName>` in your root `pom.xml` if your release branch is called `master` (new default is `main`).

* `maven-processor-plugin` configuration: see {ref}`igloo4-maven-processor-plugin`

* *igloo-dependencies-\** and *igloo-packages-\** removal and other dependency management changes: dependencies now use `dependencyManagement` mechanism and rely on more explicit configuration. See and follow {ref}`igloo4-dependencies-migration-guide`.

* Drop `wagon-maven-plugin` (or reconfigure it locally if you want to keep this plugin for delivery)

* Replace `LocaleUtils.initCollator(locale)` occurences by `new SerializableCollator(locale).nullsFirst()`

* Spring security : Java config replace `security-web-context.xml`. To migrate your project check `reference commit for BasicApp <https://gitlab.tools.kobalt.fr/igloo-project/igloo-parent/-/commit/b6ace4c0e6506e37d500d98aa027bf456fea18ce>`_ and `commit <https://github.com/igloo-project/igloo-parent/commit/d6a564fd7eb59005ec8b3349bf627704dab88bc6>`_. `security-web-context.xml` is still valid, but it is strongly adviced to plan this change to ease future updates.

* SqlUpdateScript updates:

  * add `info.picocli:picocli` dependency with `<optional>true</optional>`.
  * copy and rename {igloo-parent}`basic-application/basic-application-core/src/main/java/org/iglooproject/basicapp/core/cli/BasicApplicationSqlUpdateScriptMain.java` and {igloo-parent}`basic-application/basic-application-core/src/main/java/org/iglooproject/basicapp/core/cli/AbstractBasicApplicationMain.java` into your project. Replace `BasicApplicationCoreHeadlessConfig` by your own spring configuration (check existing file).
  * check that « Run as » can be launched.
  * check {ref}`sql-update-script` for usage.

The above instructions may be sufficient to migrate a project. If you encounter missing classes or definition, here is a summay of other breaking changes to help to identify new modules or codes to import:

* Use `${igloo-commons.version}` property to define version for the following *artifactId*:

  * bindgen-functional
  * igloo-batch-api
  * igloo-bean-api
  * igloo-collections
  * igloo-component-commons-io
  * igloo-component-functional
  * igloo-component-truevfs
  * igloo-context
  * igloo-lang
  * igloo-security-api
  * igloo-validator

* Moved resources:

  * `PredefinedIdSequenceGenerator` (igloo-component-jpa): package change, check and replace old package name `org.iglooproject.jpa.hibernate.dialect.PredefinedIdSequenceGenerator` by new `org.iglooproject.jpa.hibernate.dialect.PredefinedIdSequenceGenerator`
  * test resources `EntityManagerFactoryHelper` and `PersistenceUnitDescriptorAdapter` are now exposed by `igloo-hibernate` module
  * extension `EntityManagerFactoryExtension`
  * `PostgreSQLIntervalFunction`, `PostgreSQLRegexpOperatorFunction`, `MetadataRegistryIntegrator` are moved (package/module) from igloo-component-jpa to `igloo-hibernate`
  * `org.iglooproject.jpa.hibernate.model.naming` package is kept but moved to `igloo-hibernate`

* *igloo-component-commons* is removed and split to igloo-batch-api, igloo-bean-api, igloo-collections, igloo-context, igloo-lang, igloo-security-api and igloo-validator (igloo-commons repository).

* Dependencies' versions for `hibernate-validator`, `aspectj` and `byte-buddy` are removed as we do not use it directly and there is no transitive dependency conflicts for this dependencies. If this dependencies are listed in you project, you can remove them; they are either useless or already added by transitivity.

# Older releases

```{toctree}
releases
```
