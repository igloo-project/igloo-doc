# Releases 6.x

# Igloo 6.0.0-Alpha13 (TBD)

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
* remove wqplot
* remove openpdf
* remove h2 from igloo-maven (keep only in igloo-pranet - jpa tests)

# Igloo 6.0.0-Alpha12 (TBD)

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
