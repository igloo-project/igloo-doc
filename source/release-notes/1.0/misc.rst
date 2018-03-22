DataUpgrade
===========

DataUpgrade are no longer stored as a ``parameter``/``property``. A new
entity ``DataUpgradeRecord`` is created.

To prepare a migration :

* ensure that all your upgrade are done

* create new ``DataUpgradeRecord`` table :

  .. code-block:: sql

    create sequence DataUpgradeRecord_id_seq start 1 increment 1;
    create table DataUpgradeRecord (id int8 not null, autoPerform boolean not null, done boolean not null, executionDate timestamp, name text not null, primary key (id));
    alter table DataUpgradeRecord add constraint UK_6q54k3x0axoc3n8ns55emwiev unique (name);

With this migration plan; you'll keep your old upgrade information in
``parameter`` table. New DatabaseUpgradeRecord will be stored in the dedicated
new table.

.. warning::
  Beware that old DataUpgrade are going to be listed as runnable ones in
  administration console, as ``DatabaseUpgradeRecord`` is empty and entries in
  ``parameter`` ignored. Either drop your old upgrades in
  ``DataUpgradeManagerImpl.listDataUpgrades()`` or migrate ``parameter``
  entries to ``DataUpgradeRecord``.

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
