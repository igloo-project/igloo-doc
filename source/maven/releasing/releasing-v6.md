# Releasing Igloo 6

```{note}
Releasing can be performed only for `igloo-parent` if `igloo-maven` / `igloo-commons` are untouched.
Just set IGLOO_XXX_VERSION accordingly and start procedure at `igloo-parent` step.
```

Commands listed below allow for each Igloo sub-project to update igloo dependencies version, perform commit,
and push to repository. Release is performed by CI/CD.

## Release

```bash
IGLOO_MAVEN_VERSION=6.0.0-AlphaX
IGLOO_COMMONS_VERSION=6.0.0-AlphaX
IGLOO_PARENT_VERSION=6.0.0-AlphaX

###############
# igloo-maven #
###############

cd ~/git/igloo-maven/
git checkout igloo-boot
git pull
git checkout igloo-boot-dev
git pull

# update igloo-maven.version property
java17 mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven dependency"
# perform jgitflow release
java17 mvn jgitflow:release-start
java17 mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin igloo-boot igloo-boot-dev v$IGLOO_MAVEN_VERSION

#################
# igloo-commons #
#################

cd ~/git/igloo-commons/
git checkout igloo-boot
git pull
git checkout igloo-boot-dev
git pull

# update parent
java17 mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
java17 mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven dependency"
# perform jgitflow release
java17 mvn jgitflow:release-start
java17 mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin igloo-boot igloo-boot-dev v$IGLOO_COMMONS_VERSION



################
# igloo-parent #
################

cd ~/git/igloo-parent/
git checkout igloo-boot
git pull
git checkout igloo-boot-dev
git pull

# update parents
java17 mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
java17 mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
java17 mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
# check changes with git diff
git commit -a -m "Update Igloo Maven and Commons dependencies"
# perform jgitflow release
java17 mvn jgitflow:release-start
java17 mvn -DskipTests -DnoDeploy jgitflow:release-finish
git push origin igloo-boot igloo-boot-dev v$IGLOO_PARENT_VERSION

########################################
# Switch back to snapshot dependencies #
########################################

IGLOO_MAVEN_VERSION_SNAPSHOT=6.0.0-SNAPSHOT
IGLOO_COMMONS_VERSION_SNAPSHOT=6.0.0-SNAPSHOT

#################
# igloo-commons #
#################

cd ~/git/igloo-commons/
git checkout igloo-boot-dev
# update parent
java17 mvn versions:update-parent -pl . -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
# update igloo.igloo-maven.version property
java17 mvn versions:set-property -Dproperty=igloo.igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
git commit -a -m "Switch back Igloo Maven to snapshot versions"
git push

################
# igloo-parent #
################

cd ~/git/igloo-parent/
git checkout igloo-boot-dev
# update parents
java17 mvn versions:update-parent -pl .,:igloo-parent-maven-configuration-common -DparentVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DskipResolution -DgenerateBackupPoms=false
# update igloo-maven.version, igloo-commons.version
java17 mvn versions:set-property -Dproperty=igloo-maven.version -DnewVersion=$IGLOO_MAVEN_VERSION_SNAPSHOT -DprocessAllModules=true -DgenerateBackupPoms=false
java17 mvn versions:set-property -Dproperty=igloo-commons.version -DnewVersion=$IGLOO_COMMONS_VERSION_SNAPSHOT -DprocessAllModules=true-DgenerateBackupPoms=false
git commit -a -m "Switch back Igloo Maven and Commons to snapshot versions"
git push
```

## Hotfix

```{note}
TODO
```

# org.iglooproject.webjars:boostrap4

```{note}
TODO
```

# Updating an Igloo-based project

```{note}
TODO
```

# Release a backport

```{note}
TODO
```