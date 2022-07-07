# Processor

## Purpose

Some tools need code generation. `maven-processor-plugin` allows to configure code generation steps in maven building process. It is also possible to use `maven-compiler-plugin` for this usage : one downside of `maven-compiler-plugin` is that processing errors are harder to detect and understand, so we stick with maven-processor-plugin for the moment.

## How maven-processor-plugin is managed by Igloo

*maven-processor-plugin* configuration is managed by {igloo-maven}`plugins-processor.pom.xml` module. It is included in general purpose {igloo-maven}`plugins-all/pom.xml` module.

*maven-compiler-plugin* is configured with `-proc:none` argument, to ensure that it does not handle any code generation.

Key configurations for *org.bsc.maven:maven-processor-plugin* are:

* `<processors>${igloo.processors}</processors>`. *igloo.processors* must be a list of comma-`,` separated list of processor names. If *processors* configuration is not used, any processor on the classpath may be invoked; we prefer an explicit configuration.
* `releaseVersion` ensure that processor that may be affected by java version works with the right and expected java version.
* `-encoding ...` forces UTF-8 encoding. For java generation, it is the only sensible configuration. It may be problematic to generate non-ascii properties files.

Some processors need to be configured with system properties:

* `<querydsl.generatedAnnotationClass>javax.annotation.processing.Generated</querydsl.generatedAnnotationClass>` ensures that querydsl generation uses Java 9+ `Generated` annotation.

Code generation is split in two maven *execution*: main and test sources, respectively bound to *generate-sources* and *generate-test-sources* phases.

*plugins-processor* provides *igloo.processor.\** properties to ease processor configuration (no need to know full processor name, just remember bindgen, querydsl, immutables, ...).

## IDE integration

### Eclipse

Eclipse m2e + JBoss *Maven integration for Eclipse JDT APT Core* (org.jboss.tools.maven.apt.core) allow to handle code generation. It needs to override *Preferences > Maven > Annotation Processing* configuration and choose *Experimental: Delegate annotation processing to maven plugins*.

This configuration is handled by oomph igloo and project file.

### IntelliJ

IntelliJ natively supports maven processor configuration. Please note that it expects processor to be on the project classpath (Eclipse and Maven allow to declare processor dependency in the plugin classpath).

Igloo >= 4.0.0 is changed to use a configuration pattern to ease IntelliJ configuration.

## How to configure a project

### Igloo >= 4.0.0

Add the following configuration to your project:

```xml
<project>
    <properties>
        <!-- adapt processor list to your use case -->
        <igloo.processors>${igloo.processor.querydsl},${igloo.processor.bindgen}</igloo.processors>
    </properties>
    <dependencies>
        <!-- check processor configuration below to identify needed dependencies-->
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.bsc.maven</groupId>
                <artifactId>maven-processor-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
    <dependencyManagement>
        <dependencies>
            <!-- provides common processors versions -->
            <dependency>
                <groupId>org.iglooproject</groupId>
                <artifactId>dependencies-commons</artifactId>
                <version>${igloo-maven.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>
```

If you do not use processor, just drop these configurations.

### Igloo < 4.0.0

For Igloo < 4.0.0, adding the following plugin definition enable immutables/querydsl/bindgen generation.

```xml
<project>
    <build>
        <plugins>
            <plugin>
                <groupId>org.bsc.maven</groupId>
                <artifactId>maven-processor-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

For Maven/Eclipse build, processors are included in plugin dependencies, so code generation can be handled without project classpath pollution.

For IntelliJ build, it is needed either to add processor dependencies in project (use a provided scope if dependency is not needed at runtime) or to reconfigure maven-processor-plugin to remove missing processors (*configuration>processors* node).

### Igloo < 3.3.0

Same as Igloo < 4.0.0, but immutables generation is missing.

(igloo4-maven-processor-plugin)=

## Igloo 4 migration guide

This quick guide may handle common cases: apply this this changes **only** when `org.bsc.maven:maven-processor-plugin` is part of module's plugins list. Generally, it is needed both on core and webapp modules.

```xml
<project>
    <properties>
        <!-- pick the appropriate config -->
        <!-- core-style processor list -->
        <igloo.processors>${igloo.processor.querydsl},${igloo.processor.bindgen}</igloo.processors>
        <!-- webapp-style processor list -->
        <igloo.processors>${igloo.processor.bindgen}</igloo.processors>
    </properties>
    <dependencies>
        <!-- ensure processor dependencies are present when processor is listed -->
        
        <!-- bindgen dependencies -->
        <dependency>
            <groupId>org.bindgen</groupId>
            <artifactId>bindgen</artifactId>
        </dependency>
        <dependency>
            <groupId>org.iglooproject.components</groupId>
            <artifactId>bindgen-functional</artifactId>
            <version>${igloo-commons.version}</version>
        </dependency>

        <!-- querydsl dependencies -->
        <dependency>
            <groupId>com.querydsl</groupId>
            <artifactId>querydsl-apt</artifactId>
            <classifier>jpa</classifier>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>com.querydsl</groupId>
            <artifactId>querydsl-jpa</artifactId>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.bsc.maven</groupId>
                <artifactId>maven-processor-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
    <dependencyManagement>
        <dependencies>
            <!-- ensure this dependencyManagement is present -->
            <dependency>
                <groupId>org.iglooproject</groupId>
                <artifactId>dependencies-bindgen</artifactId>
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
</project>
```

For uncommon usecase, querydsl or bindgen processing may be removed from above configuration.

## Processors

```{note}
This part provides only processor-specific configuration. Check the above configuration to enable code generation.
```

### Bindgen

Bindgen is responsible of *\*Binding* and *\*BindingPath* generation. Processor name is available with `${igloo.processor.bindgen}` property. Bindgen jar provides both generation and runtime code, so dependency must be installed with *compile* scope (default scope).

Bindgen can be configured with a `bindgen.properties` file (located at the module's root path) to customize:

* generation scope and exclusions
* custom parent class for generated bindings

Here's a sample file:

```xml
# keep java.util and java.lang in the list, so that we have IntegerBinding, LongBinding and not GenericObjectBindingPath for fields
# adapt first package scope
scope=org.iglooproject,java.util,java.lang
skipBindKeywork=true
# customize binding parent so that it implements SerializableFunction2
bindingPathSuperClass=org.iglooproject.commons.util.binding.AbstractCoreBinding
```

All Igloo code and project code use the superclass customization to ease wicket and binding interactions.

*pom.xml* configuration must be adapted from this sample:

```xml
<project>
    <properties>
        <igloo.processors>${igloo.processor.bindgen}</igloo.processors>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.bindgen</groupId>
            <artifactId>bindgen</artifactId>
        </dependency>
        <!-- for custom superclass -->
        <dependency>
            <groupId>org.iglooproject.components</groupId>
            <artifactId>bindgen-functional</artifactId>
            <version>${igloo-commons.version}</version>
        </dependency>
    </dependencies>
</project>
```

It is used by {igloo-parent}`igloo/igloo-components/igloo-component-jpa/pom.xml` and *\*-core* module in projects.

### QueryDSL

QueryDSL is responsible for *QEntity* generation.

*pom.xml* configuration must be adapted from this sample:

```xml
<project>
    <properties>
        <igloo.processors>${igloo.processor.querydsl}</igloo.processors>
    </properties>
    <dependencies>
        <dependency>
            <groupId>com.querydsl</groupId>
            <artifactId>querydsl-apt</artifactId>
            <classifier>jpa</classifier>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>com.querysql</groupId>
            <artifactId>querydsl-jpa</artifactId>
        </dependency>
    </dependencies>
</project>
```

It is used by {igloo-parent}`igloo/igloo-components/igloo-component-jpa/pom.xml` and *\*-core* module in projects.

### Immutables

Immutables allows to generate builders for immutables POJO.

```xml
<project>
    <properties>
        <igloo.processors>${igloo.processor.immutables}</igloo.processors>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.immutables</groupId>
            <artifactId>value</artifactId>
            <scope>provided</scope>
        </dependency>
    </dependencies>
</project>
```

It is used by {igloo-parent}`igloo/igloo-components/igloo-component-jpa-more/pom.xml` to handle `TaskManagement`/`ImmutableTaskManagement` builder.

### spring-context-indexer

This processor generates a `META-INF/spring.components` that is an index of spring annotation in the current module. It allows Spring to manage classpath scanning more efficiently (only indexes are parsed, and not the full classpath).

It is a all-or-nothing mechanism. If a *spring.components* file exists, then no classpath scanning is done. Spring can be forced to perform classpath scanning (and ignore index files) with system property `spring.index.ignore=true`.

```xml
<project>
    <properties>
        <igloo.processors>${igloo.processor.spring}</igloo.processors>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context-indexer</artifactId>
            <scope>optional</scope>
        </dependency>
    </dependencies>
</project>
```

```{warning}
This processor is not yet used as it triggers build discrepancies for Maven and Eclipse:

* This plugin uses `classes/` output folder (as generated file is not a source to be compiled but a file to include in jar)
* Eclipse incorrectly manage this generated file. It is supposed that as it is not generated by Eclipse, it can remove this file during project cleaning/building
* Eclipse correctly manage this generated file if output folder is set `generated-sources/apt` (`<outputClassDirectory>${project.build.directory}/generated-sources/apt</outputClassDirectory>`)
* But with this setting, Maven does not include the generated file in jar file (as this folder is a source file, and is only meant to contain .java files to be compiled)
```

### Spring boot autoconfiguration support

To allow spring boot to perform autoconfiguration, it is needed to generate a `spring-autoconfigure-metadata.properties` that describes applied spring boot autoconfiguration annotations (AutoConfigureAfter, AutoConfigureBefore, ConditionalOn)