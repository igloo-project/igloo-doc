# Releases

(v4.1.0)=

# 4.1.0 (XXXX-XX-XX)

## Updates

* Font Awesome 5.15.4 -> 6.0.0

## Bugfixes

* Fix locale for localize with positional parameters in `RendererServiceImpl`.

## Enhancements

* BasicApp: remove home link in 503 error page.
* BasicApp: use external link and LDM for app links in emails.
* BasicApp: move breadcrumb html into page templates.
* BasicApp: announcement content multilines.
* BasicApp: enhancements on sign in checks and feedback messages.

(v4.0.0)=

## 4.0.0 (YYYY-MM-DD)

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

## Breaking changes

* Spring security : Java config replace `security-web-context.xml`.  To migrate your project check `reference commit for BasicApp <https://gitlab.tools.kobalt.fr/igloo-project/igloo-parent/-/commit/b6ace4c0e6506e37d500d98aa027bf456fea18ce>`_. `security-web-context.xml` is still valid, but it is strongly adviced to plan this change to ease future updates.

* `maven-processor-plugin` configuration: set `igloo.processors` property

* *igloo-dependencies-\** and *igloo-packages-\**: these groupIds no longer exist, this dependencies must be removed and replaced by explicit dependencies TODO

* Selectively add `dependencies-*` in `dependencyManagement` seection so that `mvn compile` does not complain about missing dependencies versions.

* Drop `maven-wagon-plugin` (or reconfigure it locally if you want to keep this plugin for delivery)

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

## Older releases

```{toctree}
releases
```