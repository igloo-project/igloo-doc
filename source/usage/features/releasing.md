
# Releasing

## Common operations

To perform a repository release, we use jgitflow tooling. Commands for are the following:

```
# Release
# Release branch creation (rl-...); Replace next development (-SNAPSHOT) proposition
mvn jgitflow:release-start
mvn -DskipTests -DnoDeploy jgitflow:release-finish

# Hotfix (from master)
mvn jgitflow:hotfix-start
mvn -DskipTests -DnoDeploy jgitflow:hotfix-finish

# For both cases
# Check pushed items (master, dev, tag); fix if needed
git push --all -n
git push --tags -n
# If OK, perform pushes
git push --all
git push --tags
```

## Releasing igloo-maven

Once `igloo-maven` is released, dependants projects must be updated:

* `igloo-commons`

  * update `pom.xml`: parent version (plugins-all)
  * update `pom.xml`: `igloo.igloo-maven.version` property

* `igloo-parent`

  * update `igloo/igloo-parents/igloo-parent-maven-configuration-common/pom.xml`: parent version (plugins-all)
  * update `igloo/igloo-parents/igloo-parent-maven-configuration-core/pom.xml`: `igloo-maven.version` property

## Releasing igloo-commons

Once `igloo-commons` is released, dependants projects must be updated:

* `igloo-parent`

  * update `igloo/igloo-parents/igloo-parent-maven-configuration-core/pom.xml`: `igloo-commons.version` property

## Updating an igloo-based project

Once `igloo-parent` is released:

* `pom.xml`: parent version (igloo-parent-core-project)
* `pom.xml`: `igloo.version` property