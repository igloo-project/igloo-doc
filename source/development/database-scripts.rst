Database Scripts (from 0.14)
============================

Model - Database comparisons
----------------------------

.. note:: ``*SqlUpdateScriptMain`` is named at project generation's time: for example ProjectSqlUpdateScriptMain.

The script *<Project>SqlUpdateScriptMain.java* can generates the differences between
your java model and your database and write the result as an update sql script (update of your database).
It can also generate an sql script for the creation of your whole database.

To launch this script, make sure you are in the basic-application/basic-application-init directory, then execute

.. code-block:: bash

  mvn exec:java -Dexec.mainClass="fr.openwide.core.basicapp.init.BasicApplicationSqlUpdateScriptMain" -Dexec.args="arg0 arg1"

You have to provide two arguments :
  - arg0 is the mode of the script, you have the choice between **create** for generating your database's creation script, and **update** for generating the update of your database.
  - arg1 is the file which will contain the result script.


BasicApplicationSqlUpdateScriptMain not available
-------------------------------------------------

If you project does not supply ``*SqlUpdateScriptMain``, you can copy and rename the file *BasicApplicationSqlUpdateScriptMain.java* in you project.
Inside this file, you just have to replace **BasicApplication** by the name of your project in the line :

.. code-block:: java

  context = new AnnotationConfigApplicationContext(BasicApplicationInitConfig.class);
