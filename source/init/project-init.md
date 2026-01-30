(quick-initialization)=

# Init project

Here is a step-by-step to initialize a new project from `basic-application`.

This initialization is performed by a script that wraps `maven-archetype-plugin` and `git`
commands. This script is needed as maven-archetype-plugin is not able to generate a working
project. Some workaround / fixes are needed.

```bash
# ensure mvn, git and xmllint commands are installed
git clone git@github.com:igloo-project/igloo-parent.git
cd igloo-parent
git checkout dev
cd tools/igloo-project-init
hatch run igloo-project-init --check-build --igloo-branch dev \
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

## Database

Use a Docker Compose file with correct db port (`<XX>32`):

```yaml
name: hello-world

services:
  bdd:
    image: "igloo-containers.tools.kobalt.fr/containers/postgres-igloo:15"
    ports:
      - "127.0.0.1:<XX>32:5432"
    volumes:
      - hello-world-bdd:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=hello_world
      - POSTGRES_USER=hello_world
      - POSTGRES_HOST_AUTH_METHOD=trust
      - TZ=Europe/Paris
      - PGTZ=Europe/Paris

volumes:
  hello-world-bdd:
```

Update db port for property `spring.datasource.url` in `configuration.properties` file.

## Filesystem

```bash
sudo mkdir /data/services/hello-world
sudo chown "${USER}." /data/services/hello-world
```

## Launch

Launch application with de launcher from `app` module (cf `start-class` in pom.xml, e.g. `basicapp.app.SpringBootMain`).
