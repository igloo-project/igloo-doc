.. _migrating-to-java11:

====================
Migrating to java 11
====================

From version 2.X.X, Igloo is now build with Java 11. Here are some vigilance points to be aware of.


Java Version
============

First of all, you have to change java versions wherever it is used : IDE,
command prompt, CI...


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
