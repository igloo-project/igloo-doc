# Releases 5.x

(v5.29.0)=

# 5.29.0 (TBD)

(v5.28.0)=

# 5.28.0 (2025-09-30)

## Change

* Log4J : add vhost and userID logs

## Dependencies

* jackson/-annotations/-core/-databind: 2.19.1 -> 2.20.0
* jackson-dataformat-xml: 2.19.1 -> 2.20.0
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.19.1 -> 2.20.0
* jackson-module-jaxb-annotations: 2.19.1 -> 2.20.0
* guava: 33.4.8jre -> 33.5.0jre
* h2: 2.3.232 -> 2.4.240
* ph-css: 7.0.4 -> 7.1.0
* opencsv: 5.11.2 -> 5.12.0
* HikariCP: 6.3.0 -> 7.0.2
* commons-io: 2.19.0 -> 2.20.0
* junit-jupiter-api: 5.13.2 -> 5.13.4
* junit-platform-suite-engine: 1.13.2 -> 1.13.4
* log4j-core / log4j-slf4j-impl / log4j-api: 2.25.0 -> 2.25.2
* assertj-core / assertj-guava: 3.27.3 -> 3.27.6
* jsoup: 1.21.1 -> 1.21.2
* mockito/-core/-junit-jupiter: 5.18.0 -> 5.20.0
* postgresql: 42.7.7 -> 42.7.8
* value: 2.10.1 -> 2.11.4
* micrometer-core: 1.15.1 -> 1.15.4
* error_prone_annotations: 2.39.0 -> 2.42.0
* byte-buddy: 1.17.6 -> 1.17.7
* commons-compress: 1.27.1 -> 1.28.0
* commons-text: 1.13.1 -> 1.14.0
* commons-lang3: 3.17.0 -> 3.19.0
* commons-validator: 1.9.0 -> 1.10.0
* caffeine / jcache: 3.2.1 -> 3.2.2
* commons-codec: 1.18.0 -> 1.19.0
* sass-embedded-host: 4.2.0 -> 4.3.1
* nimbus-jose-jwt: 10.3 -> 10.5
* jjwt: 0.12.6 -> 0.13.0
* checker-qual: 3.49.5 -> 3.51.0
* maven-compiler-plugin: 3.14.0 -> 3.14.1
* maven-failsafe-plugin: 3.5.3 -> 3.5.4
* maven-surefire-plugin: 3.5.3 -> 3.5.4
* maven-javadoc-plugin: 3.11.2 -> 3.12.0
* spotless-maven-plugin: 2.44.5 -> 2.46.1
* dependency-check-maven: 12.1.3 -> 12.1.6
* maven-enforcer-plugin: 3.5.0 -> 3.6.1
* versions-maven-plugin: 2.18.0 -> 2.19.1
* flatten-maven-plugin: 1.7.1 -> 1.7.3
* frontend-maven-plugin: 1.15.1 -> 1.15.4

(v5.27.0)=

# 5.27.0 (2025-06-27)

## Change

* Change `EnumDropDownMultipleChoice` constructor visibility.
* `IModel` of `Collection` instead of `List` for some dropdown parameters.
* `LinkDescriptor`: add fifth and sixth parameters for mapper.

## Dependencies

* jackson/-annotations/-core/-databind: 2.18.3 -> 2.19.1
* jackson-dataformat-xml: 2.18.3 -> 2.19.1
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.18.3 -> 2.19.1
* jackson-module-jaxb-annotations: 2.18.3 -> 2.19.1
* guava: 33.4.6jre -> 33.4.8jre
* opencsv: 5.10 -> 5.11.2
* commons-io: 2.18.0 -> 2.19.0
* wicket-webjars: 3.0.7 -> 3.0.8
* junit-jupiter-api: 5.12.1 -> 5.13.2
* junit-platform-suite-engine: 1.11.4 -> 1.13.2
* log4j-core / log4j-slf4j-impl / log4j-api: 2.24.3 -> 2.25.0
* poi / poi-ooxml: 5.4.0 -> 5.4.1
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 9.20.0 -> 9.21.0
* wicketstuff-select2: 9.20.0 -> 9.21.0
* jersey-container-grizzly2-servlet: 2.46 -> 2.47
* jersey-client / jersey-server: 2.46 -> 2.47
* jersey-spring5: 2.46 -> 2.47
* jersey-media-multipart: 2.46 -> 2.47
* jersey-test-framework-prov0der-grizzly2: 2.46 -> 2.47
* jsoup: 1.19.1 -> 1.21.1
* mockito/-core/-junit-jupiter: 5.16.1 -> 5.18.0
* postgresql: 42.7.5 -> 42.7.7
* micrometer-core: 1.14.5 -> 1.15.1
* error_prone_annotations: 2.37.0 -> 2.39.0
* byte-buddy: 1.17.5 -> 1.17.6
* picocli: 4.7.6 -> 4.7.7
* commons-collections4: 4.4 -> 4.5.0
* commons-text: 1.13.0 -> 1.13.1
* commons-exec: 1.4.0 -> 1.5.0
* commons-fileupload: 1.5 -> 1.6.0
* sass-embedded-host: 4.1.0 -> 4.2.0
* commons-beanutils: 1.10.1 -> 1.11.0
* maven-clean-plugin: 3.4.1 -> 3.5.0
* spotless-maven-plugin: 2.44.3 -> 2.44.5
* jacoco-maven-plugin: 0.8.12 -> 0.8.13
* dependency-check-maven: 12.1.0 -> 12.1.3
* exec-maven-plugin: 3.5.0 -> 3.5.1
* flatten-maven-plugin: 1.7.0 -> 1.7.1
* buildnumber-maven-plugin: 3.2.0 -> 3.2.1

(v5.26.0)=

# 5.26.0 (2025-05-13)

## Change

* HistoryLog migration to JPA search Query
* DataTableBuilder : `addPlaceholder` added for actions items

## Bugfix

* BindableModel : initial value model can be nullable
* Fix buggy warning on `StorageService#(in)validateFichier` method

(v5.25.0)=

# 5.25.0 (2025-04-02)

## Bugfix

* BasicApp: fix console data upgrades table.
## Change

* fix CVE-2025-22228 spring security -> password size must be smaller than 72 bytes
* migration igloo 6 - add new jpa search pattern with DTO
* migration igloo 6 - javaTime 
* remove old Abstract AbstractTaskManagementConfig, use IglooTaskManagementAutoConfiguration instead
* HibernateUtils#unwrap use native Hibernate#unproxy function with cast
* Switch HibernateUtils import com.google.common.base.Optional to java.util.Optional

## Dependencies

* jackson/-annotations/-core/-databind: 2.18.2 -> 2.18.3
* jackson-dataformat-xml: 2.18.2 -> 2.18.3
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.18.2 -> 2.18.3
* jackson-module-jaxb-annotations: 2.18.2 -> 2.18.3
* guava: 33.4.0jre -> 33.4.6jre
* ph-css: 7.0.3 -> 7.0.4
* opencsv: 5.9 -> 5.10
* HikariCP: 6.2.1 -> 6.3.0
* junit-jupiter-api: 5.11.4 -> 5.12.1
* junit-platform-suite-engine: 1.11.4 -> 1.12.1
* poi / poi-ooxml: 5.3.0 -> 5.4.0
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 9.18.0 -> 9.20.0
* wicketstuff-select2: 9.18.0 -> 9.20.0
* assertj-core / assertj-guava: 3.26.3 -> 3.27.3
* elasticsearch-cluster-runner: 5.6.16.0 -> 5.6.16.1
* freemarker: 2.3.33 -> 2.3.34
* jersey-container-grizzly2-servlet: 2.45 -> 2.46
* jersey-client / jersey-server: 2.45 -> 2.46
* jersey-spring5: 2.45 -> 2.46
* jersey-media-multipart: 2.45 -> 2.46
* jersey-test-framework-prov0der-grizzly2: 2.45 -> 2.46
* jboss-logging-annotations: 3.0.3.Final -> 3.0.4.Final
* jsoup: 1.18.3 -> 1.19.1
* mockito/-core/-junit-jupiter: 5.14.2 -> 5.16.1
* postgresql: 42.7.4 -> 42.7.5
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.16 -> 2.0.17
* micrometer-core: 1.14.2 -> 1.14.5
* error_prone_annotations: 2.36.0 -> 2.37.0
* byte-buddy: 1.15.11 -> 1.17.5
* caffeine / jcache: 3.1.8 -> 3.2.0
* commons-codec: 1.17.1 -> 1.18.0
* rhino: 1.7.15 -> 1.8.0
* sass-embedded-host: 3.7.3 -> 4.1.0
* commons-beanutils: 1.9.4 -> 1.10.1
* awaitility: 4.2.2 -> 4.3.0
* maven-clean-plugin: 3.4.0 -> 3.4.1
* maven-compiler-plugin: 3.13.0 -> 3.14.0
* maven-failsafe-plugin: 3.5.2 -> 3.5.3
* maven-surefire-plugin: 3.5.2 -> 3.5.3
* maven-project-info-reports-plugin: 3.8.0 -> 3.9.0
* maven-site-plugin: 4.0.0-M16 -> 3.21.0
* maven-toolchains-plugin: 3.2.1 -> 3.2.0
* maven-deploy-plugin: 3.1.3 -> 3.1.4
* maven-install-plugin: 3.1.3 -> 3.1.4
* spotless-maven-plugin: 2.43.1 -> 2.44.3
* dependency-check-maven: 11.1.1 -> 12.1.0
* flatten-maven-plugin: 1.6.0 -> 1.7.0

(v5.24.0)=

# 5.24.0 (2025-02-19)

## Enhancement

* Add Outlook msg in `MediaType`.

(v5.23.0)=

# 5.23.0 (2025-01-06)

## Changes

* remove igloo-dependency-rules not used anymore
* migration gitlab-ci to rules pattern

## Dependencies

* jackson/-annotations/-core/-databind: 2.18.0 -> 2.18.2
* jackson-dataformat-xml: 2.18.0 -> 2.18.2
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.18.0 -> 2.18.2
* jackson-module-jaxb-annotations: 2.18.0 -> 2.18.2
* guava: 33.3.1jre -> 33.4.0jre
* HikariCP: 6.0.0 -> 6.2.1
* commons-io: 2.17.0 -> 2.18.0
* junit-jupiter-api: 5.11.1 -> 5.11.4
* junit-platform-suite-engine: 1.11.1 -> 1.11.4
* log4j-core / log4j-slf4j-impl / log4j-api: 2.24.0 -> 2.24.3
* jersey-container-grizzly2-servlet: 2.43 -> 2.45
* jersey-client / jersey-server: 2.43 -> 2.45
* jersey-spring5: 2.43 -> 2.45
* jersey-media-multipart: 2.43 -> 2.45
* jersey-test-framework-prov0der-grizzly2: 2.43 -> 2.45
* jboss-logging-annotations: 3.0.1.Final -> 3.0.3.Final
* jsoup: 1.18.1 -> 1.18.3
* mockito/-core/-junit-jupiter: 5.14.1 -> 5.14.2
* passay: 1.6.5 -> 1.6.6
* spring-security-\*: 5.8.14 -> 5.8.16
* micrometer-core: 1.13.4 -> 1.14.2
* error_prone_annotations: 2.32.0 -> 2.36.0
* byte-buddy: 1.15.3 -> 1.15.11
* commons-text: 1.12.0 -> 1.13.0
* sass-embedded-host: 3.7.1 -> 3.7.3
* maven-failsafe-plugin: 3.5.0 -> 3.5.2
* maven-surefire-plugin: 3.5.0 -> 3.5.2
* maven-dependency-plugin: 3.8.0 -> 3.8.1
* maven-javadoc-plugin: 3.10.0 -> 3.11.2
* maven-project-info-reports-plugin: 3.7.0 -> 3.8.0
* maven-toolchains-plugin: 3.2.0 -> 3.2.1
* dependency-check-maven: 10.0.4 -> 11.1.1
* versions-maven-plugin: 2.17.1 -> 2.18.0
* exec-maven-plugin: 3.4.1 -> 3.5.0

(v5.22.0)=

# 5.22.0 (2024-10-30)

5.21.0 is skipped.

## Bugfix

* Fix useless dependency sass-embedded-bundled-ia32
* Fix AbstractTask - UnexpectedRollbackException : saving batch report if there is transaction end emits an exception

## Enhancement

* Storage: reload detached Fichier for validate and invalidate actions.

(v5.20.0)=

# 5.20.0 (2024-10-07)

## Changes

* Locale, Timezone and Charset are checked and enforced during application startup.
  (Set by default to fr_FR, Europe/Paris, UTF-8, can be configured with
  `igloo.checks.locale`, `igloo.checks.timezone`, `igloo.checks.charset`).
* update opencsv dependency major version (4.3.2 -> 5.9)
* update sass-embedded-host dependency major version (1.10.0 -> 3.7.1)


## Bugfix

* BS5: Fix beautiful scrollbar horizontal height.

## Enhancement

* `MediaType`: Add some video mime types.
* Confirm modal: fix close button icon.
* Activate automatic deletion of temporary files
* Console: add logger indexation start/done.
* Check password expiration only if no original authentication (signInAs).

## Dependencies

* jackson/-annotations/-core/-databind: 2.17.1 -> 2.18.0
* jackson-dataformat-xml: 2.17.1 -> 2.18.0
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.17.1 -> 2.18.0
* jackson-module-jaxb-annotations: 2.17.1 -> 2.18.0
* guava: 33.2.1jre -> 33.3.1jre
* h2: 2.2.224 -> 2.3.232
* ph-css: 7.0.2 -> 7.0.3
* opencsv: 4.3.2 -> 5.9
* HikariCP: 5.1.0 -> 6.0.0
* commons-io: 2.16.1 -> 2.17.0
* junit-jupiter-api: 5.10.2 -> 5.11.1
* log4j-core / log4j-slf4j-impl / log4j-api: 2.23.1 -> 2.24.0
* poi / poi-ooxml: 5.2.5 -> 5.3.0
* assertj-core / assertj-guava: 3.25.3 -> 3.26.3
* jboss-logging: 3.6.0.Final -> 3.6.1.Final
* jboss-logging-annotations: 2.2.1.Final -> 3.0.1.Final
* jsoup: 1.17.2 -> 1.18.1
* mockito/-core/-junit-jupiter: 5.12.0 -> 5.14.0
* passay: 1.6.4 -> 1.6.5
* postgresql: 42.7.3 -> 42.7.4
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.13 -> 2.0.16
* spring-\*: 5.3.37 -> 5.3.39
* spring-security-\*: 5.8.13 -> 5.8.14
* micrometer-core: 1.13.1 -> 1.13.4
* error_prone_annotations: 2.28.0 -> 2.32.0
* byte-buddy: 1.14.17 -> 1.15.3
* commons-compress: 1.26.2 -> 1.27.1
* commons-lang3: 3.14.0 -> 3.17.0
* commons-codec: 1.17.0 -> 1.17.1
* hamcrest: 2.2 -> 3.0
* maven-failsafe-plugin: 3.3.0 -> 3.5.0
* maven-surefire-plugin: 3.3.0 -> 3.5.0
* maven-dependency-plugin: 3.7.1 -> 3.8.0
* maven-javadoc-plugin: 3.7.0 -> 3.10.0
* maven-project-info-reports-plugin: 3.6.0 -> 3.7.0
* maven-site-plugin: 4.0.0-M15 -> 4.0.0-M16
* maven-deploy-plugin: 3.1.2 -> 3.1.3
* maven-install-plugin: 3.1.2 -> 3.1.3
* dependency-check-maven: 9.2.0 -> 10.0.4
* versions-maven-plugin: 2.16.2 -> 2.17.1
* exec-maven-plugin: 3.3.0 -> 3.4.1
* buildnumber-maven-plugin: 3.2.0 -> 3.2.1
* frontend-maven-plugin: 1.15.0 -> 1.15.1
* sass-embedded-host: 1.10.0 -> 3.7.1
* protobuf-java: 3.21.11 -> 4.28.2


(v5.19.0)=

# 5.19.0 (2024-07-26)

## Enhancement

* XSS: Add CSP default src none on Fichier Web Resource

(v5.18.0)=

# 5.18.0 (2024-07-05)

## Bugfix

* task configuration : fix manager init to populate QueueIds

## Enhancement

* storage : method getFichierById return null instead of an Exception if not Fichier is found
* Add `.form-file-btn-xs` form file button size.

## Dependencies

* jackson/-annotations/-core/-databind: 2.16.2 -> 2.17.1
* jackson-dataformat-xml: 2.16.2 -> 2.17.1
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.16.2 -> 2.17.1
* jackson-module-jaxb-annotations: 2.16.2 -> 2.17.1
* guava: 33.0.0jre -> 33.2.1jre
* ph-css: 7.0.1 -> 7.0.2
* commons-io: 2.15.1 -> 2.16.1
* jsass: 5.11.0 -> 5.11.1
* wicket / wicket/-auth-roles/-core/-devutils/-extensions/-ioc/-spring: 9.13.0 -> 9.18.0
* wicketstuff-select2: 9.13.0 -> 9.18.0
* freemarker: 2.3.32 -> 2.3.33
* jersey-container-grizzly2-servlet: 2.41 -> 2.43
* jersey-client / jersey-server: 2.41 -> 2.43
* jersey-spring5: 2.41 -> 2.43
* jersey-media-multipart: 2.41 -> 2.43
* jersey-test-framework-provider-grizzly2: 2.41 -> 2.43
* mockito/-core/-junit-jupiter: 5.11.0 -> 5.12.0
* postgresql: 42.7.2 -> 42.7.3
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.12 -> 2.0.13
* spring-\*: 5.3.34 -> 5.3.37
* spring-security-\*: 5.8.11 -> 5.8.13
* webjars-locator-core: 0.58 -> 0.59
* micrometer-core: 1.12.4 -> 1.13.1
* error_prone_annotations: 2.26.0 -> 2.28.0
* byte-buddy: 1.14.12 -> 1.14.17
* picocli: 4.7.5 -> 4.7.6
* commons-compress: 1.26.1 -> 1.26.2
* commons-text: 1.11.0 -> 1.12.0
* commons-validator: 1.8.0 -> 1.9.0
* commons-codec: 1.16.1 -> 1.17.0
* openpdf/openpdf-fonts-extra/pdf-swing/pdf-toolbox: 1.4.1 -> 1.4.2
* rhino: 1.7.14 -> 1.7.15
* maven-clean-plugin: 3.3.2 -> 3.4.0
* maven-compiler-plugin: 3.12.1 -> 3.13.0
* maven-failsafe-plugin: 3.2.5 -> 3.3.0
* maven-surefire-plugin: 3.2.5 -> 3.3.0
* maven-dependency-plugin: 3.6.1 -> 3.7.1
* maven-javadoc-plugin: 3.6.3 -> 3.7.0
* maven-project-info-reports-plugin: 3.5.0 -> 3.6.0
* maven-site-plugin: 4.0.0-M13 -> 4.0.0-M15
* maven-toolchains-plugin: 3.1.0 -> 3.2.0
* maven-deploy-plugin: 3.1.1 -> 3.1.2
* maven-assembly-plugin: 3.7.0 -> 3.7.1
* maven-jar-plugin: 3.3.0 -> 3.4.2
* maven-install-plugin: 3.1.1 -> 3.1.2
* maven-processor-plugin: 5.0 -> 5.1
* jacoco-maven-plugin: 0.8.11 -> 0.8.12
* dependency-check-maven: 9.0.9 -> 9.2.0
* maven-enforcer-plugin: 3.4.1 -> 3.5.0
* exec-maven-plugin: 3.2.0 -> 3.3.0
* maven-source-plugin: 3.3.0 -> 3.3.1

(v5.17.1)=

# 5.17.1 (2024-05-22)

## Dependencies

* Bootstrap 4.6.1 -> 4.6.0

(v5.17.0)=

# 5.17.0 (2024-04-15)

## Bugfix

* Fix scss environment section.
* BS5: fix table row disabled.

## Dependencies

* jackson/-annotations/-core/-databind: 2.16.0 -> 2.16.2
* jackson-dataformat-xml: 2.16.0 -> 2.16.2
* jackson-jaxrs-json-provider / jackson-jaxrs-xml-provider: 2.16.0 -> 2.16.2
* jackson-module-jaxb-annotations: 2.16.0 -> 2.16.2
* guava: 32.1.3jre -> 33.0.0jre
* querydsl-jpa / querydsl-apt / querydsl-core: 5.0.0 -> 5.1.0
* jsass: 5.10.5 -> 5.11.0
* junit-jupiter-api: 5.10.1 -> 5.10.2
* junit-platform-suite-engine: 1.10.1 -> 1.10.2
* log4j-core / log4j-slf4j-impl / log4j-api: 2.22.0 -> 2.23.1
* assertj-core / assertj-guava: 3.24.2 -> 3.25.3
* jersey-container-grizzly2-servlet: 2.40 -> 2.41
* jersey-client / jersey-server: 2.40 -> 2.41
* jersey-spring5: 2.40 -> 2.41
* jersey-media-multipart: 2.40 -> 2.41
* jersey-test-framework-provider-grizzly2: 2.40 -> 2.41
* jsoup: 1.17.1 -> 1.17.2
* mockito/-core/-junit-jupiter: 5.8.0 -> 5.11.0
* postgresql: 42.7.1 -> 42.7.2
* jcl-over-slf4j / jul-to-slf4j / slf4j-api: 2.0.9 -> 2.0.12
* spring-\*: 5.3.31 -> 5.3.32
* spring-security-\*: 5.8.8 -> 5.8.10
* webjars-locator-core: 0.55 -> 0.58
* value: 2.10.0 -> 2.10.1
* micrometer-core: 1.12.0 -> 1.12.4
* error_prone_annotations: 2.23.0 -> 2.26.0
* byte-buddy: 1.14.10 -> 1.14.12
* commons-compress: 1.25.0 -> 1.26.1
* commons-codec: 1.16.0 -> 1.16.1
* openpdf/openpdf-fonts-extra/pdf-swing/pdf-toolbox: 1.3.34 -> 1.4.1
* maven-compiler-plugin: 3.11.0 -> 3.12.1
* maven-failsafe-plugin: 3.2.2 -> 3.2.5
* maven-surefire-plugin: 3.2.2 -> 3.2.5
* maven-site-plugin: 4.0.0-M12 -> 4.0.0-M13
* maven-assembly-plugin: 3.6.0 -> 3.7.0
* spotless-maven-plugin: 2.41.1 -> 2.43.0
* dependency-check-maven: 9.0.4 -> 9.0.9
* exec-maven-plugin: 3.1.1 -> 3.2.0
* flatten-maven-plugin: 1.5.0 -> 1.6.0

(v5.15.1)=

# 5.15.1 (2024-02-20)

## Bugfix

* BS5: fix body bg color.

(v5.15.0)=

# 5.15.0 (2024-02-05)

## Breaking change

* Remove Log4j 1.x / Reload4j support
* Remove ehcache2 support

## Enhancement

* Add `properties.hidden` configuration to hide confidential values in Properties page
  in admin console.
* Add Wicket listener form clear input.

## Bugfix

* Storage: add missing transactionnal read only on `getFichierById(Long)`.
* Fix `BootstrapBadge` markup html comments.
* Select2 : fix `allowClear` setting if not required.
* BasicApp: fix `ReferenceData` drop down search bean interface.
* Fix Wicket converter locator for enums anonymous class.

## Dependencies

* **Font Awesome 6.3.0 -> 6.5.1**
* jquery-ui: 1.12.1 -> 1.13.2
* select2: 4.0.10 -> 4.0.13
* jackson: 2.15.2 -> 2.16.0
* guava: 32.1.2jre -> 32.1.3jre
* h2: 2.2.220 -> 2.2.224
* HikariCP: 5.0.1 -> 5.1.0
* commons-io: 2.13.0 -> 2.15.1
* junit-jupiter-api: 5.10.0 -> 5.10.1
* junit-platform-suite-engine: 1.10.0 -> 1.10.1
* log4j-core: 2.20.0 -> 2.22.0
* poi: 5.2.3 -> 5.2.5
* wicketstuff-select2: 9.13.0 -> 9.16.0
* flyway-core: 9.22.2 -> 9.22.3
* jsoup: 1.16.1 -> 1.17.1
* mockito: 5.5.0 -> 5.8.0
* passay: 1.6.3 -> 1.6.4
* postgresql: 42.6.0 -> 42.7.1
* slf4j-api: 2.20.0 -> 2.22.0
* spring: 5.3.30 -> 5.3.31
* spring-security: 5.8.7 -> 5.8.8
* webjars-locator-core: 0.53 -> 0.55
* value: 2.9.3 -> 2.10.0
* micrometer-core: 1.11.4 -> 1.12.0
* error_prone_annotations: 2.22.0 -> 2.23.0
* spring-boot: 2.7.16 -> 2.7.18
* byte-buddy: 1.14.8 -> 1.14.10
* commons-compress: 1.24.0 -> 1.25.0
* commons-text: 1.10.0 -> 1.11.0
* commons-lang3: 3.13.0 -> 3.14.0
* commons-validator: 1.7 -> 1.8.0
* openpdf: 1.3.30 -> 1.3.34
* maven-clean-plugin: 3.3.1 -> 3.3.2
* maven-failsafe-plugin: 3.1.2 -> 3.2.2
* maven-surefire-plugin: 3.1.2 -> 3.2.2
* maven-dependency-plugin: 3.6.0 -> 3.6.1
* maven-javadoc-plugin: 3.6.0 -> 3.6.3
* maven-project-info-reports-plugin: 3.4.5 -> 3.5.0
* maven-site-plugin: 4.0.0-M9 -> 4.0.0-M12
* maven-processor-plugin: 5.0jdk8 -> 5.0
* jacoco-maven-plugin: 0.8.10 -> 0.8.11
* dependency-check-maven: 8.4.0 -> 9.0.4
* versions-maven-plugin: 2.16.1 -> 2.16.2
* exec-maven-plugin: 3.1.0 -> 3.1.1
* frontend-maven-plugin: 1.14.0 -> 1.15.0

(v5.14.0)=

# 5.14.0 (2023-11-24)

## Bugfix

* Important fix - {issue}`84`: Broken browser cache support for scss. Since version 5.10.0,
  timestamp information included in scss filename is broken. Timestamp is constant, so it
  defeats cache refresh mechanism. Issue only appears if build-time scss is used. This release
  fixes this problem.

  If you use any of the workarounds given on issue, you should remove it.

* ClipboardBehavior fix: text configuration is correctly set

* `GenericEntity.*COLLATOR`: fix foreign language collator configuration

* Workaround focustrap for bootstrap Modal: we disable focustrap that is buggy when select2 or
  complex javascript widget are used inside modal. No action is needed for this fix.

  Issue still exists for offcanvas.
  
  Further work is to be done to enable both focustrap and complex javascript components on
  both modal and offcanvas components.

* DataTableBuilder: use `button` markup for action instead of `a`. It allows not to focus
  empty anchor (top of the page) when clicked.

## Enhancement

* `DataTableBuilder`: update side link icon.

(v5.13.0)=

# 5.13.0 (2023-09-22)

## Bugfix

* `DataTableBuilder`: fix side link icon position.
* Update `BootstrapColor` values (add `dark` and `light` - remove `todo`)

If you encounter `package com.google.errorprone.annotations does not exist` at compilation time, it's related
to code generation change from immutables library. Add `com.google.errorprone:error_prone_annotations` to your project's
dependencies.

## Dependencies

* spring: 5.3.28 -> 5.3.30
* spring-boot: 2.7.14 -> 2.7.16
* spring-security: 5.8.3 -> 5.8.7
* guava: 32.1.1-jre -> 32.1.2-jre
* caffeine: 3.1.6 -> 3.1.8
* ph-css: 7.0.0 -> 7.0.1
* byte-buddy: 1.14.5 -> 1.14.8
* commons-compress: 1.23.0 -> 1.24.0
* commons-lang3: 3.12.0 -> 3.13.0
* micrometer: 1.11.2 -> 1.11.4
* picocli: 4.7.4 -> 4.7.5
* flyway-core: 9.20.1 -> 9.22.2
* h2: 2.2.220 -> 2.2.224
* slf4j: 2.0.7 -> 2.0.9
* junit: 5.9.3 -> 5.10.0
* mockito: 5.4.0 -> 5.5.0
* errorprone: 2.20.0 -> 2.22.0

Maven plugins:

* frontend-maven-plugin: 1.13.4 -> 1.14.0
* maven-antrun-plugin: 3.1.0
* maven-javadoc-plugin: 3.5.0 -> 3.6.0
* maven-enforcer-plugin: 3.3.0 -> 3.4.1
* owasp-maven-plugin: 8.3.1 -> 8.4.0
* versions-maven-plugin: 2.16.0 -> 2.16.1
* maven-processor-plugin: 5.0-rc3 -> 5.0-jdk8

(v5.12.1)=

# 5.12.1 (2023-08-28)

```{warning}
5.12.0: flyway + spring-boot is broken, version is not released ; use 5.12.1 instead.
```

## Enhancement

* `JpaSearchQuery`: add `innerJoin` for `EntityPath`.
* Backport 6.x: allow AbstractNotificationContentDescriptorFactory to override
  wicket application context (see {ref}`email`)

## Dependencies

* spring: 5.3.27 -> 5.3.28
* spring-boot: 2.7.12 -> 2.7.14
* spring-security: 5.8.2 -> 5.8.3
* jersey2: 2.39.1 -> 2.40
* guava: 32.0.0-jre -> 32.1.1-jre
* commons-codec: 1.15 -> 1.16.0
* commons-io: 2.11.0 -> 2.13.0
* micrometer: 1.11.0 -> 1.11.2
* picocli: 4.7.3 -> 4.7.4
* jboss-logging-annotations: 3.5.0.Final -> 3.5.3.Final
* flyway-core: 9.19.1 -> 9.20.1
* h2: 2.1.214 -> 2.2.220
* webjars-locator-core: 0.52 -> 0.53
* popper2: 2.11.7 -> 2.11.8
* mockito: 4.3.1 -> 5.4.0
* logunit: 1.1.3 -> 2.0.0
* errorprone: 2.19.1 -> 2.20.0

Maven plugins:

* maven-surefire-plugin: 3.1.0 -> 3.1.2
* maven-failsafe-plugin: 3.1.0 -> 3.1.2
* maven-war-plugin: 3.3.2 -> 3.4.0
* buildnumber-maven-plugin: 3.1.0 -> 3.2.0
* frontend-maven-plugin: 1.12.1 -> 1.13.4
* maven-clean-plugin: 3.2.0 -> 3.3.1
* maven-site-plugin: 4.0.0-M8 -> 4.0.0-M9
* maven-project-info-reports-plugin: 3.4.4 -> 3.4.5
* owasp-maven-plugin: 8.2.1 -> 8.3.1
* versions-maven-plugin: 2.15.0 -> 2.16.0

(v5.11.0)=

# 5.11.0 (2023-08-08)

## Bugfix

* BS4 / BS5: fix datepicker z-index.
* Task: fix markup detail page.
* DataTableBuilder: fix action btn placeholder.
* {issue}`82`: @ManifestPropertySource on @Configuration inner class fails

## Enhancement

* Storage: add update filename service method
* Storage: disable Fichier caching
* Consistency on `IConverter` ressource keys error.
* `GenericEntity`: rename Hibernate Search field `ID_SORT` to `ID`.

(v5.10.1)=

# 5.10.1 (2023-06-05)

## Bugfix

* {issue}`81`: Loading SCSS from jar file triggers NPE

(v5.10.0)=

# 5.10.0 (2023-06-02)

## Breaking change

* dropped TrueVFS support: historically used by Igloo
  * **needed change**: you need to remove `openTFileRegistryFilter`
    `filter` and `filter-mapping` from your servlet container configuration
    (`web.xml` or java configuration).
  * to read excel files in `AbstractImportDataServiceImpl`; these feature now
    uses resource loading mechanisms, and TrueVFS removal has no effect.
  * to unwrap file from archives in `SimpleFileStoreImpl`; if you do not rely
    on implicit archive-related behavior and FileStore, TrueVFS removal has
    no effect.
  * if you rely on TrueVFS for custom usage, you may:
    * replace TrueVFS with classic file APIs
    * keep your TrueVFS code, and perform the needed modification related to
      the `openTFileRegistryFilter` servlet filter removal.

(v5.9.0)=

# 5.9.0 (2023-06-02)

## Dependencies

* jackson: 2.14.2 -> 2.15.2
* wicket-webjars: 3.0.6 -> 3.0.7
* junit-jupiter-api: 5.9.2 -> 5.9.3
* junit-platform-suite-engine: 1.9.2 -> 1.9.3
* wicket: 9.12.0 -> 9.13.0
* wicketstuff-select2: 9.12.0 -> 9.13.0
* flyway-core: 9.16.1 -> 9.19.1
* jsoup: 1.15.4 -> 1.16.1
* mockito: 5.2.0 -> 5.3.1
* spring: 5.3.26 -> 5.3.27
* spring-security: 5.8.2 -> 5.8.3
* micrometer-core: 1.10.5 -> 1.11.0
* error_prone_annotations: 2.18.0 -> 2.19.1
* spring-boot: 2.7.10 -> 2.7.12
* byte-buddy: 1.14.3 -> 1.14.5
* picocli: 4.7.1 -> 4.7.3
* caffeine: 3.1.5 -> 3.1.6
* guava: 31.1-jre -> 32.0.0->jre

Maven plugins:

* maven-dependency-plugin: 3.5.0 -> 3.6.0
* maven-assembly-plugin: 3.5.0 -> 3.6.0
* maven-source-plugin: 3.2.1 -> 3.3.0
* maven-failsafe-plugin: 3.0.0 -> 3.1.0
* maven-surefire-plugin: 3.0.0 -> 3.1.0
* maven-project-info-reports-plugin: 3.4.2 -> 3.4.4
* maven-site-plugin: 4.0.0-M6 -> 4.0.0-M8
* jacoco-maven-plugin: 0.8.9 -> 0.8.10
* maven-enforcer-plugin: 3.2.1 -> 3.3.0
* flatten-maven-plugin: 1.4.1 -> 1.5.0
* buildnumber-maven-plugin: 3.0.0 -> 3.1.0

(v5.8.0)=

# 5.8.0 (2023-06-02)

## Bugfix

* BS5: fix modal sizing override.

(v5.7.1)=

# 5.7.1 (2023-05-25)

## Bugfix

* AbstractExcelTableExport : fix addTextCell method. Check length of text, if
  text length is greater than maxTextLength then text is susbtring.

(v5.7.0)=

# 5.7.0 (2023-05-10)

## Bugfix

* Remove target behavior on unbind in collapse behavior.
* BS5: fix scss `.btn-form-control-check`.

## Enhancement

* BS5: fix sass slash div depercated.
* BS5: add collapse toggle css visibility utilities.

(v5.6.0)=

# 5.6.0 (2023-04-19)

## Bugfix

* {issue}`79`: Storage: split on StorageUnit size is broken
* Lookup BS4/BS5: fix web socket broadcast case.

## Enhancement

* Bootstrap 5: rename `.heading-section-white` to `.heading-section-light` for consistency.
* Storage: added `StorageService#isCreatedBy`
* maven-site-plugin: added XML format for dependencies reports

## Breaking change

* JUnit4 : dropped support ; `AbstractJunit4TestCase` is removed

## Dependencies

* hibernate: 5.6.14 -> 5.6.15
* hibernate-search: 5.11.11 -> 5.11.12
* spring: 5.2.25 -> 5.2.26
* spring-security: 5.8.1 -> 5.8.2
* flywaydb: 9.14.1 -> 9.16.1
* spring-boot: 2.7.8 -> 2.7.10
* jersey2: 2.38 -> 2.39.1
* slf4j: 2.0.6 -> 2.0.7
* log4j2: 2.19.0 -> 2.20.0
* commons-fileupload: 1.4 -> 1.5
* postgresql: 45.2.3 -> 42.6.0
* commons-compress: 1.22 -> 1.23.0
* byte-buddy: 1.12.23 -> 1.24.3
* popper2: 2.11.6 -> 2.11.7
* reload4j: 1.2.24 -> 1.2.25
* passay: 1.6.2 -> 1.6.3
* micrometer: 1.10.3 -> 1.10.5
* mockito: 5.1.1 -> 5.2.0
* jsoup: 1.15.3 -> 1.15.4

Maven plugins:

* owasp-maven-plugin: 8.0.2 -> 8.1.2
* versions-maven-plugin: 2.14.2 -> 2.15.0
* maven-resources-plugin: 3.3.0 -> 3.3.1
* jacoco-maven-plugin: 0.8.8 -> 0.8.9
* maven-compiler-plugin: 3.10.1 -> 3.11.0
* maven-surefire-plugin: 3.0.0-M8 -> 3.0.0
* maven-assembly-plugin: 3.4.2 -> 3.5.0
* maven-javadoc-plugin: 3.4.1 -> 3.5.0
* maven-failsafe-plugin: 3.0.0-M8 -> 3.0.0
* maven-deploy-plugin: 3.0.0 -> 3.1.1
* maven-site-plugin: 4.0.0-M4 -> 4.0.0-M6
* maven-install-plugin: 3.1.0 -> 3.1.1
* flatten-maven-plugin: 1.3.0 -> 1.4.1

(v5.5.2)=

# 5.5.2 (2023-03-31)

## Bugfix

* Fix console configuration for custom configuration.
* Fix BS5 popover and tooltip html content visibility.

(v5.5.1)=

# 5.5.1 (2023-03-21)

## Bugfix

* Fix dart-css `@import` triggered by bootstrap 4 basic-application (*has no known prefix* error).

(v5.4.1)=

# 5.4.1 (2023-03-21)

## Bugfix

* Fix dart-css `@import` triggered by bootstrap 4 basic-application (*has no known prefix* error).

(v5.5.0)=

# 5.5.0 (2023-03-15)

## Enhancement

* {ref}`cache` : new reference implementation for caching is caffeine

## Bugfix

* BS5: rollback HTML emails to BS4.
* BS5: remove BS4 webjar dependency from `wicket-bootstrap5`.

## Breaking change

* Spring cache must switch to caffeine (mandatory), Hibernate cache can switch
  to Caffeine (recommended). See {ref}`caffeine-migration`.


(v5.4.0)=

# 5.4.0 (2023-03-13)

## Enhancement

* {ref}`scss`
  * jsass/libsass replaced by dart-sass
  * scss generated at build-time (optional)

## Breaking change

* scss must be adapted for dart-sass processing (mandatory). See {ref}`scss-migration`.
* webapp `pom.xml` must be adapted for build-time generation (optional). See
{ref}`scss-build-time-generation`.


(v5.3.1)=

# 5.3.1 (2023-03-13)

## Bugfix

* BS5 - Tab : fix selector tabRenderHead.

(v5.3.0)=

# 5.3.0 (2023-02-24)

## Bugfix

* BS5: fix feedback dismiss padding.

## Enhancements

* Add WIP modal for indexation process.

## Dependencies

* Bootstrap 5 5.1.3 -> 5.2.3
* Font Awesome 6.1.2 -> 6.3.0
* junit5-suite 1.9.1 -> 1.9.2


(v5.2.0)=

# 5.2.0 (2023-02-15)

## Enhancements

* BasicApp: use postgresql instead of h2 for unit tests.
* BasicApp: clean db port in properties files.
* BasicApp: webapp now uses {ref}`igloo-logging` JMX helpers

## Dependencies

* jackson 2.14.1 -> 2.14.2
* ph-css 6.5.0 -> 7.0.0
* junit-jupiter-api 5.9.1 -> 5.9.2
* assertj 3.5.0 -> 3.24.2
* flyway 9.11.0 -> 9.14.1
* freemarker 2.3.31 -> 2.3.32
* jersey 2.37 -> 2.38
* mockito 4.9.0 -> 5.1.1
* postgresql 42.5.1 -> 42.5.3
* jul-to-slf4j / slf4j-api 2.0.5 -> 2.0.6
* spring 5.3.24 -> 5.3.25
* spring-security 5.8.0 -> 5.8.1
* immutables value 2.9.2 -> 2.9.3
* micrometer-core 1.10.2 -> 1.10.3
* error_prone_annotations 2.16 -> 2.18.0
* spring-boot 2.7.6 -> 2.7.8
* byte-buddy 1.12.19 -> 1.12.23
* picocli 4.7.0 -> 4.7.1

Maven plugins:

* maven-failsafe-plugin 3.0.0-M7 -> 3.0.0-M8
* maven-surefire-plugin 3.0.0-M7 -> 3.0.0-M8
* maven-dependency-plugin 3.4.0 -> 3.5.0
* maven-project-info-reports-plugin	3.4.1 -> 3.4.2
* maven-install-plugin 3.0.1 -> 3.1.0
* dependency-check-maven 7.4.1 -> 8.0.2
* maven-enforcer-plugin 3.1.0 -> 3.2.1
* versions-maven-plugin 2.13.0 -> 2.14.2

(v5.1.2)=

# 5.1.2 (2023-02-13)

## Bugfix

* BS5: fix datepicker `z-index` on inputs with errors.

(v5.1.1)=

# 5.1.1 (2023-02-09)

## Bugfix

* Fix content css class utility.

(v5.1.0)=

# 5.1.0 (2023-02-07)

## Enhancements

* Replace igloo custom flyway integration with spring-boot flyway integration.

## Breaking change

* Spring-boot Flyway integration needs some configuration and code migration on your projects.
  Please use {ref}`flyway-migration` to update your project.

(v5.0.5)=

# 5.0.5 (2023-02-06)

## Bugfix

* Remove overflow hidden on table cells.
* BasicApp: multiple BS5 fixes.

## Enhancements

* BasicApp: minor code consistency.

(v5.0.4)=

# 5.0.4 (2023-01-10)

## Bugfix

* Popover: hide the whole popover panel if the content component is not visibile.

(v5.0.3)=

# 5.0.3 (2023-01-03)

## Bugfix

* {issue}`74`: AbstractOfflinePanelRendererServiceImpl is broken with bootstrap component

## API Changes

* `AbstractSimpleWicketNotificationDescriptor`: a `getComponentClass()` is needed to provide
  return type information of `getComponent()` method.
* `AbstractOfflinePanelRendererServiceImpl` `renderComponent` and `renderPage` methods are
  modified to use `IOfflineComponentProvider` in place of `SerializableSupplier2<Component>`:
  a helper method `IOfflineComponentProvider.fromSupplier(...)` can be used to easily rewrite
  your method calls.
* `IBootstrap4Component` and `IBootstrap5Component` are added to mark root component used
  in notification emails (so that subcomponent can determine bootstrap version).

## Dependencies

* jackson 2.13.4 -> 2.14.1
* byte-buddy 1.12.18 -> 1.12.19
* flywaydb 9.7.0 -> 9.8.3
* postgresql 42.5.0 -> 42.5.1
* spring 5.3.23 -> 5.3.24
* spring-boot 2.7.5 -> 2.7.6
* spring-security 5.7.3 -> 5.8.0
* micrometer 1.9.5 -> 1.10.2

Other dependencies

* mockito 4.8.1 -> 4.9.0
* maven-dependency-plugin 3.3.0 -> 3.4.0
* owasp-maven-plugin 7.3.0 -> 7.4.1

(v5.0.2)=

# 5.0.2 (2022-12-19)

## Bugfix

* {issue}`72`: Fix ignored log4j2 configuration override


(v5.0.1)=

# 5.0.1 (2022-12-16)

## Bugfix

* {issue}`73`: Fix default Tooltip configuration


(v5.0.0)=

# 5.0.0 (2022-12-08)

## Enhancements

* Joiners: add slash with space before and after

## Feature

* Igloo support both bootstrap 4 and bootstrap 5. Existing Igloo UI components
  support both bootstrap 4 and bootstrap 5 with minimal changes. But any custom
  project markups may need to be rewritten to accomodate bootstrap behavior changes.
* Check migration guide (below) for practical advice. A tool `jimportdiff` can
  handle tedious rewrite tasks.

## Removed

* `WicketBootstrapComponentsModule` deleted ; replaced by `IBootstrapProvider`.
  Does not affect final projects.
* `AbstractPopoverLinkContentPanel`: unused
* `BootstrapTooltipDocumentBehavior` replaced by `BootstrapTooltipBehavior`
* `AlertJavascriptResourceReference`: unused
* `ILongRunningPage`, `AdaptativeTimeoutRequestCycleSettings`: unused
* `CommentOutModifier`: unused
* `AbstractBootstrapWebappConfig`, `WicketBootstrapServiceConfig`: unused
* `IBootstrap*Module`, `Bootstrap*Module`: unused by projects
* `AbstractBootstrapTooltipBehavior`: unused
* `BootstrapModalStatement`: unused by projects
* `BootstrapConfirmStatement`: unused by projects
* `BootstrapTab`: unused by projects
* `BootstrapButtonBehavior`: unused
* `BootstrapAlertBehavior`: unused
* `BootstrapScrollSpyBehavior`: unused
* `*ConfirmButton`: unused (use ConfirmLink instead)

## Behavior changes

* ActionRenderers (from basic-application ): replace all BootstrapRenderer by
  IBootstrapRenderer (except BootstrapRenderer.constant).

* Popover :
  * customClass become a raw string (no longer a string list)
  * default placement change from `auto` to `right`

* Alert :
  * Igloo alert components are renamed feedback (as this components are not
    linked with bootstrap alert component)
  * AlertJavascriptResourceReference -> FeedbackJavaScriptResourceReference
  * `$.fn.alert.*` -> `$.fn.feedback.*`
  * Not used by projects, usage is generally hidden and handled by Igloo correctly.

* Sidebar
  * bootstrap 4 : a custom js is used
  * bootstrap 5 : offcanvas is used and activated with data-attributes :
    `bs-data-toggle` and `bs-data-dismiss`.

* Confirm : this is a custom Igloo component based on bootstrap modal implementation
  * confirmation event is renamed `confirm.bs.confirm`
  * cancellation event is renamed `cancel.bs.confirm`
  * data attributes are renamed (if you use Igloo behavior to generate markup,
    no change are needed, check that you have no occurence of `modal-confirm`):
    * `modal-confirm-text` -> `bs-text`
    * `modal-confirm-title` -> `bs-title`
    * `modal-confirm-yes-label` -> `bs-yes-label`
    * `modal-confirm-no-label` -> `bs-no-label`
    * `modal-confirm-yes-icon` -> `bs-yes-icon`
    * `modal-confirm-no-icon` -> `bs-no-icon`
    * `modal-confirm-yes-button` -> `bs-yes-button`
    * `modal-confirm-no-button` -> `bs-no-button`
    * `modal-confirm-text-no-escape` -> `bs-no-escape`
    * `modal-confirm-css-class-names` -> `bs-css-class-names`

* Webjars
  * `webjars/` prefixes are not needed in webjars urls, and can trigger unexpected
    behavior in webjar lookup
  * Check your webjar ResourceReference for the issue:

    ```bash
    grep -r --include "*ResourceReference.java" webjars/
    ```

* OpenTFileRegistryFilter

  * moved to `org.iglooproject.truevfs.filter.OpenTFileRegistryFilter`
  * add `org.iglooproject.components:igloo-component-truevfs` dependency if needed
  * update references to `OpenTFileRegistryFilter` (web.xml)

    ```xml
    <filter>
      <filter-name>openTFileRegistryFilter</filter-name>
      <filter-class>org.iglooproject.wicket.servlet.filter.OpenTFileRegistryFilter</filter-class>
    </filter>
    ```

    ```xml
    <filter>
      <filter-name>openTFileRegistryFilter</filter-name>
      <filter-class>org.iglooproject.truevfs.filter.OpenTFileRegistryFilter</filter-class>
    </filter>
    ```

## Other major renames

* igloo-component-wicket
  * `org.iglooproject.wicket.markup.html.model` -> `igloo.wicket.model`
  * `org.iglooproject.wicket.markup.html.basic` -> `igloo.wicket.component`

* igloo-component-wicket-bootstrap4 / console
  * module `igloo-component-wicket-bootstrap5`, package `igloo.console`

* `org.iglooproject.wicket.bootstrap4.markup.html.template.js.select2` ->
  module `igloo-component-wicket-select2/igloo.select2`
* `org.iglooproject.wicket.bootstrap4.markup.html.template.js.jqueryui` ->
  module `igloo-component-wicket-jqueryui/igloo.jqueryui`
* `org.iglooproject.wicket.bootstrap4.markup.html.template.css.jqueryui` ->
  module `igloo-component-wicket-jqueryui/igloo.jqueryui`
* `org.iglooproject.wicket.bootstrap4.markup.html.template.css.fontawesome` ->
  module `igloo-component-wicket-fontawesome/igloo.fontawesome`

## Bootstrap 5 JS resources

All boostrap 5 resources are packed inside a bundle. There is no separated resources
for each component. Only Igloo custom components are delivered separatly.

## Migration guide

These instructions may help to migrate a bootstrap 4 project easily. These instructions
**do not migrate from bootstrap 4 to bootstrap 5**. Migrated project stay with bootstrap 4.

### General procedure

* As usual: switch igloo-maven, igloo-commons and igloo dependencies and parent pom
  version
* find and update resources extending `Webjars*ResourceReference` and remove `webjars/`
  prefix in resource reference's name
* Use jimportdiff rewrite (see below):
  * rewrite classes (boostrap 4 priority allowed)
  * scss: rename `webjars://bootstrap-override:` -> `webjars://bootstrap4-override:`
  * scss: rename `webjars://bootstrap:` -> `webjars://bootstrap4:`
  * `web.xml` Log4JUrlFilter and OpenTFileRegistryFilter renames
  * some advices
* check/add `igloo-component-truevfs` dependency
* check/add `igloo-component-wicket` dependency
* check/add `igloo-component-wicket-console` dependency
* find and update base Template to implement `IBootstrap4Page` (check your page
  inheritance tree)
* manual fix of tooltip behavior
* manual fix of popover behavior
* manual fix of `IBootstrapRenderer`: replace `BootstrapRenderer` by
  `IBootstrapRenderer` so that interface is correctly implemented
* add table-cell-widths in `_bootstrap-variables.scss`
* update console css:
  * `rm -rf <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/common/template/resources/styles/console/*`
  * `cp -ar ~/git/igloo-parent/basic-application/basic-application-webapp/src/main/java/org/iglooproject/basicapp/web/application/common/template/resources/styles/application/console/* <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/common/template/resources/styles/console/` : 13 modified files
  * `git checkout HEAD $( find <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/common/template/resources/styles/console/ -name 'Console*ResourceReference.java' )` : rollback java file modifications, 2 modified files
* update feedback panel:
    * `cp ~/git/igloo-parent/basic-application/basic-application-webapp/src/main/java/org/iglooproject/basicapp/web/application/console/common/component/ConsoleAccessEnvironmentPanel.java <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/console/common/component/ConsoleAccessEnvironmentPanel.java`
    * `cp ~/git/igloo-parent/basic-application/basic-application-webapp/src/main/java/org/iglooproject/basicapp/web/application/console/common/component/ConsoleEnvironmentPanel.java <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/console/common/component/ConsoleEnvironmentPanel.java`
    * `cp ~/git/igloo-parent/basic-application/basic-application-webapp/src/main/java/org/iglooproject/basicapp/web/application/console/common/component/ConsoleEnvironmentPanel.html <PROJECT_WEBAPP>/src/main/java/<BASE_PACKAGE>/web/application/console/common/component/ConsoleEnvironmentPanel.html`
    * fix package declaration / package imports / *APPLICATION*Session call
* adapt custom console pages

### jimportdiff

cf {ref}`jimportdiff`

```
pipenv run ./jimportdiff rewrite --migration igloo5 igloo-4.4.1-5.0.0.json ../target-project
```
