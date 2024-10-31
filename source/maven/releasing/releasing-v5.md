# Releasing Igloo 5

## Igloo

```{note}
Releasing can be performed only for `igloo-parent` if `igloo-maven` / `igloo-commons` are untouched.
Just set IGLOO_XXX_VERSION accordingly and start procedure at `igloo-parent` step.
```

Commands listed below allow for each Igloo sub-project to update igloo dependencies version, perform commit,
and push to repository. Release is performed by CI/CD.

### Release

```bash
IGLOO_MAVEN_VERSION=xxx
IGLOO_COMMONS_VERSION=xxx
IGLOO_PARENT_VERSION=xxx

###############
# igloo-maven #
###############

mvn jgitflow:release-start
mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin main dev v$IGLOO_MAVEN_VERSION

#################
# igloo-commons #
#################

# update parent
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven dependency"
# perform jgitflow release
mvn jgitflow:release-start
mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin main dev v$IGLOO_COMMONS_VERSION

################
# igloo-parent #
################

# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven and Commons dependencies"
# perform jgitflow release
mvn jgitflow:release-start
mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin master dev v$IGLOO_PARENT_VERSION

########################################
# Switch back to snapshot dependencies #
########################################

IGLOO_MAVEN_VERSION_SNAPSHOT=xxx-SNAPSHOT
IGLOO_COMMONS_VERSION_SNAPSHOT=xxx-SNAPSHOT

#################
# igloo-commons #
#################

git checkout dev
# update parent
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Switch back Igloo Maven to snapshot versions"
git push

################
# igloo-parent #
################

git checkout dev
# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Switch back Igloo Maven and Commons to snapshot versions"
git push
```

### Hotfix

```bash
IGLOO_MAVEN_VERSION=xxx
IGLOO_COMMONS_VERSION=xxx
IGLOO_PARENT_VERSION=xxx

IGLOO_MAVEN_VERSION_SNAPSHOT=xxx-SNAPSHOT
IGLOO_COMMONS_VERSION_SNAPSHOT=xxx-SNAPSHOT

###############
# igloo-maven #
###############

mvn jgitflow:hotfix-start
# git push -u origin hf-$IGLOO_MAVEN_VERSION

mvn -DskipTests -DnoDeploy jgitflow:hotfix-finish
git push origin main dev v$IGLOO_MAVEN_VERSION

#################
# igloo-commons #
#################

mvn jgitflow:hotfix-start
# git push -u origin hf-$IGLOO_COMMONS_VERSION

# update parent
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven dependency"

# update dev poms to hotfix version to avoid merge conflicts (Igloo sub-project)
git checkout dev
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Updating dev poms to hotfix version to avoid merge conflicts (Igloo sub-project)"

mvn -DskipTests -DnoDeploy jgitflow:hotfix-finish

# update develop poms back to pre merge state (Igloo sub-project)
git checkout dev
mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Updating develop poms back to pre merge state (Igloo sub-project)"

git push origin main dev v$IGLOO_COMMONS_VERSION

################
# igloo-parent #
################

mvn jgitflow:hotfix-start
# git push -u origin hf-$IGLOO_PARENT_VERSION

# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Update Igloo Maven and Commons dependencies"

# update dev poms to hotfix version to avoid merge conflicts (Igloo sub-project)
git checkout dev
# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Updating dev poms to hotfix version to avoid merge conflicts (Igloo sub-project)"

mvn -DskipTests -DnoDeploy jgitflow:hotfix-finish

# update develop poms back to pre merge state (Igloo sub-project)
git checkout dev
# update parents
mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Updating develop poms back to pre merge state (Igloo sub-project)"

git push origin master dev v$IGLOO_PARENT_VERSION
```

## org.iglooproject.webjars:boostrap4

Repository https://github.com/igloo-project/bootstrap4 is a lightweight wrapper to
repackage `org.webjars.npm:bootstrap` under a specific groupId/artifactId. This is
needed to allow embedding of different bootstrap version in the same igloo project
(needed if console is bootstrap 5 and application is still bootstrap 4).

If a new bootstrap version is needed, change project version and push modification on main branch. main branch is automatically published.

## Updating an Igloo-based project

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
