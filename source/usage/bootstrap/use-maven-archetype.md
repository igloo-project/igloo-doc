Build, deploy and exploit the Maven archetype
=============================================

To initialize a new project based on the basic-application, you have to follow several steps.
Each steps are detailed one by one in the following sections.


Build the archetype (optional)
------------------------------

.. note:: if archetype is available on Nexus repository, there is no need to build and publish it.

Place yourself in the folder igloo-parent/basic-application.

- to install the archetype locally:
```sh
./build-and-push-archetype.sh ../basic-application/ local
```

- to install the archetype on our repository:
```sh
./build-and-push-archetype.sh ../basic-application/ snapshot
```


Generate a new project
----------------------

Place yourself in a new folder or somewhere like /tmp/. This command will
generate a new folder where you are containing your new project.

using your local repository:
```sh
mvn archetype:generate -DarchetypeVersion=X.X -DarchetypeCatalog=local -DartifactId=your-artifact-id -DgroupId=your.group.id -Dversion=0.1-SNAPSHOT -Dpackage=com.your.package -DarchetypeApplicationNamePrefix="YourApplication" -DarchetypeSpringAnnotationValuePrefix="yourApplication" -DarchetypeFullApplicationName="Customer - Your application" -DarchetypeDatabasePrefix=c_database_prefix -DarchetypeDataDirectory=your-data-directory
```

using the snapshot repository:
```sh
mvn archetype:generate -DarchetypeCatalog=https://nexus.tools.kobalt-si.fr/repository/igloo-snapshots/ -DartifactId=your-artifact-id -DgroupId=your.group.id -Dversion=0.1-SNAPSHOT -Dpackage=com.your.package -DarchetypeApplicationNamePrefix="YourApplication" -DarchetypeSpringAnnotationValuePrefix="yourApplication" -DarchetypeFullApplicationName="Customer - Your application" -DarchetypeDatabasePrefix=c_database_prefix -DarchetypeDataDirectory=your-data-directory
```

using the release repository:
```sh
mvn archetype:generate -DarchetypeCatalog=https://nexus.tools.kobalt-si.fr/repository/igloo-releases/ -DartifactId=your-artifact-id -DgroupId=your.group.id -Dversion=0.1-SNAPSHOT -Dpackage=com.your.package -DarchetypeApplicationNamePrefix="YourApplication" -DarchetypeSpringAnnotationValuePrefix="yourApplication" -DarchetypeFullApplicationName="Customer - Your application" -DarchetypeDatabasePrefix=c_database_prefix -DarchetypeDataDirectory=your-data-directory
```


Push the new project
--------------------

Go in the newly generate folder containing your project and push it on gitlab :

```sh
/bin/bash init-git.sh <project_name> <git_url>
git push -u origin master
```

.. note:: please check issue|ci management and scm urls in root ``pom.xml``

/!\ After having push your project, delete the project folder and initialize a
new one directly from gitlab before starting your work.
