.. _quick-initialization:

Init project
============

In this page, we will follow the complete workflow to properly create a project, starting from nothing
to finally be able to run the project on a server.
In the following steps, we will call the project **hello-world**.

Clone the igloo-parent repository
---------------------------------

First of all, clone the igloo-parent project :

.. code-block:: bash

  git clone git@github.com:igloo-project/igloo-parent.git


Generate the new project and push it on gitlab
----------------------------------------------

.. note:: You can find a more detailed documentation of this :ref:`part <more-about-maven-archetype>`.

In order to generate the project, we need to build the archetype :


.. code-block:: bash

  cd ~/git/igloo-parent/basic-application
  ./build-and-push-archetype.sh ../basic-application/ local

After that, in ``/tmp/<generated-hash>`` folder, we generate the project using maven archetype plugin:


.. code-block:: bash

  cd /tmp/<generated-hash>
  mvn archetype:generate -DarchetypeVersion=1.0 -DarchetypeCatalog=local -DartifactId=hello-world -DgroupId=fr.hello.world -Dversion=0.1-SNAPSHOT -Dpackage=fr.hello.world -DarchetypeApplicationNamePrefix="HelloWorld" -DarchetypeSpringAnnotationValuePrefix="helloWorld" -DarchetypeFullApplicationName="Customer - Hello World" -DarchetypeDatabasePrefix=hello_world -DarchetypeDataDirectory=hello-world


The script asks what archetype we want to use. Choose the number corresponding
to local, and check the different values we entered previously.

Go to the newly generated project folder and make this modification: add a line specifying Igloo's version in the
file `hello-world/pom.xml` between the markers `properties` :

.. code-block:: xml
  :emphasize-lines: 2

  <properties>
    <igloo.version>X.X-SNAPSHOT</igloo.version>
  </properties>

.. note:: **X.X-SNAPSHOT** must be replaced by the targetted version.

After that, push the project on git by executing the script located in the project folder :

.. code-block:: bash

  /bin/bash init-git.sh hello-world git@gitlab.tools.kobalt.fr:<group>/<project>.git
  git push -u origin master

After pushing the project on git, we have to delete the created folder and
start working with a fresh one.

.. code-block:: bash

  rm -rf /tmp/<generated-hash>/

We will make a new clone of the project using Oomph in the next step.


Create a fresh clone and a properly configured workspace with Oomph
-------------------------------------------------------------------

Open an Eclipse (> 4.7 Oxygen, last release preferred) and select a new and clean workspace.

After that, follow the :ref:`Oomph documentation <oomph-project-init>` until the window with multiple variables to fill in.

Here are the values to fill :

* Nom du clone git : ``hello-world``
* Url du dépôt: git url where project is pushed
* Branche : master
* Répertoire du tomcat : ${user.home}/Documents/apps/apache-tomcat-8.5.23; provide a folder where
  an Apache Tomcat binary distribution is unpacked.
* Nom du projet maven : hello-world
* Nom de la webapp : hello-world-webapp
* Nom du projet gitlab : hello-world

From here, follow the ending steps from :ref:`Oomph documentation <oomph-project-init>`.

Create and initialize the database
----------------------------------

In this part, we will create the database with the proper user and schema, and we will fill it with a script.
Before performing the following commands, make sure you have PostgreSQL installed.

To create the database, we execute some commands directly in a terminal:

.. code-block:: bash

  createuser -U postgres -P hello_world
  createdb -U postgres -O hello_world hello_world
  psql -U postgres hello_world
  #Here you are connected to the database as the user postgres
  DROP SCHEMA public;
  \q
  psql -U hello_world hello_world
  #Here you are connected to the database as the user hello_world
  CREATE SCHEMA hello_world;

.. note:: Use the name of the project for the password (here: hello_world)

After that we have to enable an option which will allow the project to create new entities in the database.


Create and initialize filesystem
--------------------------------

.. code-block:: bash

   sudo mkdir /data/services/basic-application
   sudo chown "${USER}." /data/services/basic-application


Launch the webapp
-----------------

Now we have all the tools properly configurated and ready to run our project.

To do that, we just start Tomcat in Eclipse (if you don't have the server view : **Window -> Show view -> Other -> Server/Servers**).

To access to our project, we can go to http://localhost:8080/basic-application .
To access the console, the address is http://localhost:8080/basic-application/console/ .

.. note:: Until you change it, the login/password for the project and the project's console is admin/admin.
