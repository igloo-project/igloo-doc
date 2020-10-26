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

* bindgen
* bindgen-bindings-java
* bindgen-java
* maven-processor-plugin
* jersey

Be careful with these if you have one of them in a custom version.

Jersey
======

Jersey has been updated from jersey-spring3 to jersey-spring5. This update had several effects :

* Jersey do not longer repackage guava, so you have to refactor your ``jersey.repackaged`` imports
  if you have some and directly import guava.
* Due to some version conflicts with ``jackson-module-jaxb-annotations`` and ``hk2-utils/runlevel``,
  ``jakarta-xml-bind-api``, ``jakarta-activation-api`` and ``jakarta-annotation-api``
  versions are now manually declared.
