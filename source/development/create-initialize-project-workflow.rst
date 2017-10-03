Create, initialize and launch a project - Workflow
==================================================

In this page, we will follow the complete workflow to properly create a project, starting from nothing
to finally be able to run the project on a server.
In the following steps, we will call the project **hello-world**.

Clone the owsi-core-parent repository
-------------------------------------

First of all, clone the owsi-core-parent project :

.. code-block:: bash

  git clone git@github.com:openwide-java/owsi-core-parent.git


Generate the new project and push it on gitlab
----------------------------------------------

You can find a more detailed documentation of this part here_.

.. _here: use-maven-archetype.html

In order to generate the project, we need to build the archetype :

.. code-block:: bash

  cd ~/git/owsi-core-parent/basic-application
  ./build-and-push-archetype.sh ../basic-application/ local

After that, we place ourselves in /tmp and we generate the project :


.. code-block:: bash

  cd /tmp
  mvn archetype:generate -DarchetypeVersion=X.X -DarchetypeCatalog=local -DartifactId=hello-world -DgroupId=fr.hello.world -Dversion=0.1-SNAPSHOT -Dpackage=fr.hello.world -DarchetypeApplicationNamePrefix="HelloWorld" -DarchetypeSpringAnnotationValuePrefix="helloWorld" -DarchetypeFullApplicationName="Customer - Hello World" -DarchetypeDatabasePrefix=hello_world -DarchetypeDataDirectory=hello-world

The script asks what archetype we want to use, we choose the number corresponding
to local, and validate the different values we entered previously.

We go to the newly generated project folder and make an adjustment :
we add a line with the version of the owsi-core in the
file `hello-world/pom.xml` between the markers `properties`, just under the line
for the tomcat-jdbc.version :

.. code-block:: xml

  <properties>
		<!-- il est préférable de bien surcharger la version du pool jdbc Tomcat au niveau du projet en fonction de la version de Tomcat -->
		<tomcat-jdbc.version>${owsi-core.tomcat-jdbc.version}</tomcat-jdbc.version>
		<owsi-core.version>0.14-SNAPSHOT</owsi-core.version>
	</properties>

.. note::
  Note that here the version is the 0.14-SNAPSHOT because it is the latest version at the time.

After that, we push the project on gitlab by executing the script located in the project folder :

.. code-block:: bash

  /bin/bash init-gitlab.sh hello-world
  git push --set-upstream origin master

After pushing the project on gitlab, we have to delete the created folder and
start working with a fresh one.

.. code-block:: bash

  cd ..
  rm -rf hello-world/*

We will make a new clone of the project using Oomph in the next step.

Create a fresh clone and a properly configured workspace with Oomph
-------------------------------------------------------------------

You can find a more detailed documentation of this part in the dedicated `Oomph page`_.

.. _Oomph page: install-oomph.html

Open an Eclipse Neon and select a new and clean workspace. After that, we follow the
`Oomph page`_ documentation until we come to the window with multiple variables
to fill. We fill the window as follow :

* Nom du clone git : hello-world
* Choix du dépôt : Dépôt Gitlab
* Branche : master
* Répertoire du tomcat : ${user.home}/Documents/apps/apache-tomcat-7.0.53
* Nom du projet maven : ${gitlab.project.name}
* Nom de la webapp : ${gitlab.project.name}-webapp
* Nom du projet gitlab : hello-world

From here, we have a new project successfully created and pushed online, and a
properly configure workspace. The only thing left is the database.

Create and initialize the database
----------------------------------

You can find a more detailed documentation of this part in the `prerequisite` part of the `Project installation page`_.

.. _Project installation page: installation.html

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

.. note::
  Use the name of the project for the password (here: hello_world)

After that we have to enable an option which will allow our the project to create new entities in the database.
To do so, in the file `hello-world-core/src/main/filters/development.properties` we have to
switch the line **maven.hibernate.hbm2ddl.auto=none** to :

.. code-block:: xml

  maven.hibernate.hbm2ddl.auto=update

To make sure the new property is taken into account, we refresh the project (in Eclipse : menu Project -> Clean...).

Finally, we fill our database with the script HelloWorldInitFromExcelMain.java especially written for this.
We just right click on it in Eclipse and Run as Java Application.

Launch the project
------------------

Now we have all the tools properly configurated and ready to run our project. To do that,
we just start the server tomcat7 in Eclipse (if you don't have the server view : Window -> Show view -> Other -> Server/Servers).
To access to our project, we can go to http://localhost:8080/ .
To access the console, the address is http://localhost:8080/console/ .

.. note::
  Until you change it, the login/password for the project and the project's console is admin/admin.
