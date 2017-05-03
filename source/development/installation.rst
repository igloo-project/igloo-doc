Project installation
==============================

Prerequisite
------------

To run the basic-application or any project that use the basic-application as an outline, you need to initialize a database.
To do so, you need to create a user first, and then create a database with the user you have created as its owner.

.. code-block:: bash

  createuser -U postgres -P basic_application
  createdb -U postgres -O basic_application basic_application

After that, you can populate your database with some date by running the class *BasicApplicationInitFromExcelMain.java* as a java application. This class is located in basic-application-init.
