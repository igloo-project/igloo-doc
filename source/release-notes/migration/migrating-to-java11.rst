.. _migrating-to-java11:

==================================
Migrating to Java 11 / Servlet 4.0
==================================

From version 3.0.0, Igloo is now build with Java 11. Igloo also uses API Servlet version 4.0 and it will lead to encoding character issues.
Here are some vigilance points to be aware of.


Servlet Version
===============

Before version 4.0, the character encoding was set by default. Now, it can be customised ; but it needs to be specified manually.
If a character encoding is not specified, the Servlet specification requires that an encoding of ``ISO-8859-1`` is used.

To use ``UTF-8`` in your project :

* Update the **xsi:schemaLocation** and the **version** in ``web.xml`` :

  .. code::

	<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_4_0.xsd"
          version="4.0" metadata-complete="true">

* Add **<request-character-encoding>UTF-8</request-character-encoding>** in ``web.xml``


Java Version
============

Java 11+ is mandatory for building and running Igloo projects. Update :

* Your IDE setting
* Your Tomcat configuration (Tomcat 9 required) to run with Java 11
* Your maven setting (``JAVA_HOME=/usr/lib/jvm/java-11/ mvn``)
* Your runtime environment (ensure ``JAVA_HOME`` environment setting for your tomcat runtime)
* Your CI settings (JAVA_HOME, docker image, ...)


Update your project
===================

* Update parent pom version
* Update ``igloo.version`` property
* fix broken imports

  * fix wrong imports of ``jersey.repackaged`` replaced with ``com.google...``
  * ``de.schlichtherle``/``TFile`` replaced with ``net.java.truevfs...``

* optional - Apache POI: remove ``setCellType`` calls (setCellValue automatically override type)
* optional - Java: replace ``Class.newInstance()`` by ``Class.getConstructor().newInstance()`` and
  add ``InvocationTargetException | NoSuchMethodException | IllegalArgumentException`` to the
  existing catch block

* replace ``lifecycle-mapping`` maven plugin configuration (used to control how eclipse maps
  maven plugin lifecycle to eclipse build) by ``<?m2e ...>`` XML processing instruction
  (see https://www.eclipse.org/m2e/documentation/release-notes-17.html#new-syntax-for-specifying-lifecycle-mapping-metadata)
  This instruction may be added at ``<plugin>`` or ``<execution>`` level


Maven plugins
=============

Compiler and processor plugin uses ``--release`` option to force java 11 usage. Check you do not
override these setttings.


Dependencies
============

Several dependencies have been updated to Java 11-mandatory versions :

* bindgen : expected >= 5.0.0
* bindgen-bindings-java : expected >= 2.0.0
* bindgen-java : expected >= 2.0.0
* maven-processor-plugin : expected >= 4.4
* jersey : expected >= 2.32
* querydsl : expected >= 5.0.0

Be careful with these if you have one of them in a custom version.


Jersey
======

Jersey has been updated from jersey-spring3 to jersey-spring5. This update had several effects :

* Jersey do not longer repackage guava, so you have to refactor your ``jersey.repackaged`` imports
  if you have some and directly import guava.
* Due to some version conflicts with ``jackson-module-jaxb-annotations`` and ``hk2-utils/runlevel``,
  ``jakarta-xml-bind-api``, ``jakarta-activation-api`` and ``jakarta-annotation-api``
  versions are now manually declared.


javax.annotations
=================

From Java 9, ``javax.annotation`` is reworked.

* ``javax.annotation`` linked to injection management (@PostConstruct, @Managed) are moved
  in an external dependency, ``javax.annotation:javax.annotation-api``. In Igloo context, this
  dependency is used when Spring beans are managed via ``javax.annotation`` annotations.
* JSR 305 ``javax.annotation`` are removed (@Nonnull, ...); we use instead
  ``com.google.code.findbugs:jsr305`` dependency.
* ``javax.annotation.Generated`` is replaced by runtime-provided ``javax.annotation.processing.Generated``
  (updated bindgen version, querydsl 5.0.0 with custom configuration).

In your projects :

* If you encounter spring initialization problems with missing Spring beans, add a scope-provided
  ``javax.annotation:javax.annotation-api`` dependency (this dependency is provided by tomcat
  container).
* If you have ``javax.annotation.Generated`` references, regenerate code or search for an updated
  and ``javax.annotation.processing.Generated``-friendly dependency.
