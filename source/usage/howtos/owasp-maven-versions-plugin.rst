Owasp Dependency-Check - Versions maven plugin
==============================================

Since version 1.24 you have some reporting tools for maven dependencies and plugins.

Owasp Dependency-Check
----------------------

Owasp Dependency-Check is a utility that identifies project dependencies
and checks if there are any known, publicly disclosed, vulnerabilities.

Its maven profile is defined in both pom.xml and igloo/igloo-parents/igloo-parent-maven-configuration-common/pom.xml.

To run the dependency-check, use the option ``owasp.enabled``. For example you can launch :

.. code-block:: bash

  mvn -Dowasp.enabled=true -U -DskipTests clean install site:site

After running your command, you can read the report in *project-name/target/site/dependency-check-report.html*.

The dependency check may sometimes identify irrelevants vulnerabilities. To suppress them,
copy the xml generated in the report, and add it in both files owasp-suppressions.xml.

Versions maven plugin
---------------------

The versions maven plugin is used when you want to manage the versions of artifacts in a project's POM.
We use it exclusively for its reporting goals.

Its maven profile is defined in both pom.xml and igloo/igloo-parents/igloo-parent-maven-configuration-common/pom.xml.

To run the versions maven plugin, use the option ``update-report.enabled``. For example you can launch :

.. code-block:: bash

  mvn -Dupdate-report.enabled=true -U -DskipTests clean install site:site && mvn -Dupdate-report.enabled=true site:stage

When the command has ended (it can take a while), you can find the reports in *project-name/target/site/index.html*.
