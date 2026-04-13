# Releases 7.x

# 7.1.0 (TBD)

## Enhancement

* BasicApp: refactor Spring configuration
* BasicApp: flyway modes
* BasicApp: add full history diff on User
* BasicApp: user has password service method
* BasicApp: Export Excel - update workbook style
* BasicApp: announcement markdown
* BasicApp: remove wicket tester unit tests
* BasicApp: Java 25
* Console: revamp HS indexing page
* HistoryLog: add event type merge group

## Bugfix

* BasicApp / Spring Boot: add missing spring boot webmvc dependency

## Dependencies
* jackson/-core/-databind / ...: 2.21.0 -> 2.21.2
* h2: 2.3.232 -> 2.4.240
* junit-jupiter-api: 6.0.2 -> 6.0.3
* junit-platform-suite-engine: 6.0.2 -> 6.0.3
* log4j-core / log4j-slf4j-impl: 2.25.3 -> 2.15.4
* assertj-core / assertj-guava: 3.27.6 -> 3.27.7
* flyway-core: 11.20.2 -> 11.20.3
* hibernate/-core/-ehcache/-validator: 7.2.4.Final -> 7.3.0.Final
* hibernate-search-orm: 8.2.1.Final -> 8.3.0.Final
* jboss-logging: 3.6.1.Final -> 3.6.3.Final
* jsoup: 1.21.2 -> 1.22.1
* mockito/-core/-junit-jupiter: 5.21.0 -> 5.23.0
* passay: 1.6.6 -> 2.0.0
* postgresql: 42.7.9 -> 42.7.10
* wiquery-core: 10.0.0 -> 10.1.0
* error_prone_annotations: 2.46.0 -> 2.49.0
* spring-boot/spring-boot/-autoconfigure/-autoconfigure-processor: 4.0.3 -> 4.0.5
* byte-buddy: 1.18.4 -> 1.18.8
* commons-fileupload: 2.0.0-M4 -> 2.0.0-M5
* commons-fileupload2-jakarta-servlet5: 2.0.0-M4 -> 2.0.0-M5
* commons-codec: 1.20.0 -> 1.21.0
* rhino: 1.9.0 -> 1.9.1
* logbook-core: 4.0.3 -> 4.0.5
* resilience4j-all: 2.3.0 -> 2.4.0
* springdoc-openapi-starter-webmvc-ui: 3.0.1 -> 3.0.2
* testcontainers: 2.0.3 -> 2.0.4
* nimbus-jose-jwt: 10.7 -> 10.9
* jakarta.xml.bind-api: 4.0.4 -> 4.0.5
* pdfcompare: 1.2.7 -> 1.2.8
* vue: 3.5.27 -> 3.5.32
* maven-compiler-plugin: 3.14.1 -> 3.15.0
* maven-failsafe-plugin: 3.5.4 -> 3.5.5
* maven-surefire-plugin: 3.5.4 -> 3.5.5
* maven-dependency-plugin: 3.9.0 -> 3.10.0
* maven-resources-plugin: 3.4.0 -> 3.5.0
* maven-processor-plugin: 5.1 -> 5.2
* dependency-check-maven: 12.1.9 -> 12.2.0
* versions-maven-plugin: 2.20.1 -> 2.21.0
* buildnumber-maven-plugin: 3.2.0 -> 3.3.0
* spotless-maven-plugin: 3.1.0 -> 3.4.0
* spring-boot-maven-plugin: 4.0.3 -> 4.0.5
* jaxb2-maven-plugin: 4.0.0 -> 4.1.0

# 7.0.0 (2026-03-09)

## Breaking changes

* Spring 7 / hibernate 7
* Use spring env in properties files
* TestContainer & Docker : Update postgres 15 / 17 -> 18

## New with Igloo 7.x

* Spring boot 4.x
* Spring 7.x
* Spring Security 7.x
* Hibernate 7.x
* Hibernate Search 8.x
* Tomcat 11.x (Servlet 6.1)
* JUnit 6
