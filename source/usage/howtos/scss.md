# Scss/Sass processing

```{warning}
Some feature are not yet released.
```

## Scss/Sass processing

Igloo provides tools to perform Scss/Sass processing:

* `de.larsgrefer.sass:sass-embedded-host` dependency is used for
  scss processing. It is a wrapper for dart-sass implementation:
  https://sass-lang.com/dart-sass
* Igloo customization allows to use classpath lookup for scss
  resources: old-style (and deprecated) `$(scope-name)/...` URLs
  and `META-INF/resources/webjars/...` webjars URLs.
* `CachedScssServiceImpl` can be used to wrap `ScssServiceImpl`
  and perform scss cache handling (ehcache). It performs automatic
  expiration check to allow auto-refresh in development mode.
* `autoprefixer.enabled` configuration allows to perform autoprefixer
  processing after scss/sass processing; it can be disabled to save
  processing time.
* Inherit `ScssResourceReference` to implement your wicket stylesheet
  `ResourceReference`


## Build-time generation

`ScssServiceImpl` allows to use build-time generated asset to speed-up
application startup or response time.

`scss.static.enabled` configuration enables the usage of build-time static
resources. If the static resource is absent, runtime processing is performed.
If the static resource is present, it never expires. If `scss.static.enabled=false`
then static resource is ignored.

It expects static resources to be available in `igloo-static-scss/` classpath,
named from a md5 hexed hash of `package.ClassNameResourceReference:filename.scss`
string, with a `.css` extension.

You can use `ScssMain` java main program with `exec-maven-plugin` to generate
the expected files.

Here is an example. You need to customize scopes and target Scss files.

```xml
<plugin>
    <!-- generate SCSS at build-time; greatly speed-up application startup -->
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>exec-maven-plugin</artifactId>
    <executions>
        <execution>
            <id>generate-scss</id>
            <goals>
                <goal>java</goal>
            </goals>
            <phase>prepare-package</phase>
            <configuration>
                <mainClass>org.iglooproject.sass.cli.ScssMain</mainClass>
                <arguments>
                    <argument>--generation-path</argument>
                    <argument>${project.build.outputDirectory}</argument>
                    <argument>--scopes</argument>
                    <argument>core-bs5:igloo.bootstrap5.markup.html.template.css.bootstrap.CoreBootstrap5CssScope</argument>
                    <argument>--scopes</argument>
                    <argument>core-console:igloo.console.template.style.CoreConsoleCssScope</argument>
                    <argument>--scopes</argument>
                    <argument>core-fa:igloo.fontawesome.CoreFontAwesomeCssScope</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationadvanced.StylesScssResourceReference:styles.scss</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationbasic.StylesScssResourceReference:styles.scss</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.application.console.console.ConsoleScssResourceReference:console.scss</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.notification.NotificationScssResourceReference:notification.scss</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.application.console.consoleaccess.ConsoleAccessScssResourceReference:console-access.scss</argument>
                    <argument>org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationaccess.ApplicationAccessScssResourceReference:application-access.scss</argument>
                </arguments>
            </configuration>
        </execution>
    </executions>
</plugin>
```

## JSass / Dart-sass migration

JSass to dart-sass implies some scss changes:

* `webjars:/` urls need to be rewritten
* TODO WIP