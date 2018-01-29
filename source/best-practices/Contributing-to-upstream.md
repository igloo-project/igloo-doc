# Contributing to upstream

## Hibernate

Our cloned repo: [https://github.com/igloo-project/hibernate-orm](https://github.com/igloo-project/hibernate-orm)

## Resources

 * [Full contribution procedure](https://github.com/hibernate/hibernate-orm/wiki/Contributing-Code) (also [here](https://github.com/igloo-project/hibernate-orm/blob/master/CONTRIBUTING.md), but it seems to be almost the same)
 * [How to develop using Eclipse (see below for more concrete explanations)](https://developer.jboss.org/wiki/ContributingToHibernateUsingEclipse)

## Developing

Hibernate uses Gradle. This means some pain if you haven't had to work with it in Eclipse, ever.

In order to build using gradle:

* Check that your default JRE is recent enough (tested with JRE8 on Hibernate 5.0, it should work)
* Generate the Eclipse `.project` files: `./gradlew clean eclipse --refresh-dependencies`
* Install the Gradle Eclipse plugin from this update site: `http://dist.springsource.com/release/TOOLS/gradle`
* Import the projects **as standard Eclipse projects** (Gradle import seems to mess things up, at least with Eclipse 4.3)
* Pray that everything builds right. I personally couldn't make every project compile, but what I had to work on did, so...

## Testing
### Running tests locally

Launch your test this way (example for a test in hibernate-core):

```
./gradlew :hibernate-core:test --tests 'MyTestClassName'
```

### Running tests locally, with database vendor dependency

If your test relies on a specific database vendor, you'll need to do the following in order to run it locally (examples for PostgreSQL):

* Specify the Dialect to use with the following option `-Dhibernate.dialect=org.hibernate.dialect.PostgreSQL9Dialect`
* Specify JDBC information: `-Dhibernate.connection.url=...`, `-Dhibernate.connection.username=...`, `-Dhibernate.connection.password=...`, `-Dhibernate.connection.driver_class=...`
* Provide the vendor-specific driver jar. I couldn't find a way to do it other than changing the `hibernate-core/hibernate-core.gradle` file and adding this line in the `dependencies` block: `testCompile( 'org.postgresql:postgresql:9.4-1200-jdbc41' )`

You'll end up launching your test this way (example for a test in hibernate-core):

```
./gradlew -Dhibernate.dialect=org.hibernate.dialect.PostgreSQL9Dialect -Dhibernate.connection.url=jdbc:postgresql://localhost:5432/hibernate_test -Dhibernate.connection.username=hibernate -Dhibernate.connection.password=hibernate -Dhibernate.connection.driver_class=org.postgresql.Driver :hibernate-core:test --tests 'MyTestClassName'
```

## Hibernate Search

Our cloned repo: [https://github.com/igloo-project/hibernate-search](https://github.com/igloo-project/hibernate-search)

### Resources

 * [Full contribution procedure](https://developer.jboss.org/wiki/ContributingtoHibernateSearch)
