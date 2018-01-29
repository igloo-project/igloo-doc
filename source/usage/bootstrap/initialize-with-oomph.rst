Initialize Eclipse workspace with Ooomph
========================================

Clone the igloo-oomph-project repository

.. code-block:: bash

   git clone git@github.com:igloo-project/igloo-oomph-project.git

Open Eclipse, use a new workspace.
Select File->Import->Oomph->Projects into workspace.
Click on the "+" button :

* Choose the catalog Eclipse Projects
* Browse file : choose the file git/igloo-oomph-project/org.iglooproject.eclipse.project.setup
* Check the box corresponding to the file you just add, and click next

In the window with required variables :

* Nom du clone git : the name of the file which will contain the git clone on your computer
* Nom du projet gitlab : the name of the project as it appears in gitlab or github
  (correspond to <project> in the url host:igloo-project/<project>.git)
* Branche : the branch which will be checkout
* Répertoire du tomcat : the path to your tomcat folder on your computer
* Nom du projet maven : the artifactId in your pom.xml
* Nom de la webapp : the name of the webapp which will be generated
* Url du dépôt
* If you use the other file you will have an other variable to fill named "Nom du groupe/compte. Enter here the name of the github group or account which host the repository."

Click next, then finish. The installation may take a few minutes, and Eclipse might
have to restart. In this case, the installation will go back to where it stopped
automatically. It will clone the application, install and set a Tomcat server.

.. warning:: If you perform some modifications that you have to push on the repository,
   don't push the file eclipse/tomcat85.launch if you didn't modify it manually.
