
(maven-revision)=

# Maven : switch to CI-friendly ${revision} versioning

The following changes bring enhancements:

* commits for release process are shorter (only one file is modified)
* version can be switched faster (only one location to modify)
* pom inheritance is simpler : all project poms inherit from project's
  root pom
* APPLICATION-app can inherit properties and dependency management from
  project's root pom

## Switch project to ${revision}

* Replace `1.0-SNASPHOT` in following blocks with you project version
* Find all version occurrences
  
  ```shell
  grep -r 1.0-SNAPSHOT --include pom.xml --exclude-dir target
  ```
* Replace with `${revision}`
* Add `revision` definition in you root pom:

  ```xml
  <properties>
    <revision>1.0-SNAPSHOT</revision>
  </properties>
  ```

## Replace spring-boot-starter-parent artifact

* Find pom files using `spring-boot-starter-parent`:

  ```shell
  grep -r spring-boot-starter-parent --exclude-dir target --include pom.xml
  ```
* For each listed file: replace spring-boot-starter-parent parent declaration:

  From
  ```xml
  <parent>
    <groupId>org.iglooproject</groupId>
    <artficatId>spring-boot-starter-parent</articfactId>
    <version>IGLOO_VERSION</version>
    <relativePath /> <!-- lookup parent from repository -->
  </parent>
  ```

  To (replace GROUP_ID and ARTIFACT_ID with values for you project, see root pom)
  ```xml
  <parent>
    <groupId>GROUP_ID</groupId>
    <artifactId>ARTIFACT_ID</artifactId>
    <version>${revision}</version>
  </parent>
  ```
* For each listed file: remove `<version>1.0-SNASPHOT</version>` declaration (project -> version) (can be inherited from parent)
* For each listed file: remove `<groupId>...</groupId>` declaration (project -> groupId) (can be inherited from parent)
* For each listed file: remove `<java.version>...</java.version>` property declaration if present
* For each listed file: remove property declaration *already defined in root pom* `<properties>...</properties>`
  (keep start-class, remove igloo-maven.version)
* For each listed file: remove `<repositories>...</repositories>`
* For each listed file: remove `<distributionManagement>...</distributionManagement>`
* For each listed file: remove any item that can be inherited from root pom

## Validation

Perform a project build and check that application can be started.