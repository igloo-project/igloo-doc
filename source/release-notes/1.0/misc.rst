DataUpgrade
===========

DataUpgrade are no longer stored as a ``parameter``/``property``. A new
entity ``DataUpgradeRecord`` is created.

To prepare a migration :

* ensure that all your upgrade are done

* create new ``DataUpgradeRecord`` table :

.. code-block:: sql

  CREATE SEQUENCE DataUpgradeRecord_id_seq start 1 increment 1;
  CREATE TABLE DataUpgradeRecord (id int8 NOT NULL, autoPerform boolean NOT NULL, done boolean NOT NULL, executionDate timestamp, name text NOT NULL, primary key (id));
  CREATE TABLE DataUpgradeRecord ADD constraint UK_6q54k3x0axoc3n8ns55emwiev UNIQUE (name);

With this migration plan; you'll keep your old upgrade information in
``parameter`` table. New DatabaseUpgradeRecord will be stored in the dedicated
new table.

.. warning::
  Beware that old DataUpgrade are going to be listed as runnable ones in
  administration console, as ``DatabaseUpgradeRecord`` is empty and entries in
  ``parameter`` ignored. Either drop your old upgrades in
  ``DataUpgradeManagerImpl.listDataUpgrades()`` or migrate ``parameter``
  entries to ``DataUpgradeRecord``.

The following script should handle data upgrade migration to ``DataUpgradeRecord`` :

.. code-block:: sql

  INSERT INTO DataUpgradeRecord (id, autoperform, done, executiondate, name)
      SELECT nextval('dataupgraderecord_id_seq'), false, stringvalue::boolean, now(), regexp_replace(name, 'dataUpgrade.', '')
      FROM parameter WHERE name ~ '^dataUpgrade\..*(?<!\.autoperform)$';

Once you have checked that DataUpgradeRecord contains every previously executed data upgrade,
you can remove old values from the ``parameter`` table.

Lucene - French analyzer
========================

Due to code refactor to eliminate duplicate code, some classes are renamed.

.. literalinclude:: scripts/lucene-replace.sh
  :language: bash

.. warning::
  ``org.iglooproject.spring.util.lucene.search.LuceneUtils.toFilterRangeQuery(...)``
  is modified to throw an exception when min and max are null (previously, it
  silently returned ``null``).

SLF4JLoggingListener
====================

Renamed from ``org.iglooproject.commons.util.logging.SLF4JLoggingListener``
to ``org.iglooproject.slf4j.jul.bridge.SLF4JLoggingListener``.

.. literalinclude:: scripts/slf4j-replace.sh
  :language: bash

Commons split
=============

igloo-component-commons is split in several package.

.. literalinclude:: scripts/commons-replace.sh
  :language: bash

Javascript libraries
====================

Here is the list of removed obsolete javascript libraries, code is available in git history :

* jstree

ICloneable<T>
=============

``Object.clone`` use is discouraged. This interface, barely used, is removed.

Tests infrastructure
====================

Test classes has been moved to separate modules. To keep using this classes, your
core ``pom.xml`` should have the following dependencies :

.. code-block:: xml

  <dependency>
  	<groupId>org.iglooproject.dependencies</groupId>
  	<artifactId>igloo-dependency-test</artifactId>
  	<scope>test</scope>
  	<type>pom</type>
  </dependency>

  <dependency>
  	<groupId>org.iglooproject.components</groupId>
  	<artifactId>igloo-component-jpa-test</artifactId>
  	<version>${igloo.version}</version>
  	<scope>test</scope>
  </dependency>

Previous test dependencies (``junit``, ``spring-test``) are now provided by the
new modules and can be removed ``pom.xml`` if needed.
