(igloo-logging)=

# Igloo logging (log4j2 JMX configuration)

`org.iglooproject.components:log4j2-jmx-helper` and `org.iglooproject.components:jul-helper` allow
to override log4j2 configuration at runtime (including not predefined loggers and JUL loggers,
contrary to log4j2 native JMX implementation).

Source code is hosted at https://github.com/igloo-project/igloo-logging/.

This modules do not rely on igloo framework and can be used independently of igloo.

## Prerequisites

Your projet must manage/include the following dependencies:

* `javax.servlet:javax.servlet-api`: javax package, only servlet listener API is used
* `org.slf4j:jul-to-slf4j`: 1.7.x or 2.0.x
* `org.slf4j:slf4j-api`: 1.7.x or 2.0.x
* `org.apache.logging.log4j:log4j-core`: 2.17+ version

Project uses only mainline API from these dependencies and may adapt to any recent version.

## Installation

Ensure you use Igloo maven repository: https://nexus.tools.kobalt.fr/repository/igloo-releases/.

Add `org.iglooproject.components:log4j2-jmx-helper` and `org.iglooproject.components:jul-helper`
to your project's dependencies.

Remove `org.iglooproject.components:igloo-component-jul-to-slf4j` as `jul-helper` handles
sl4j to JUL binding.

```xml
		<dependency>
			<groupId>org.iglooproject.components</groupId>
			<artifactId>jul-helper</artifactId>
			<version>1.0.1</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.iglooproject.components</groupId>
			<artifactId>log4j2-jmx-helper</artifactId>
			<version>1.0.1</version>
			<scope>runtime</scope>
		</dependency>

		<!-- check dependency tree for the following dependencies -->
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>jul-to-slf4j</artifactId>
		</dependency>
		<dependency>
			<groupId>org.apache.logging.log4j</groupId>
			<artifactId>log4j-core</artifactId>
		</dependency>
```

For a war project, use `web.xml` listeners to trigger JMX helper loading (you must replace
`org.iglooproject.slf4j.jul.bridge.SLF4JLoggingListener` if present):

```
	<listener>
		<listener-class>igloo.julhelper.servlet.JulLoggingListener</listener-class>
	</listener>
 	<listener>
		<listener-class>igloo.log4j2jmx.servlet.Log4j2LoggingManagerListener</listener-class>
	</listener>
```

Else you need to invoke `JulLoggingManagerMBean.registerMBean()` and
`Log4j2LoggingManagerMBean.registerMBean()`.

Jul helper must be initialized before Log4j2 helper.

## Usage

Your MBeans tree must show a new `igloo` subtree with two `type=LoggingManager` MBeans:

* JulLoggingManager
* Log4j2LoggingManager

`JulLoggingManager` is controlled by `Log4j2LoggingManager`. It is not needed to interact
directly with it.

Use an MBean browser (visualvm, jmxterm) to override your configurations at runtime. Any
modification performed is lost at application restart.

Here are examples for jmxterm:

```
# MBean selection
bean igloo:type=LoggingManager,name=Log4j2LoggingManager
# MBean operations/attributes
info
# Override a logger
run setLevel "org.apache.wicket" "debug"
# Loading a web page may trigger debug logs
run reset
# Logger level must be restore to its previous state
```

## JUL implementation

Specific code is needed to allow JUL reconfiguration at runtime, because `jul-to-slf4j`
performs log redirection at root level (default behavior in `SLF4JBridgeHandler.install()`).

It implies to configure JUL not to block any log record, so that they can fo to root logger,
so that `SLF4JBridgeHandler` can redirect it to log4j2. It implies a performance hit as
not wanted log record need to be processed.

A common caveat is that JUL must be configured for maximum verbosity. Else high verbosity
log records are discarded before `jul-to-slf4j` can redirect it.

JUL helper allow to automatically add and remove `SLF4JBridgeHandler` for the provided
logger name when log4j2 is reconfigured to address this issues.

jullKnownLoggers setting (can be configured at runtime with JMX, or at startup-time
with `JulLoggingListener` `julKnownLoggersResourcePath` servlet parameter) is used
to limit `SLF4JBridgeHandler` initialization.

Default configuration is located in `jul-helper/well-known-jul-loggers.txt` classpath
resource. By default, `SLF4JBridgeHandler` initialization is performed only for
logger (and sub loggers):

```
org.glassfish.jersey
com.google.common
```

## Project release

Use jgitflow procedure.

## Changelog

### 1.0.1 (10.02.2023)

* Fix a deployment issue

### 1.0.0 (10.02.2023)

* Initial release
* Use 1.0.1 that fixes a deployment issue

