Database Scripts (from 0.14)
============================

.. _sql-update-script:

Model - Database comparisons
----------------------------

.. note:: ``*SqlUpdateScriptMain.java`` is named at project generation's time: for instance ``MyProjectSqlUpdateScriptMain.java``.

The class ``<Project>SqlUpdateScriptMain.java`` generates the differences between
your java model and your database model to write the result as an update sql script.
It can also generate an sql script for the creation of your whole database.

To launch this script, make sure you are in the ``basic-application/basic-application-init directory``, then execute

.. code-block:: bash

  mvn exec:java -Dexec.mainClass="org.iglooproject.basicapp.init.<Project>ApplicationSqlUpdateScriptMain" -Dexec.args="update stdout"

Available args are:

* `[update|create]`: compute create (from scratch) or update (from current situation) SQL script.
* `[stdout|filename]`: output script in console or in provided filename.
* By default, this command outputs update script on stdout

Igloo < 4.0.0
--------------

.. code-block:: bash

  mvn exec:java -Dexec.mainClass="org.iglooproject.basicapp.init.<Project>ApplicationSqlUpdateScriptMain" -Dexec.args="arg0 arg1"

You need to provide two arguments :
  - ``arg0`` is the mode of the script, you have the choice between ``create`` for generating your database's creation script, and ``update`` for generating the update of your database.
  - ``arg1`` is the path to the file which will contain the result script.


SqlUpdateScriptMain not available
---------------------------------

If you project does not supply ``*SqlUpdateScriptMain``, you can copy and rename the file from package ``org.iglooproject.basicapp.core.cli`` in you project and adapt them.
