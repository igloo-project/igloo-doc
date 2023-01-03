
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

```bash
IGLOO_MAVEN_VERSION=xxx
IGLOO_COMMONS_VERSION=xxx
# igloo-maven: just release

# igloo-commons
# update parent
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
# perform jgitflow release

# igloo-parent
# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
# perform jgitflow release
```

Once `igloo-maven` is released, dependants projects must be updated:

* `igloo-commons`

  * update `pom.xml`: parent version (plugins-all)
  * update `pom.xml`: `igloo.igloo-maven.version` property

* `igloo-parent`

  * update `pom.xml`: parent version (plugins-all)
  * update `igloo/igloo-parents/igloo-parent-maven-configuration-common/pom.xml`: parent version (plugins-all)
  * update `igloo/igloo-parents/igloo-parent-maven-configuration-core/pom.xml`: `igloo-maven.version` property

## Releasing igloo-commons

Once `igloo-commons` is released, dependants projects must be updated:

* `igloo-parent`

  * update `igloo/igloo-parents/igloo-parent-maven-configuration-core/pom.xml`: `igloo-commons.version` property

## Releasing org.iglooproject.webjars:boostrap4

Repository https://github.com/igloo-project/bootstrap4 is a lightweight wrapper to
repackage `org.webjars.npm:bootstrap` under a specific groupId/artifactId. This is
needed to allow embedding of different bootstrap version in the same igloo project
(needed if console is bootstrap 5 and application is still bootstrap 4).

If a new bootstrap version is needed, change project version and push modification on main branch. main branch is automatically published.

## Updating an igloo-based project

Once `igloo-parent` is released:

* `pom.xml`: parent version (igloo-parent-core-project)
* `pom.xml`: `igloo.version` property

## Release a backport

If you need to release a hotfix on a previously released version (adapt version numbers):

```bash
# Create a branch from the desired root version
git checkout -b ft-4.4-deploy v4.4.0
# Apply a new SNAPSHOT version
mvn versions:set versions:commit -DnewVersion=4.4.2-SNAPSHOT -DprocessAllModules=true
git commit -a -m "Prepare 4.4.2 backport release"
# Backport and commit your fixes (manually, cherry-pick, ...)
# you can publish this version if needed by pushing your branch to CI
[...]

# When your branch is OK, update your version
mvn versions:set versions:commit -DnewVersion=4.4.2 -DprocessAllModules=true
git commit -a -m "Release 4.4.2 backport"
git tag v4.4.2
git push origin ft-4.4-deploy
git push refs/tags/v4.4.2

# CI build for ft-4.4-deploy will publish your new release
# Branch ft-4.4-deploy can be removed once published (we only keep tag).
```
