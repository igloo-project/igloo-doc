Install an Oomph project
=========================

In the git folder, clone the owsi-tools-oomph repository

.. code-block:: bash

   git clone git@github.com:openwide-java/owsi-oomph-project.git

Open Eclipse, use a new workspace.
Select File->Import->Oomph->Projects into workspace.
Click on the "+" button :

* Choose the catalog Eclipse Projects
* Browse file : choose the file git/owsi-oomph-project/fr.openwide.core.eclipse.project.setup (choose the other file if your project is not in the github group openwide-java or in the openwide gitlab)
* Check the box corresponding to the file you just add, and click next

In the window with required variables :

* Nom du clone git : the name of the file which will contain the git clone on your computer
* Nom du projet gitlab : the name of the project as it appears in gitlab or github
  (correspond to <project> in the url git.projects.openwide.fr:open-wide/<project>.git)
* Branche : the branch which will be checkout
* Répertoire du tomcat : the path to your tomcat folder on your computer
* Nom du projet maven : the artifactId in your pom.xml
* Nom de la webapp : the name of the webapp which will be generated
* Choix du dépôt : if your application is host in github choose Dépot Github,
  otherwise if your application is host on gitlab choose Dépôt Gitlab. The default value is the gitlab repository.
* If you use the other file you will have an other variable to fill named "Nom du groupe/compte. Enter here the name of the github group or account which host the repository."

Click next, then finish. The installation may take a few minutes, and Eclipse might
have to restart. In this case, the installation will go back to where it stopped
automatically. It will clone the application, install and set a Tomcat server.

.. warning:: If you perform some modifications that you have to push on the repository,
   don't push the file eclipse/tomcat7.launch if you didn't modify it manually.
