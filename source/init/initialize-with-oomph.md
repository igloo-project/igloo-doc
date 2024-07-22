(oomph-project-init)=

# Eclipse Oomph

```{warning}
Oomph is not yet available for Igloo 6.x.
```

Clone the igloo-oomph-project repository that provides the Oomph setup file.

```bash
git clone git@github.com:igloo-project/igloo-oomph-project.git
```

- Open Eclipse, use a new workspace.
- Select **File > Import > Oomph > Projects into workspace**.
- Click on the `+` (green icon, top-right) button :
- Choose the catalog Eclipse Projects
- Browse file : choose the file `git/igloo-oomph-project/org.iglooproject.eclipse.project.setup`
- Check the box **igloo simple project**

Check and complete the window with required variables:

- Nom du clone git : the name of the file which will contain the git clone on your computer
- Nom du projet gitlab : the name of the project as it appears in gitlab or github
  (correspond to \<project> in the url host:igloo-project/\<project>.git)
- Branche : the branch which will be cloned
- Répertoire du tomcat : the path to your tomcat folder on your computer
- Nom du projet maven : the artifactId in your pom.xml
- Nom de la webapp : the name of the webapp which will be generated
- Url du dépôt

Click next, then finish. The installation may take a few minutes, and Eclipse might
have to restart (keep an eye on the status bar at the bottom right; an blinking icon
may require a restart).

In this case, the installation will go back to where it stopped
automatically. It will clone the application, install and setup a Tomcat server.

Once the project initialized, a last restart is needed to fully initialize the Tomcat
run configuration.
