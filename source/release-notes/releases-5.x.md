# Releases 5.x

(v5.3.0)=

# 5.3.0 (YYYY-MM-DD)

(v5.2.0)=

# 5.2.0 (2023-02-15)

## Enhancements

* BasicApp: use postgresql instead of h2 for unit tests.
* BasicApp: clean db port in properties files.
* BasicApp: webapp now use {ref}`igloo-logging` JMX helpers
* Add igloo-logging JMX helper
* Remove flyway custom implementation
* jsass/libsass replaced by dart-sass
  
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
