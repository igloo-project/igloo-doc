# Releases 6.x

# 6.10.0 (TBD)

## Enhancement

* `LinkDescriptor`: add fifth and sixth parameters for mapper.
* BasicApp: password reset page -> rollback on behavior that removed
  token from URL.
* BasicApp: use jakarta `InternetAddress` to validate email address.
* Use `java.util.List` instead of guava `ImmutableList`.
* Change `EnumDropDownMultipleChoice` constructor visibility.
* `IModel` of `Collection` instead of `List` for some dropdown parameters.
* BasicApp: clean json properties on `User`.
* BasicApp: use `HistoryEventSummary` for `User` creation and modification.
* BasicApp: update environment name values.
* BasicApp: `Announcement` publication start date sort desc.

## Dependencies update

* Bootstrap: 5.3.2 -> 5.3.5
* Font Awesome: 6.5.1 -> 6.7.2

## Bugfix

* Fix buggy warning on `StorageService#(in)validateFichier` method
* HibernateSearchUtils · Escape operator characters

## Enhancement

* plugins-commons: spring-boot-maven-plugin added in dependencyManagement

# 6.9.0 (TBD)

# 6.8.0 (2025-05-26)

## Breaking changes

* Storage: new `FichierStatus.UNAVAILABLE` status:
  * not triggered by igloo code; only used by storage-tools archiving process
  * if you use a constrainted type for `Fichier.status` column, you need to
    alter your enum or constraint setup to add `UNAVAILABLE` as an expected
    value

## Bugfix

* igloo-difference : add hibernate proxy awareness behavior to fix difference detection

## Enhancement

* if you use `AbstractFichierStoreWebResource` to handle `Fichier` downloads, you may
  switch to `AbstractFichierFileStorageWebResource` parent class and replace
  `getFileStoreResourceStream` method with an equivalent `getFichier` method
  (https://github.com/igloo-project/igloo-parent/commit/954beb5fa713788bb36a4080ca9a68f069a0f9ad#diff-c486869ab009250216e44595fabc444ccb0f1e97b3f1eee4b9c803fabb9a6ce8)
* Storage + wicket: download managed by `AbstractFichierFileStorageWebResource` or
  `FichierFileStorageWebResource` does not longer log a stacktrace for file not
  found or `Fichier` status issue. Only logs a message without stack
* storage-tools: command-line tool to generate a fake storage folder from
  database or move (archive) `Fichier` to a separated `StorageUnit`

# 6.7.0 (2025-04-28)

## Enhancement

* BasicApp: switch to `inputmode` email.
* `DataTableBuilder`: add placeholder action.
* Add `dependencies-all` Maven module.
* Allow application to perform post-success wicket login validation (after
  authentication is successful, before security context is set). See
  `AbstractCoreSession#onSuccessfulAuthentication(...)`.

## Bugfix

* BasicApp: fix User lucene index field and search.
* `BindableModel`: initial value model can be nullable.

# 6.6.0 (2025-04-11)

## Enhancement

* Bootstrap Print

# 6.5.0 (2025-04-10)

## Breaking change

* replace RandomStringUtils.randomAlphanumeric() deprecated
* BCrype : Password must be smaller than 72 bytes (see CVE-2025-22228)

## Dependencies update

* jackson/-annotations/-core/-databind: 2.18.2 -> 2.18.3
* jackson-dataformat-xml: 2.18.2 -> 2.18.3
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.18.2 -> 2.18.3
* guava: 33.4.0jre -> 33.4.6jre
* ph-css: 7.0.3 -> 7.0.4
* opencsv: 5.9 -> 5.10
* HikariCP: 6.2.1 -> 6.3.0
* junit-jupiter-api: 5.11.4 -> 5.12.1
* junit-platform-suite-engine: 1.11.4 -> 1.12.1
* poi / poi-ooxml: 5.3.0 -> 5.4.0
* assertj-core / assertj-guava: 3.26.3 -> 3.27.3
* freemarker: 2.3.33 -> 2.3.34
* jersey-container-grizzly2-servlet: 3.1.9 -> 3.1.10
* jersey-client / jersey-server: 3.1.9 -> 3.1.10
* jersey-spring6: 3.1.9 -> 3.1.10
* jersey-media-multipart: 3.1.9 -> 3.1.10
* jersey-test-framework-provider-grizzly2: 3.1.9 -> 3.1.10
* hibernate/-core/-ehcache/-validator: 6.6.4.Final -> 6.6.12.Final
* hibernate-search-orm: 7.2.2.Final -> 7.2.3.Final
* jboss-logging-annotations: 3.0.3.Final -> 3.0.4.Final
* jsoup: 1.18.3 -> 1.19.1
* mockito/-core/-junit-jupiter: 5.14.2 -> 5.16.1
* passay: 1.6.5 -> 1.6.6
* postgresql: 42.7.4 -> 42.7.5
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.16 -> 2.0.17
* spring-\*: 6.2.1 -> 6.2.5
* spring-security-\*: 6.4.2 -> 6.4.4
* jakarta.activation: 2.0.1 -> 2.1.3
* micrometer-core: 1.14.2 -> 1.14.5
* error_prone_annotations: 2.36.0 -> 2.37.0
* spring-boot/spring-boot/-autoconfigure/-autoconfigure-processor: 3.4.1 -> 3.4.4
* byte-buddy: 1.15.11 -> 1.17.5
* commons-beanutils: 1.9.4 -> 1.10.1
* caffeine / jcache: 3.1.8 -> 3.2.0
* commons-codec: 1.17.1 -> 1.18.0
* checker-qual: 3.48.3 -> 3.49.2
* rhino: 1.7.15 -> 1.8.0
* logbook-core: 3.10.0 -> 3.11.0
* resilience4j-all: 2.2.0 -> 2.3.0
* httpclient5: 5.4.1 -> 5.4.3
* springdoc-openapi-starter-webmvc-ui: 2.7.0 -> 2.8.6
* sass-embedded-host: 3.7.3 -> 4.1.0
* testcontainers: 1.20.4 -> 1.20.6
* aspectjweaver: 1.9.22.1 -> 1.9.23
* awaitility: 4.2.2 -> 4.3.0
* maven-clean-plugin: 3.4.0 -> 3.4.1
* maven-compiler-plugin: 3.13.0 -> 3.14.0
* maven-failsafe-plugin: 3.5.2 -> 3.5.3
* maven-surefire-plugin: 3.5.2 -> 3.5.3
* maven-project-info-reports-plugin: 3.8.0 -> 3.9.0
* maven-deploy-plugin: 3.1.3 -> 3.1.4
* maven-install-plugin: 3.1.3 -> 3.1.4
* jacoco-maven-plugin: 0.8.12 -> 0.8.13
* dependency-check-maven: 11.1.1 -> 12.1.0
* flatten-maven-plugin: 1.6.0 -> 1.7.0
* spotless-maven-plugin: 2.43.1 -> 2.44.3
* spring-boot-maven-plugin: 3.4.1 -> 3.4.4

# 6.4.0 (2025-03-14)

## Breaking change

* `User`: refactor + remove generic user entity + update email type.

## Bugfix

* BasicApp: fix console data upgrades table.
* BasicApp: `Announcement` - multiple small fixes.
* Console - SignIn As: fix permission role admin.

## Enhancement

* BasicApp: html markup consistency.
* `HibernateUtils#unwrap` use native `Hibernate#unproxy` util method.
* `HibernateUtils#cast` use Java `Optional` instead of Guava.

# 6.3.0 (2025-02-13)

## Changes

* `ICollectionModel` / `CollectionCopyModel` : add update method for underlying collection with update models.
* History log : clean `IDifferenceService#getMinimalDifferenceGenerator` not used in new `AbstractConfiguredDifferenceServiceImpl` pattern.

# 6.2.0 (2025-01-22)

## Bugfix

* Rollback wicket version 10.3.0 to 10.2.0 -> wicket 10.3.0 with commit b3a7d62 break igloo forms with bindableModel + BindableModelForm and inner  ModelValidationForm

# 6.1.0 (2025-01-21)

## Changes

* add setter of jpaQuery to AbstractJpaSearchQuery
* make init jpaQuery AbstractJpaSearchQuery protected

## Bugfix

* fix cast of int to call Hibernate search fetchHits methode

# 6.0.1 (2025-01-08)

## Bugfix

* fix Hibernate search sort with AbstractHibernateSearchSearchQuery
* fix script release igloo

# 6.0.0 (2025-01-06)

## Changes

* remove igloo-dependency-rules not used anymore
* migration gitlab-ci to rules pattern
* migration to com.amashchenko.maven.plugin gitflow
* add new script release igloo
* User security: super user check only for role system.

## Dependencies update

* jackson/-annotations/-core/-databind: 2.18.0 -> 2.18.2
* jackson-dataformat-xml: 2.18.0 -> 2.18.2
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.18.0 -> 2.18.2
* guava: 33.3.1jre -> 33.4.0jre
* HikariCP: 6.0.0 -> 6.2.1
* commons-io: 2.17.0 -> 2.18.0
* junit-jupiter-api: 5.11.1 -> 5.11.4
* junit-platform-suite-engine: 1.11.1 -> 1.11.4
* log4j-core / log4j-slf4j-impl: 2.24.1 -> 2.24.3
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 10.2.0 -> 10.3.0
* wicketstuff-select2: 10.2.0 -> 10.3.0
* flyway-core: 10.18.2 -> 10.22.0
* jersey-container-grizzly2-servlet: 3.1.8 -> 3.1.9
* jersey-client / jersey-server: 3.1.8 -> 3.1.9
* jersey-spring6: 3.1.8 -> 3.1.9
* jersey-media-multipart: 3.1.8 -> 3.1.9
* jersey-test-framework-provider-grizzly2: 3.1.8 -> 3.1.9
* hibernate/-core/-ehcache/-validator: 6.6.1.Final -> 6.6.4.Final
* hibernate-search-orm: 7.2.1.Final -> 7.2.2.Final
* hibernate-commons-annotations: 7.0.1.Final -> 7.0.3.Final
* jboss-logging-annotations: 3.0.1.Final -> 3.0.3.Final
* jsoup: 1.18.1 -> 1.18.3
* mockito/-core/-junit-jupiter: 5.14.1 -> 5.14.2
* passay: 1.6.5 -> 1.6.6
* spring-\*: 6.1.13 -> 6.2.1
* spring-security-\*: 6.3.3 -> 6.4.2
* micrometer-core: 1.13.4 -> 1.14.2
* error_prone_annotations: 2.32.0 -> 2.36.0
* spring-boot/spring-boot/-autoconfigure/-autoconfigure-processor: 3.3.4 -> 3.4.1
* byte-buddy: 1.15.3 -> 1.15.11
* commons-text: 1.12.0 -> 1.13.0
* checker-qual: 3.47.0 -> 3.48.3
* logbook-core: 3.9.0 -> 3.10.0
* httpclient5: 5.4.0 -> 5.4.1
* springdoc-openapi-starter-webmvc-ui: 2.6.0 -> 2.7.0
* sass-embedded-host: 3.7.1 -> 3.7.3
* testcontainers: 1.20.2 -> 1.20.4
* maven-failsafe-plugin: 3.5.0 -> 3.5.2
* maven-surefire-plugin: 3.5.0 -> 3.5.2
* maven-dependency-plugin: 3.8.0 -> 3.8.1
* maven-javadoc-plugin: 3.10.0 -> 3.11.2
* maven-project-info-reports-plugin: 3.7.0 -> 3.8.0
* maven-toolchains-plugin: 3.2.0 -> 3.2.1
* dependency-check-maven: 10.0.4 -> 11.1.1
* versions-maven-plugin: 2.17.1 -> 2.18.0
* exec-maven-plugin: 3.4.1 -> 3.5.0
* spring-boot-maven-plugin: 3.3.4 -> 3.4.0

# 6.0.0-Alpha18 (2024-10-25)

## Bugfix

* Fix Parameter stringValue length.
* Fix AbstractTask - UnexpectedRollbackException : saving batch report if there is transaction end emits an exception
* User: fix detail pages mapper validation type + mapper utility user detail pages

## Enhancement

* {ref}`testcontainers` and {ref}`testcontainers-migration`
* Storage: reload detached Fichier for validate and invalidate actions.

# 6.0.0-Alpha17 (2024-10-07)

## Changes

* New permission pattern with Role entity
* Remove UserGroup and Authority entities
* Remove BasicUser and TechnicalUser in BasicApp
* Remove igloo permission hierarchy
* update Hibernate 6.6 https://docs.jboss.org/hibernate/orm/6.6/migration-guide/migration-guide.html
* remove `@MappedSuperClass` on `@Embeddable` class (hibernate 6.6)
* update spring-boot 3.3.4
* update major version sass-embedded-host (1.10.0 -> 3.7.1)

## Dependencies update

* jackson/-annotations/-core/-databind: 2.17.1 -> 2.18.0
* jackson-dataformat-xml: 2.17.1 -> 2.18.0
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.17.1 -> 2.18.0
* guava: 33.2.1jre -> 33.3.1.jre
* ph-css: 7.0.2 -> 7.0.3
* HikariCP: 5.1.0 -> 6.0.0
* commons-io: 2.16.1 -> 2.17.0
* junit-jupiter-api: 5.10.2 -> 5.11.1
* junit-platform-suite-engine: 1.10.2 -> 1.11.1
* log4j-core / log4j-slf4j-impl: 2.23.1 -> 2.24.0
* lucene/-analyzers-common/-core/-queries/-queryparser: 9.9.2 -> 9.11.1
* poi / poi-ooxml: 5.2.5 -> 5.3.0
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 10.1.0 -> 10.2.0
* wicketstuff-select2: 10.1.0 -> 10.2.0
* assertj-core / assertj-guava: 3.25.3 -> 3.26.3
* flyway-core: 10.15.0 -> 10.18.2
* jersey-container-grizzly2-servlet: 3.1.7 -> 3.1.8
* jersey-client / jersey-server: 3.1.7 -> 3.1.8
* jersey-spring6: 3.1.7 -> 3.1.8
* jersey-media-multipart: 3.1.7 -> 3.1.8
* jersey-test-framework-provider-grizzly2: 3.1.7 -> 3.1.8
* hibernate/-core/-ehcache/-validator: 6.5.2.Final -> 6.6.1.Final
* hibernate-search-orm: 7.1.1.Final -> 7.2.1.Final
* hibernate-commons-annotations: 6.0.6.Final -> 7.0.1.Final
* jboss-logging: 3.6.0.Final -> 3.6.1.Final
* jboss-logging-annotations: 2.2.1.Final -> 3.0.1.Final
* jsoup: 1.17.2 -> 1.18.1
* mockito/-core/-junit-jupiter: 5.12.0 -> 5.14.1
* passay: 1.6.4 -> 1.6.5
* postgresql: 42.7.3 -> 42.7.4
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.13 -> 2.0.16
* spring-\*: 6.1.10 -> 6.1.13
* spring-security-\*: 6.3.1 -> 6.3.3
* micrometer-core: 1.13.1 -> 1.13.4
* jakarta.ws.rs-api: 3.1.0 -> 4.0.0
* error_prone_annotations: 2.28.0 -> 2.32.0
* spring-boot/spring-boot/-autoconfigure/-autoconfigure-processor: 3.3.1 -> 3.3.4
* byte-buddy: 1.14.17 -> 1.15.3
* commons-compress: 1.26.2 -> 1.27.1
* commons-codec: 1.17.0 -> 1.17.1
* commons-lang3: 3.14.0 -> 3.17.0
* checker-qual: 3.45.0 -> 3.47.0
* hamcrest: 2.2 -> 3.0
* throwing-function: 1.5.1 -> 1.6.1
* httpclient5: 5.3.1 -> 5.4.0
* springdoc-openapi-starter-webmvc-ui: 2.5.0 -> 2.6.0
* sass-embedded-host: 1.10.0 -> 3.7.1
* protobuf-java: 3.21.11 -> 4.28.2
* maven-failsafe-plugin: 3.3.0 -> 3.5.0
* maven-surefire-plugin: 3.3.0 -> 3.5.0
* maven-dependency-plugin: 3.7.1 -> 3.8.0
* maven-javadoc-plugin: 3.7.0 -> 3.10.0
* maven-project-info-reports-plugin: 3.6.1 -> 3.7.0
* maven-site-plugin: 4.0.0-M15 -> 4.0.0-M16
* maven-deploy-plugin: 3.1.2 -> 3.1.3
* maven-assembly-plugin: 3.7.1 -> 3.8.0
* maven-install-plugin: 3.1.2 -> 3.1.3
* dependency-check-maven: 10.0.1 -> 10.0.4
* versions-maven-plugin: 2.16.2 -> 2.17.1
* exec-maven-plugin: 3.3.0 -> 3.4.1
* buildnumber-maven-plugin: 3.2.0 -> 3.2.1
* frontend-maven-plugin: 1.15.0 -> 1.15.1
* spotless-maven-plugin: 2.43.0 -> 2.43.1
* spring-boot-maven-plugin: 3.3.1 -> 3.3.4
* sass-embedded-host: 1.10.0 -> 3.7.1
* protobuf-java: 3.21.11 -> 4.28.2

# 6.0.0-Alpha16 (2024-09-27)

## Features

* Added {ref}`spring-boot-actuator`

## Changes

* Locale, Timezone and Charset are checked and enforced during application startup.
  (Set by default to fr_FR, Europe/Paris, UTF-8, can be configured with
  `igloo.checks.locale`, `igloo.checks.timezone`, `igloo.checks.charset`).
* `HistoryLog`: JPA search query.

# 6.0.0-Alpha13 (2024-07-24)

## Dependencies update

* jackson/-annotations/-core/-databind: 2.17.0 -> 2.17.1
* jackson-dataformat-xml: 2.17.0 -> 2.17.1
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.17.0 -> 2.17.1
* jackson-module-jaxb-annotations: 2.17.0 -> 2.17.1
* guava: 33.1.0jre -> 33.2.1jre
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 10.0.0 -> 10.1.0
* wicketstuff-select2: 10.0.0 -> 10.1.0
* flyway-core: 9.22.3 -> 10.15.0
* freemarker: 2.3.32 -> 2.3.32
* jersey-container-grizzly2-servlet: 3.1.6 -> 3.1.7
* jersey-client / jersey-server: 3.1.6 -> 3.1.7
* jersey-spring6: 3.1.6 -> 3.1.7
* jersey-media-multipart: 3.1.6 -> 3.1.7
* jersey-test-framework-provider-grizzly2: 3.1.6 -> 3.1.7
* jboss-logging: 3.5.3.Final -> 3.6.0.Final
* mockito/-core/-junit-jupiter: 5.11.0 -> 5.12.0
* spring-\*: 6.1.6 -> 6.1.10
* spring-security-\*: 6.2.4 -> 6.3.1
* webjars-locator-core: 0.58 -> 0.59
* micrometer-core: 1.12.5 -> 1.13.1
* error_prone_annotations: 2.27.0 -> 2.28.0
* byte-buddy: 1.14.14 -> 1.14.17
* picocli: 4.7.5 -> 4.7.6
* commons-compress: 1.26.1 -> 1.26.2
* commons-validator: 1.8.0 -> 1.9.0
* jjwt: 0.12.5 -> 0.12.6
* checker-qual: 3.42.0 -> 3.44.0
* rhino: 1.7.14 -> 1.7.15
* logbook-core: 3.8.0 -> 3.9.0
* maven-clean-plugin: 3.3.2 -> 3.4.0
* maven-failsafe-plugin: 3.2.5 -> 3.3.0
* maven-surefire-plugin: 3.2.5 -> 3.3.0
* maven-dependency-plugin: 3.6.1 -> 3.7.1
* maven-javadoc-plugin: 3.6.3 -> 3.7.0
* maven-project-info-reports-plugin: 3.5.0 -> 3.6.1
* maven-site-plugin: 4.0.0-M13 -> 4.0.0-M15
* maven-jar-plugin: 3.4.1 -> 3.4.2
* dependency-check-maven: 9.1.0 -> 9.2.0
* maven-enforcer-plugin: 3.4.1 -> 3.5.0
* exec-maven-plugin: 3.2.0 -> 3.3.0
* spring-boot-maven-plugin: 3.2.5 -> 3.3.1
* opencsv: 4.3.2 -> 5.9

## Changes

* update flyway dependency to 10.15.0
* add flyway-database-postgresql dependency
* update opencsv to v5.9
* remove wqplot dependency declaration
* remove openpdf dependency declaration
* remove h2 from igloo-maven (keep only in igloo-parent - jpa tests)
* `IHhibernateSearchDao / IHibernateSearchService - getAnalyzer(*)` are removed
* `HibernateSearchLuceneQueryFactoryImpl` / `OldAbstractHibernateSearchSearchQuery` / `OldGenericReferenceDataSearchQueryImpl` moved to igloo-hibernate-search-v5migrationhelper
* igloo project format changes

# 6.0.0-Alpha12 (2024-07-08)

## Bugfix

* task configuration : fix manager init to populate QueueIds

## Dependencies update

* hibernate 6.2.9 -> 6.5.0
* hibernate-search 6.2.1 -> 7.1.1 (artifact hibernate-search-v5migrationhelper-orm-orm6 renamed to hibernate-search-v5migrationhelper-orm)
* lucene 8.11.2 -> 9.9.2 (artifact lucene-analyzers-common renamed to lucene-analysis-common)
* guava 32.1.3 -> 33.1.0
* commons-io 2.15.1 -> 2.16.1
* commons-text 1.11.0 -> 1.12.0
* commons-exec 1.3 -> 1.4
* commons-compress 1.25.0 -> 1.26.1
* commons-codec 1.16.0 -> 1.17.0
* commons-fileupload : 2.0.0-M2 (artifact from commons-fileupload2-jakarta to commons-fileupload2-jakarta-servlet5)
* angus-mail 2.0.2 -> 2.0.3
* jackson 2.16.0 -> 2.17.0
* resilience4j 2.1.0 -> 2.2.0
* byte-buddy 1.14.10 -> 1.14.14
* querydsl 5.0.0 -> 5.1.0
* postgresql 42.7.1 -> 42.7.3
* spring 6.1.1 -> 6.1.6
* spring-boot 3.2.2 -> 3.2.5
* spring-security 6.2.0 -> 6.2.4
* wicket 10.0.0-M2 -> 10.0.0
* wicketstuff-select2 9.0.0 -> 10.0.0
* webjars-locator-core 0.55 -> 0.58
* slf4j 2.0.9 -> 2.0.13
* log4j 2.22.0 -> 2.23.1
* jersey 3.1.4 -> 3.1.6
* junit 5.10.1 -> 5.10.2
* junit suite 1.10.1 -> 1.10.2
* mockito 5.8.0 -> 5.11.0
* assertj 3.24.2 -> 3.25.3
* assertj guava 3.24.2 -> 3.25.3
* grizzly 4.0.1 -> 4.0.2
* errorprone 2.23.0 -> 2.27.0
* ph-css 7.0.1 -> 7.0.2
* jsoup 1.17.1 -> 1.17.2
* micrometer 1.12.1 -> 1.12.5
* openpdf 1.3.34 -> 2.0.2
* jakarta xml-bind-api : 4.0.0 -> 4.0.2
* various maven plugin updates

## Changes

* Explicit ordering for transactional proxies :
  * Spring proxy is `LOWEST_PRECEDENCE - 1.000.000`
  * Historical ITransactionalAspectAwareService is `LOWEST_PRECEDENCE - 1.000.000 + 1`
  * This ordering allows to install proxies after transactional proxies
  * This change has no impact if you don't configure proxies
  * See `JpaAutoConfiguration.TRANSACTION_PROXY_ORDER`, `JpaAutoConfiguration`, `JpaAutoConfiguration.oldStyleTransactionAdvisor`
* added org.iglooproject:spring-boot-starter-parent (to use in place of
  org.springframework.boot:spring-boot-starter-parent)
* add in `project-app/pom.xml` a property definition for `start-class` to
  allow executable jar / war (`<start-class>package.MainClass</start-class>`)
* remove from `project-app/pom.xml` any version override provided by
  `igloo-maven`
* you may need to drop / rebuild hibernate-search indexes as Lucene 9.x
  index format is mandatory for a default deployment. Existing indexes
  must be deleted as they prevents application startup
* fileupload artifact is renamed: commons-fileupload2-jakarta to commons-fileupload2-jakarta-servlet5
* hibernate-search artifact is renamed: hibernate-search-v5migrationhelper-orm-orm6 to hibernate-search-v5migrationhelper-orm
* maven-enforcer-plugin is now enabled with requireUpperBoundDeps
* storage : method getFichierById return null instead of an Exception if not Fichier is found

## Deleted code

* `RawLuceneQuery` is removed; `LuceneUtils` related methods are removed

# New with Igloo 6.x

Igloo 6.x performs the following mandatory upgrade:

* Spring configuration is handled by Spring Boot everywhere it is possible
* Spring 6.x
* Spring Security 6.x
* Hibernate 6.x
* Hibernate Search 7.x
* Tomcat 10.x (Servlet 5)
* Java time migration (JSR-310)
* Removed Igloo-related Hibernate search + elasticsearch code
* javax to jakarta namespace migration
