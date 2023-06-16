# Releases 5.x

(v5.11.0)=

# 5.11.0 (TBD)

## Bugfix

* BS5: fix datepicker z-index.

## Enhancement

* Storage: add update filename service method
* Storage: disable Fichier caching

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

## Breaking changes

* Spring cache must switch to caffeine (mandatory), Hibernate cache can switch
  to Caffeine (recommended). See {ref}`caffeine-migration`.


(v5.4.0)=

# 5.4.0 (2023-03-13)

## Enhancement

* {ref}`scss`
  * jsass/libsass replaced by dart-sass
  * scss generated at build-time (optional)

## Breaking changes

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

## Breaking changes

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
