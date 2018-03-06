Lucene - French analyzer
========================

Due to code refactor to eliminate duplicate code, some classes are renamed.

.. literalinclude:: scripts/lucene-replace.sh
  :language: bash


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
