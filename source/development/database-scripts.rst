Database Scripts
==================

Model - Database comparisons
----------------------------

The script *BasicApplicationSqlUpdateScriptMain.java* can generates the differences between
your java model and your database and write the result as an update sql script (update of your database).
It can also generate an sql script for the creation of your whole database.

To launch this script, make sure you are in the basic-application/basic-application-init directory, then execute

.. code-block:: bash

  mvn exec:java -Dexec.mainClass="fr.openwide.core.basicapp.init.BasicApplicationSqlUpdateScriptMain" -Dexec.args="arg0 arg1"

You have to provide two arguments :
  - arg0 is the mode of the script, you have the choice between **create** for generating your database's creation script, and **update** for generating the update of your database.
  - arg1 is the file which will contain the result script.
