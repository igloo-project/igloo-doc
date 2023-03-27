(scss)=

# Scss/Sass processing

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

(scss-build-time-generation)=

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

* Add `plugin` markup to your webapp `pom.xml`.
Here is an example, you need to customize scopes and target Scss files.

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

* Add `picocli` dependancy to your webapp `pom.xml` :

```xml
<!-- Only for packaging scss at build-time -->
<dependency>
  <groupId>info.picocli</groupId>
  <artifactId>picocli</artifactId>
  <optional>true</optional>
</dependency>
```

* Launch `mvn clean install -DskipTests` and check that scss files are correctly
generated

```bash
[INFO] --- exec-maven-plugin:3.1.0:java (generate-scss) @ basic-application-webapp ---
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationadvanced.StylesScssResourceReference:styles.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/c9aa9b01f1b948961aa50745ba2bdb12a45ca1f07fc9116c598807c004c9224a.css (12140 ms.)
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationbasic.StylesScssResourceReference:styles.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/05f150ec91c975a1ccc21ce410e0ea88e28c880a5eb74c5d932d8794a68a4b81.css (6770 ms.)
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.application.console.console.ConsoleScssResourceReference:console.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/f67eca564bdf215846e66fc79e903268ca9ce3079ebb25bdecbefcb562ca7a52.css (5441 ms.)
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.notification.NotificationScssResourceReference:notification.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/f9eaa28a16432525b6c155f9a48f8d53ad007f883d083aadcecb7f6aa02f91d9.css (1745 ms.)
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.application.console.consoleaccess.ConsoleAccessScssResourceReference:console-access.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/e11f85f307ccff1495e99fc939ce52558ee7843282f80c3af1d6346d490aea6c.css (4665 ms.)
Scss processing: org.iglooproject.basicapp.web.application.common.template.resources.styles.application.application.applicationaccess.ApplicationAccessScssResourceReference:application-access.scss -> /home/cbaffertbuivan/git/igloo-parent/basic-application/basic-application-webapp/target/classes/igloo-static-scss/f36f9ed59aea49965889043f1e368168d0165e3b4e60f213b76746af9abdabd2.css (4388 ms.)
Scss generation time: 35455 ms.

```

(scss-migration)=

## JSass / Dart-sass migration

JSass to dart-sass implies some scss changes:

* `webjars://` urls need to be rewritten:
  * `webjars://bootstrap:current/` -> `META-INF/resources/webjars/bootstrap/`
  * `webjars://bootstrap5-override/` -> `META-INF/resources/webjars/bootstrap5-override/`
* `$(scope-NAME)` must be followed by a `/`: `$(scope-core-fa)scss/core` -> `$(scope-core-fa)/scss/core` (previously, it was optional)
* `@import`-ed files must be `.scss` files
  * check that you have no `.css` file in project-webapp directory (except files in `errors/` folder)
  * if you have some `.css` files, check if you want to be included by scss processing (then proceed to rename) or if they are included / managed by browser (then `.css` extension can be kept)
* Launch your app :
  * Check that css files are correctly loaded
  * Visually check style of your app

```{note}

`jimportdiff` can handle tedious rewrite tasks (cf. {ref}`jimportdiff`).

Use jimportdiff dart-scss :

* scss: rename webjars URLs :
  * `webjars://*:current/` -> `META-INF/resources/webjars/*/`
  * `webjars://*` -> `META-INF/resources/webjars/*`
* scss: rename `$(scope-*)scss/core` -> `$(scope-*)/scss/core`


```bash
cd jimportdiff
pipenv --rm
pipenv install
pipenv shell
cd ../PROJECT
../jimport/jimportdiff dart-scss
```
