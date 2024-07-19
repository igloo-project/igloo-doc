(quick-initialization)=

# Init project

Here is a step-by-step to initialize a new project from `basic-application`.

This initialization is performed by a script that wraps `maven-archetype-plugin` and `git`
commands. This script is needed as maven-archetype-plugin is not able to generate a working
project. Some workaround / fixes are needed.

```bash
# ensure mvn, git and xmllint commands are installed
git clone git@github.com:igloo-project/igloo-parent.git
git checkout igloo-boot-dev
cd tools/igloo-project-init
hatch run igloo-project-init --check-build --igloo-branch igloo-boot-dev \
  --target-url https://HOST/group/project --target-branch main \
  hello-world com.mygroup 1.0-SNAPSHOT helloworld \
  HelloWorld helloWorld "Hello World" hello_world
```

This command creates and pushes a projet to `https://HOST/group/project` repository. Project
is locally built before git push.

Remove `--target-url` and `--target-branch` not to push project. Add `--no-clean` argument.
Project is generated in the folder pointed by the log message :

```
INFO:igloo:Project com.mygroup:hello-world generated into /tmp/igloo-project-init-3nq6u513/hello-world/hello-world
```

Use `GIT_USER` and `GIT_PASSWORD` for target repository authentication. For gitlab token access, `GIT_USER` can
be any not-empty value, only `GIT_PASSWORD` is relevant.

If errors are raised, use `-v --debug`.

See `--help` details.

## Create and initialize the database

In this part, we will create the database with the proper user and schema, and we will fill it with a script.
Before performing the following commands, make sure you have PostgreSQL installed.

To create the database, we execute some commands directly in a terminal:

```bash
createuser -U postgres -P hello_world
createdb -U postgres -O hello_world hello_world
psql -U postgres hello_world
#Here you are connected to the database as the user postgres
DROP SCHEMA public;
\q
psql -U hello_world hello_world
#Here you are connected to the database as the user hello_world
CREATE SCHEMA hello_world;
```

:::{note}
Use the name of the project for the password (here: hello_world)
:::

After that we have to enable an option which will allow the project to create new entities in the database.

## Create and initialize filesystem

```bash
sudo mkdir /data/services/hello-world
sudo chown "${USER}." /data/services/hello-world
```

## Launch the webapp

Launch application with de launcher from `app` module (cf `start-class` in pom.xml, e.g. `basicapp.app.SpringBootMain`).
