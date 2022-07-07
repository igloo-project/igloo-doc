# Dependencies patterns

(igloo4-dependencies-migration-guide)=

## Igloo 4.0.0 dependency migration guide

This guides provides easy to apply dependency replacement for common use-cases. Just substitute removed dependencies with the provided blocks, then clean any duplicates.

### Check javax.annotation dependency

Use dependency hierarchy to ensure that `javax.annotation:javax.annotation-api` dependency is added to your core and webapp project. If not, add this dependency declaration:

```xml
<dependencies>
    <dependency>
        <groupId>javax.annotation</groupId>
        <artifactId>javax.annotation-api</artifactId>
        <scope>provided</scope>
    </dependency>
</dependencies>
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-commons</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

Without this dependency, `@Resource` annotations are not handled correctly and Spring managed fields may be unexpectedly null.

### igloo-component-\*

With Igloo 4.0.0, Maven complains that version is missing for *igloo-component-\** artifacts. It is now mandatory to declare *igloo-component-\** version. Just add `<version>${igloo.version}</version>` to dependency declaration.

Examples: `igloo-component-wicket-more-test`, `igloo-component-jpa-more-test`, ...

### org.iglooproject.components:igloo-components

**Remove** this dependency when encountered.

```xml
<dependency>
    <groupId>org.iglooproject.components</groupId>
    <artifactId>igloo-components</artifactId>
    <version>${igloo.version}</version>
    <type>pom</type>
</dependency>
```

### igloo-component-wicket-bootstrap4

**Add** this dependency into your webapp project.

```xml
<dependencies>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-wicket-bootstrap4</artifactId>
        <version>${igloo.version}</version>
    </dependency>
</dependencies>
```

### igloo-component-config-test

Add `igloo-component-config-test` to your core project. Despite its name, it provides mandatory default configuration.

```xml
<dependencies>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-config-test</artifactId>
        <scope>runtime</scope>
        <version>${igloo.version}</version>
    </dependency>
</dependencies>
```

### igloo-package-core-spring-jpa-app

Replace `igloo-package-core-spring-jpa-app` by the following configuration.

```xml
<dependencies>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-spring</artifactId>
        <version>${igloo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-jpa-more</artifactId>
        <version>${igloo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-jpa</artifactId>
        <version>${igloo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-jpa-security</artifactId>
        <version>${igloo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.springframework.security</groupId>
        <artifactId>spring-security-core</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.security</groupId>
        <artifactId>spring-security-acl</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.security</groupId>
        <artifactId>spring-security-config</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-core</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-beans</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context-support</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-aop</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-tx</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-expression</artifactId>
    </dependency>
</dependencies>
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-spring</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-hibernate</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### igloo-dependency-test

Replace `igloo-dependency-test` by the following configuration.

```xml
<dependencies>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.mockito</groupId>
        <artifactId>mockito-core</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.assertj</groupId>
        <artifactId>assertj-core</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.assertj</groupId>
        <artifactId>assertj-guava</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-test</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-testing</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

You can drop h2 database driver for project that uses only PostgreSQL.

### igloo-dependency-core-logging-log4j2

Replace `igloo-dependency-core-logging-log4j2` by the following configuration.

```xml
<dependencies>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
    </dependency>
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-core</artifactId>
        <scope>runtime</scope>
    </dependency>
</dependencies>
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-logging</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### igloo-package-web-wicket-app

Replace `igloo-package-web-wicket-app` by the following configuration.

```xml
<dependencies>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-wicket-more</artifactId>
        <version>${igloo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-jul-to-slf4j</artifactId>
        <version>${igloo.version}</version>
    </dependency>
</dependencies>
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-wicket</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### igloo-package-web-spring-security

Replace `igloo-package-web-spring-security` by the following configuration.

```xml
<dependencies>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-component-web-security</artifactId>
        <version>${igloo.version}</version>
    </dependency>
</dependencies>
```

### Missing Igloo classes

With *igloo-commons* split, some classes can be missing, so it will be needed to add when adequate:

```xml
<dependencies>
    <!-- pick only needed dependencies -->
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-validator</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>bindgen-functional</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-batch-api</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-bean-api</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-collections</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-context</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-lang</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-security-api</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
    <dependency>
        <groupId>org.iglooproject.components</groupId>
        <artifactId>igloo-context</artifactId>
        <version>${igloo-commons.version}</version>
    </dependency>
</dependencies>
```

### Missing version for non-igloo dependency

Check if the version definition is available in one of this module:

* {igloo-maven}`dependencies-bindgen/pom.xml`
* {igloo-maven}`dependencies-commons/pom.xml`
* {igloo-maven}`dependencies-hibernate-search/pom.xml`
* {igloo-maven}`dependencies-hibernate/pom.xml`
* {igloo-maven}`dependencies-html/pom.xml`
* {igloo-maven}`dependencies-jersey2/pom.xml`
* {igloo-maven}`dependencies-logging/pom.xml`
* {igloo-maven}`dependencies-quality-annotations/pom.xml`
* {igloo-maven}`dependencies-spring/pom.xml`
* {igloo-maven}`dependencies-testing/pom.xml`
* {igloo-maven}`dependencies-tools/pom.xml`
* {igloo-maven}`dependencies-wicket/pom.xml`

If the version is available, then update add this dependency in your pom.xml:

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.iglooproject</groupId>
            <artifactId>dependencies-REPLACEME</artifactId>
            <version>${igloo-maven.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### Check dependency scopes

In your `pom.xml` (all modules), check that:

* All `-test` artifacts are with `<scope>test</scope>` (except `igloo-component-config-test`)
* Following artifacts are `<scope>provided</scope>`: `javax.annotation-api`, `javax.servlet-api`

### Check maven build

Launch a command-line build `mvn clean install` and pay attention to any warning on duplicate or broken dependency configuration. Remove or fix issues.

## Compare old and new dependencies

Once you project can be built, checkout your old code in a separate folder and compare your dependency list:

```
# adapt basic-application-webapp with your webapp module name
cd old-folder
mvn clean install -DskipTests
mvn dependency:list --batch-mode -pl :basic-application-webapp "-DoutputFile=$PWD/deps.txt" -Dsort=true -DincludeScope=runtime -DincludeTypes=jar
cut -d: -f 1-3 $PWD/deps.txt > $PWD/deps2.txt

cd new-folder
mvn clean install -DskipTests
mvn dependency:list --batch-mode -pl :basic-application-webapp "-DoutputFile=$PWD/deps.txt" -Dsort=true -DincludeScope=runtime -DincludeTypes=jar
cut -d: -f 1-3 $PWD/deps.txt > $PWD/deps2.txt

vimdiff old-folder/deps2.txt new-folder/deps2.txt
```

Normal difference are:

* test dependencies are correctly removed from dependencies (this test only check runtime dependencies) (junit, mockito, hamcrest, ...)
* `org.iglooproject.components:igloo-\*` are added (new module from commons split)
* dropped `org.iglooproject.components:igloo-component-commons` is removed
* useless `net.java.truecommons:truecommons-key-swing` is removed
* useless `org.springframework:spring-jcl` is removed

### Other issues

Just ask for help!
